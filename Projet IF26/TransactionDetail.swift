//
//  TransactionDetail.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct TransactionDetail: View {
    var transaction: Transaction
    
    var body: some View {
        VStack {
            Text(String(transaction.id))
            Text(String(format: "%.2f €", Double(transaction.amount) / 100))
            Text(String(transaction.date))
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
        TransactionDetail(transaction: transactionData[0])
    }
}
