import Combine
import GRDBCombine

class TransactionDataViewModel {

    @Published private var transactionData = Transactions.TransactionData.empty
    private var cancellables: [AnyCancellable] = []

    init() {
        Current.transactions()
            .transactionDataPublisher()
            // Perform a synchronous initial fetch
            .fetchOnSubscription()
            // Ignore database errors
            .catch { _ in Empty() }
            .sink { [unowned self] in self.transactionData = $0 }
            .store(in: &cancellables)
    }
}

// MARK: UIViewController support

extension TransactionDataViewModel {

    /// A publisher for all transactions.
    var transactionsPublisher: AnyPublisher<[Transaction], Never> {
        $transactionData
            .map { $0.transactions }
            .eraseToAnyPublisher()
    }
}

// MARK: SwiftUI support

extension TransactionDataViewModel: ObservableObject {

    /// The list of transactions.
    var transactions: [Transaction] {
        transactionData.transactions
    }
}
