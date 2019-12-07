import Combine
import UIKit

class TransactionListController: UITableViewController {
    var viewModel = TransactionDataViewModel()
    private var transactions: [Transaction] = []
    private var needsTransactionAnimation = false
    private var cancellables: [AnyCancellable] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel
            .transactionsPublisher
            .sink { [unowned self] in self.updateTransactions($0) }
            .store(in: &cancellables)

//        viewModel
//            .titlePublisher
//            .assign(to: "title", on: navigationItem)
//            .store(in: &cancellables)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = false
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = transaction.contents
        cell.detailTextLabel?.text = "\(transaction.amount)"

        return cell
    }

    private func updateTransactions(_ transactions: [Transaction]) {
        // Don't animate the first update
        if !needsTransactionAnimation {
            needsTransactionAnimation = true
            self.transactions = transactions
            tableView.reloadData()
            return
        }

        // Compute the difference between the current and new list of transactions
        let difference = transactions
            .difference(from: self.transactions)
            .inferringMoves()

        // Apply changes to the table view
        tableView.performBatchUpdates({
            self.transactions = transactions

            for change in difference {
                switch change {
                case let .remove(offset, _, associatedWith):
                    if let associatedWith = associatedWith {
                        self.tableView.moveRow(
                            at: IndexPath(row: offset, section: 0),
                            to: IndexPath(row: associatedWith, section: 0))
                    } else {
                        self.tableView.deleteRows(
                            at: [IndexPath(row: offset, section: 0)],
                            with: .automatic)
                    }
                case let .insert(offset, _, associatedWith):
                    if associatedWith == nil {
                        self.tableView.insertRows(
                            at: [IndexPath(row: offset, section: 0)],
                            with: .automatic)
                    }
                }
            }
        }, completion: nil)
    }
}
