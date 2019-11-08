//
//  Transactions.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 11/11/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

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
