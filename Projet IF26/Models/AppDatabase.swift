import GRDB

/// An array of example values for the Transaction `contents` field (used for database seeding)
let contents = [
    "Pain",
    "Chaussures",
    "Courses",
    "Soda",
    "Cinéma",
    "Vélo",
    "Disque dur externe",
    "Café",
    "Match de football",
]

/// An array of possible values for the Transaction `notes`field (used for database seeding)
let notes = [
    // Notes can be empty
    "",
    "Lorem ipsum",
    "Une description très longue qui peut faire plusieurs lignes...",
]

/// A type responsible for initializing the application database.
///
/// See AppDelegate.setupDatabase()
struct AppDatabase {

    /// Creates a fully initialized database at path
    static func openDatabase(atPath path: String) throws -> DatabasePool {
        // Connect to the database
        let dbPool = try DatabasePool(path: path)

        // Define the database schema
        try migrator.migrate(dbPool)

        return dbPool
    }

    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#migrations
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        migrator.registerMigration("createPlayer") { db in
            // Create a table
            try db.create(table: "transaction") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("amount", .integer).notNull()
                t.column("date", .datetime).notNull()
                t.column("account", .integer).notNull()
                t.column("category", .integer).notNull()
                t.column("contents", .text).notNull()
                t.column("notes", .text)
                t.column("isTransfer", .boolean).notNull()
            }
        }

        migrator.registerMigration("fixtures") { db in
            // Populate the players table with random data
            for _ in 0..<8 {
                var player = Transaction(
                    id: nil,
                    amount: Int.random(in: -300...300) * 10,
                    date: Int64.random(in: 1400000000...1500000000),
                    account: Transaction.Account.allCases.randomElement()!,
                    category: Transaction.Category.allCases.randomElement()!,
                    contents: contents.randomElement()!,
                    notes: notes.randomElement()!,
                    isTransfer: false
                )
                try player.insert(db)
            }
        }

//        // Migrations for future application versions will be inserted here:
//        migrator.registerMigration(...) { db in
//            ...
//        }

        return migrator
    }
}
