import SwiftUI

struct TransactionRow: View {

    var transaction: Transaction

    var body: some View {
        HStack {
            VStack {
                Text(transaction.category.rawValue)
                    // Increase the line height slightly
                    .frame(width: 80.0, height: 23.0)
                    .foregroundColor(.gray)

                Text(transaction.formattedShortDate)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }

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

            Text(transaction.formattedAmount)
                .foregroundColor(transaction.amountColor)
        }
        .padding(.vertical, 6)
    }
}

struct TransactionRow_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            TransactionRow(transaction: Transaction(
                amount: 50000,
                date: 1500000000,
                account: .card,
                category: .other,
                contents: "Exemple de recette",
                notes: "Quelques notes...",
                isTransfer: false
            ))
            TransactionRow(transaction: Transaction(
                amount: -1515,
                date: 1500000000,
                account: .card,
                category: .other,
                contents: "Exemple de dépense",
                notes: "Quelques notes...",
                isTransfer: false
            ))
            TransactionRow(transaction: Transaction(
                amount: 1337,
                date: 1500000000,
                account: .card,
                category: .other,
                contents: "Exemple de transfert",
                notes: "Quelques notes...",
                isTransfer: true
            ))
        }
        .previewLayout(.fixed(width: 360, height: 65))
    }
}
