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
        }
        .navigationBarTitle(Text(viewModel.title))
    }
}

//struct TransactionList_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionList()
//    }
//}
