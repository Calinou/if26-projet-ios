//
//  TransactionDataViewModel.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 11/11/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

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

    private static func title() -> String {
        "Transactions"
    }
}

// MARK: UIViewController support

extension TransactionDataViewModel {
    /// A publisher for the transactions list's title.
    var titlePublisher: AnyPublisher<String, Never> {
        $transactionData
            .map { _ in Self.title() }
            .eraseToAnyPublisher()
    }

    /// A publisher for all transactions.
    var transactionsPublisher: AnyPublisher<[Transaction], Never> {
        $transactionData
            .map { $0.transactions }
            .eraseToAnyPublisher()
    }
}

// MARK: SwiftUI support

extension TransactionDataViewModel: ObservableObject {
    /// The transactions list's title.
    var title: String {
        Self.title()
    }

    /// The list of transactions.
    var transactions: [Transaction] {
        transactionData.transactions
    }
}
