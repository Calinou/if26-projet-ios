import SwiftUI

struct TransactionCreate: View {

    private enum Kind {
        case income
        case expense
        case transfer
    }

    @Binding var transaction: Transaction
    @State private var kind = Kind.income
    @State private var amount = ""
    @State private var date = Date()
    @State private var contents = ""
    @State private var notes = ""

    /// If `true`, display a message to tell the user the transaction has been saved.
    @State private var transactionSaved = false

    var body: some View {
        VStack {
            Picker(selection: $kind, label: Text("Type")) {
                Text("Recette").tag(Kind.income)
                Text("Dépense").tag(Kind.expense)
                Text("Transfert").tag(Kind.transfer)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 12)

            DatePicker(selection: $date, displayedComponents: .date) {
                Text("Date")
            }

            TextField("Montant (requis)", text: $amount).padding(.bottom, 8)
            TextField("Objet (requis)", text: $contents).padding(.bottom, 8)
            TextField("Notes", text: $notes).padding(.bottom, 8)

            Button(action: saveTransaction) {
                Text("Ajouter")
                    .accentColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(4)
            }
            .padding(.top, 32)
            // Amount and contents are required
                .disabled(amount.count == 0 || contents.count == 0)
                .opacity((amount.count == 0 || contents.count == 0) ? 0.5 : 1.0)

            if (transactionSaved) {
                Text("Transaction ajoutée !")
                    .padding()
                    .foregroundColor(.green)
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Nouvelle transaction", displayMode: .inline)
    }

    /// Persists a new transaction to the database.
    func saveTransaction() {
        // Handle French decimal separators
        let amountString = self.amount.replacingOccurrences(of: ",", with: ".")

        // The transaction kind isn't stored directly.
        // Instead, the transaction amount is stored as a positive or negative integer
        // depending on the transaction kind.
        try! Current.transactions().insert(
            Transaction(
                amount:
                    (self.kind == Kind.expense ? -1 : 1)
                        * Int((Double(amountString) ?? 0.0) * 100.0),
                date: Int64(self.date.timeIntervalSince1970),
                account: .cash,
                category: .other,
                contents: self.contents,
                notes: self.notes,
                isTransfer: self.kind == Kind.transfer
            )
        )

        transactionSaved = true

        // Reset all fields so the user can enter another transaction more easily
        date = Date()
        amount = ""
        contents = ""
        notes = ""
        kind = .income
    }
}

struct TransactionCreate_Previews: PreviewProvider {

    static var previews: some View {
        TransactionCreate(transaction: .constant(.default))
    }
}
