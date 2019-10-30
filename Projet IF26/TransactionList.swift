//
//  TransactionList.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 29/10/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.transactions) { transaction in
                    NavigationLink(
                        destination: TransactionDetail(transaction: transaction)
                            .environmentObject(self.userData)
                    ) {
                        TransactionRow(transaction: transaction) // FIXME
                    }
                }
            }
//            List(userData.transactions) { transaction in
//                NavigationLink(
//                    destination: TransactionDetail(transaction: transaction)
//                        .environmentObject(self.userData)
//                ) {
//                    TransactionRow(transaction: transaction)
//                }
//            }
        }
        .navigationBarTitle(Text("Transactions"))
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList()
            .environmentObject(UserData())
    }
}