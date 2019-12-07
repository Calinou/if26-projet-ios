import SwiftUI

struct TransactionDetail: View {
    var transaction: Transaction

    /// The first column's width (with the property names).
    let keyWidth: CGFloat = 100

    var body: some View {
        Form {
            HStack {
                Text("Type").fontWeight(.bold).frame(width: keyWidth)
                Text(
                    transaction.isTransfer ? "Transfert"
                    : transaction.amount > 0 ? "Recette"
                    : "Dépense"
                )
            }
            HStack {
                Text("Montant").fontWeight(.bold).frame(width: keyWidth)
                Text(transaction.formattedAmount)
                    .foregroundColor(transaction.amountColor)
            }
            HStack {
                Text("Date").fontWeight(.bold).frame(width: keyWidth)
                Text(transaction.formattedDate)
            }
            HStack {
                Text("Compte").fontWeight(.bold).frame(width: keyWidth)
                Text(transaction.account.rawValue)
            }
            HStack {
                Text("Catégorie").fontWeight(.bold).frame(width: keyWidth)
                Text(transaction.category.rawValue)
            }
            HStack {
                Text("Objet").fontWeight(.bold).frame(width: keyWidth)
                Text(transaction.contents)
            }
            HStack {
                Text("Notes").fontWeight(.bold).frame(width: keyWidth)
                Text(!transaction.notes.isEmpty ? transaction.notes : "Pas de notes")
                    .foregroundColor(
                        !transaction.notes.isEmpty ? .black : .init(hue: 0, saturation: 0, brightness: 0.7)
                    )
            }
        }
        .navigationBarTitle(Text(transaction.contents), displayMode: .inline)
    }
}

struct TransactionDetail_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetail(transaction: transactionData[0])
    }
}
