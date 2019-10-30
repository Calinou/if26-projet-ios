//
//  TransactionDetail.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct TransactionDetail: View {
    @EnvironmentObject var userData: UserData
    @Binding var transaction: Transaction
    
    var transactionIndex: Int {
        userData.transactions.firstIndex(where: { $0.id == transaction.id }) ?? -1
    }
    
    var body: some View {
        List {
            Text("Transaction n°\(transaction.id)")
            
            VStack(alignment: .leading) {
                Text("Type").bold()
//                Picker("Type") {
//                    ForEach(Transaction.Kind.AllCases, id: \.self) { transferKind in
//                        Text(transferKind.rawValue)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
            }
            
            HStack {
                Text("Montant").bold()
                Divider()
                TextField("Montant", text: $transaction.amountString)
                    .keyboardType(.decimalPad)
            }
            
            VStack(alignment: .leading) {
                Text("Date").bold()
//                DatePicker(
//                    "Date",
//                    selection: $transaction.date,
//                    displayedComponents: .date
//                )
            }
            Text(transaction.account.rawValue)
            Text(transaction.category.rawValue)
            Text(transaction.contents)
            Text(transaction.notes)
            Text(String(transaction.isTransfer))
        }
        .navigationBarTitle(Text(transaction.contents), displayMode: .inline)
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetail(transaction: .constant(.default))
    }
}
