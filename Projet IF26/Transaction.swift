import SwiftUI
import Foundation
import GRDB

struct Transaction: Hashable, Identifiable {

    /// The transaction's unique identifier
    var id: Int64?

    /// The amount of the transaction (in cents)
    var amount: Int

    /// The transaction date (stored as an UNIX timestamp)
    var date: Int64

    /// The account the transaction was made with
    var account: Account

    /// The category the transaction belongs to
    var category: Category

    /// An one-line description of the transaction (shown on the list of transactions)
    var contents: String

    /// A multi-line description of the transaction (not shown on the list of transactions)
    var notes: String

    /// If `true`, the transaction is a transfer from an account to another
    var isTransfer: Bool

    /// The transaction type. This is only used for presentational purposes; it's not persisted into the database.
    enum Kind: String, CaseIterable, Codable, Hashable {
        case income = "Recette"
        case expense = "Dépense"
        case transfer = "Transfert"
    }

    /// The account the transaction was made with
    enum Account: String, CaseIterable, Codable, Hashable {
        case cash = "Espèces"
        case card = "Carte bancaire"
    }

    /// The category the transaction is part of
    enum Category: String, CaseIterable, Codable, Hashable {
        case food = "Nourriture"
        case leisure = "Loisirs"
        case other = "Divers"
    }

    init(
        id: Int64? = nil,
        amount: Int,
        date: Int64,
        account: Account,
        category: Category,
        contents: String,
        notes: String,
        isTransfer: Bool
    ) {
        self.id = id
        self.amount = amount
        self.date = date
        self.account = account
        self.category = category
        self.contents = contents
        self.notes = notes
        self.isTransfer = isTransfer
    }

    static let `default` = Self(
        id: 100,
        amount: 0,
        date: 0,
        account: .cash,
        category: .other,
        contents: "",
        notes: "",
        isTransfer: false
    )

    /// The amount as a formatted currency string (in French).
    /// For example, a transaction whose amount is `451` would return `4,51 €`.
    /// When discreet mode is enabled, the amount will be hidden.
    var formattedAmount: String {
        if UserDefaults.standard.bool(forKey: "discreetMode") {
            // Add the "+"/"-" symbol manually as we aren't using the number here.
            let prefix =
                isTransfer || amount == 0 ? "" // Transfer/neutral
                : amount > 0 ? "+" // Income
                : "-" // Expense

            return "\(prefix)##,## €"
        } else {
            let numberFormatter = NumberFormatter()
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = Locale(identifier: "fr_FR")

            // Add a "+" symbol for income to make it easier to discern.
            // Negative numbers are already prefixed with a "-", no need to do it manually.
            let prefix = !isTransfer && amount > 0 ? "+" : ""

            return "\(prefix)\(numberFormatter.string(from: NSNumber(value: Double(self.amount) * 0.01))!)"
        }
    }

    /// The color the amount should be displayed with.
    var amountColor: Color {
        return
            isTransfer || amount == 0 ? .gray // Transfer/neutral
            : amount > 0 ? .blue // Income
            : .red // Expense
    }

    /// The date as a formatted string (in French).
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "d MMMM yyyy"

        return dateFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(date))
        )
    }

    /// The date as a short formatted string (in French).
    var formattedShortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(date))
        )
    }
}

extension Transaction: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let amount = Column(CodingKeys.amount)
        static let date = Column(CodingKeys.date)
        static let category = Column(CodingKeys.category)
        static let contents = Column(CodingKeys.contents)
        static let notes = Column(CodingKeys.notes)
        static let isTransfer = Column(CodingKeys.isTransfer)
    }

    // Update a transaction ID after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
