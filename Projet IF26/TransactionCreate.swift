import SwiftUI

struct TransactionCreate: View {

    @Binding var transaction: Transaction
    @State private var kind = Transaction.Kind.income
    @State private var amount = ""
    @State private var date = Date()
    @State private var account = Transaction.Account.cash
    @State private var category = Transaction.Category.food
    @State private var contents = ""
    @State private var notes = ""

    /// If `true`, display a message to tell the user the transaction has been saved.
    @State private var transactionSaved = false

    var body: some View {
        VStack {
            Picker(selection: $kind, label: Text("Type")) {
                Text("Recette").tag(Transaction.Kind.income)
                Text("Dépense").tag(Transaction.Kind.expense)
                Text("Transfert").tag(Transaction.Kind.transfer)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 12)

            DatePicker(selection: $date, displayedComponents: .date) {
                Text("Date")
            }

            TextField("Montant (requis)", text: $amount).padding(.bottom, 8)

            Picker(selection: $account, label: Text("Compte")) {
                Text("Espèces").tag(Transaction.Account.cash)
                Text("Carte bancaire").tag(Transaction.Account.card)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 12)

            Picker(selection: $category, label: Text("Catégorie")) {
                Text("Nourriture").tag(Transaction.Category.food)
                Text("Loisirs").tag(Transaction.Category.leisure)
                Text("Autre").tag(Transaction.Category.other)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 12)

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

            if transactionSaved {
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
        try! current.transactions().insert(
            Transaction(
                amount:
                    (self.kind == Transaction.Kind.expense ? -1 : 1)
                        * Int((Double(amountString) ?? 0.0) * 100.0),
                date: Int64(self.date.timeIntervalSince1970),
                account: self.account,
                category: self.category,
                contents: self.contents,
                notes: self.notes,
                isTransfer: self.kind == Transaction.Kind.transfer
            )
        )

        transactionSaved = true

        // Reset all fields so the user can enter another transaction more easily
        kind = .income
        amount = ""
        date = Date()
        account = .cash
        category = .food
        contents = ""
        notes = ""
    }
}

struct TransactionCreate_Previews: PreviewProvider {

    static var previews: some View {
        TransactionCreate(transaction: .constant(.default))
    }
}
