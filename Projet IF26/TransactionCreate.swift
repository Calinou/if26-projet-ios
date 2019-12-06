//
//  TransactionDetail.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct TransactionCreate: View {

    private enum Kind {
        case income
        case expense
        case transfer
    }

    @Binding var transaction: Transaction
    @State private var kind = Kind.income
    @State private var amount = ""
    @State private var date = Date()
    @State private var contents = ""
    @State private var notes = ""

    var body: some View {
        VStack {
            DatePicker(selection: $date, displayedComponents: .date) {
                Text("Date")
            }

            Picker(selection: $kind, label: Text("Type")) {
                Text("Recette").tag(Kind.income)
                Text("Dépense").tag(Kind.expense)
                Text("Transfert").tag(Kind.transfer)
            }.pickerStyle(SegmentedPickerStyle())

            TextField("Montant", text: $amount)
            TextField("Objet", text: $contents)
            TextField("Notes", text: $notes)

            Button(action: saveTransaction) {
                Text("Ajouter")
                    .accentColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(4)
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Nouvelle transaction", displayMode: .inline)
    }

    /// Persists a new transaction to the database.
    func saveTransaction() {
        // The transaction kind isn't stored directly.
        // Instead, the transaction amount is stored as a positive or negative integer
        // depending on the transaction kind.
        try! Current.transactions().insert(
            Transaction(
                amount:
                    (self.kind == Kind.expense ? -1 : 1)
                    * Int((Double(self.amount) ?? 0.0) * 100.0),
                date: Int64(self.date.timeIntervalSince1970),
                account: .cash,
                category: .other,
                contents: self.contents,
                notes: self.notes,
                isTransfer: self.kind == Kind.transfer
            )
        )
    }
}

struct TransactionCreate_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCreate(transaction: .constant(.default))
    }
}
