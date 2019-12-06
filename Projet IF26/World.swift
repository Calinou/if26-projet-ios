//
//  World.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 11/11/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

import GRDB

/// Dependency injection
struct World {
    /// Access to the Transactions database.
    func transactions() -> Transactions { Transactions(database: database()) }

    /// The database, private so that only high-level operations exposed by
    /// `transactions`are available to the rest of the application.
    private var database: () -> DatabaseWriter

    /// Creates a World with a database.
    init(database: @escaping () -> DatabaseWriter) {
        self.database = database
    }
}

var Current = World(database: { fatalError("Database is uninitialized.") })
