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
            .navigationBarTitle("Transactions", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: TransactionCreate(transaction: .constant(.default))) {
                    Text("Ajouter")
                }
                // Make the navigation link easier to click
                .padding(.vertical)
            )
        }

    }
}

//struct TransactionList_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionList()
//    }
//}
