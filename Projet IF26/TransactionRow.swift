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

            Text(transaction.formattedAmount)
                .foregroundColor(transaction.amountColor)
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
