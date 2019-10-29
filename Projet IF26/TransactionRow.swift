//
//  TransactionRow.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            Text(transaction.category.rawValue)
            Spacer()
            VStack {
                Text(transaction.contents)
                Text(transaction.account.rawValue)
            }
            Spacer()
            Text(String(format: "%.2f €", Double(transaction.amount) / 100))
        }
        .padding()
        
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: transactionData[0])
    }
}
