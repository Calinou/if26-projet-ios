//
//  TransactionList.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
    @ObservedObject var viewModel: TransactionDataViewModel

    var body: some View {
        NavigationView {
            List(viewModel.transactions) { transaction in
                NavigationLink(destination: TransactionDetail(transaction: transaction)) {
                    TransactionRow(transaction: transaction)
                }
            }
            .navigationBarTitle(Text(viewModel.title), displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: TransactionCreate(transaction: .constant(.default))) {
                    Text("Ajouter")
                }
            )
        }

    }
}

//struct TransactionList_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionList()
//    }
//}
