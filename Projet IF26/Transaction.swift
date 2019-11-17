//
//  Transaction.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI
import Foundation
import GRDB

struct Transaction: Hashable, Identifiable {
    /// The transaction's unique identifier
    var id: Int64?

    /// The amount of the transaction (in cents)
    var amount: Int

    /// The transaction date (stored as an UNIX timestamp)
    var date: Int

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

    enum Account: String, CaseIterable, Codable, Hashable {
        case cash = "Espèces"
        case card = "Carte bancaire"
    }

    enum Category: String, CaseIterable, Codable, Hashable {
        case food = "Nourriture"
        case leisure = "Loisirs"
        case other = "Divers"
    }

    init(
        id: Int64?,
        amount: Int,
        date: Int,
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
