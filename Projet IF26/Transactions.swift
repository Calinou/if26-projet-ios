import Combine
import GRDB
import GRDBCombine
import Dispatch

/// Transactions is responsible for high-level operations on the transactions database.
struct Transactions {

    private let database: DatabaseWriter

    init(database: DatabaseWriter) {
        self.database = database
    }

    /// Inserts the transaction object into the database.
    func insert(_ transaction: Transaction) throws {
        try database.write { db in
            // Make a mutable copy as required by `insert()`
            var transaction2 = transaction
            try transaction2.insert(db)
        }
    }

    /// Deletes the transaction object from the database (if it exists in the database).
    func delete(_ transaction: Transaction) throws {
        try database.write { db in
            try transaction.delete(db)
        }
    }

    struct TransactionData {

        /// All transactions
        var transactions: [Transaction]

        static let empty = TransactionData(transactions: [])
    }

    func transactionDataPublisher() -> DatabasePublishers.Value<TransactionData> {
        ValueObservation
            .tracking(value: { db in
                let transactions = try Transaction.fetchAll(db)

                return TransactionData(transactions: transactions)
            })
            .publisher(in: database)
    }
}
