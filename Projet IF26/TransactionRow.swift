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
                .foregroundColor(.gray)
                .frame(width: 80.0)

            VStack(alignment: .leading) {
                Text(transaction.contents)
                    // Increase the line height slightly
                    .frame(height: 23.0)
                Text(transaction.account.rawValue)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.leading)

            Spacer()

            Text(
                String(
                    // Add a "+" symbol for income to make it easier to discern.
                    // Negative numbers are already prefixed with a "-", no need to do it manually.
                    format: "\(!transaction.isTransfer && transaction.amount > 0 ? "+" : "")%.2f €",
                    Double(transaction.amount) / 100
                )
            ).foregroundColor(
                transaction.isTransfer || transaction.amount == 0 ? .gray :
                transaction.amount > 0 ? .blue :
                .red
            )
        }
        .padding()
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionRow(transaction: transactionData[0]) // Income
            TransactionRow(transaction: transactionData[1]) // Expense
            TransactionRow(transaction: transactionData[3]) // Transfer
        }
        .previewLayout(.fixed(width: 360, height: 65))
    }
}
