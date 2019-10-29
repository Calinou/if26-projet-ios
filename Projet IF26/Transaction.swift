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
    var id: Int
    var amount: Int
    var date: Int
    var account: Account
    var category: Category
    var contents: String
    var notes: String
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
