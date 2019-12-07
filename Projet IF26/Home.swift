//
//  Home.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 30/11/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import SwiftUI

struct Home: View {
    let transactionDataViewModel: TransactionDataViewModel

    var body: some View {
        TabView {
            TransactionList(viewModel: transactionDataViewModel)
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Transactions")
                }

            Settings()
                .tabItem {
                    Image(systemName: "tv.fill")
                    Text("Paramètres")
                }
        }
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
