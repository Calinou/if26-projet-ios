//
//  TransactionDetail.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct TransactionCreate: View {
    @Binding var transaction: Transaction
    
    var body: some View {
        VStack {
            //TextField("Date", text: $transaction.date)
            //TextField("Montant", text: $transaction.amount)
            TextField("Objet", text: $transaction.contents)
            TextField("Notes", text: $transaction.notes)
            Button("Ajouter") {
                // TODO: Use values from the above form
                try! Current.transactions().insert(
                    Transaction(
                        amount: 5000,
                        date: 1500000000,
                        account: .cash,
                        category: .other,
                        contents: "Addition",
                        notes: "Cher",
                        isTransfer: false
                    )
                )
            }
        }
        .navigationBarTitle("Nouvelle transaction")
    }
}

struct TransactionCreate_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCreate(transaction: .constant(.default))
    }
}
