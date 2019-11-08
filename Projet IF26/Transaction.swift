//
//  Transaction.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI
import Foundation

struct Transaction: Hashable, Codable, Identifiable {
    /// The transaction's unique identifier
    var id: Int
    
    /// The amount of the transaction (in cents)
    var amount: Int
    
    var amountString: String {
        get {
            String(amount)
        }
        set(newAmount) {
            amount = Int(newAmount) ?? 0
        }
    }
    
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
}
