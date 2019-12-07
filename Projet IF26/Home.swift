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
