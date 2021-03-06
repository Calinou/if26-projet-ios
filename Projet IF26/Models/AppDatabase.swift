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

        migrator.registerMigration("createTransactionsTable") { db in
            // Create a table
            try db.create(table: "transaction") { table in
                table.autoIncrementedPrimaryKey("id")
                table.column("amount", .integer).notNull()
                table.column("date", .datetime).notNull()
                table.column("account", .integer).notNull()
                table.column("category", .integer).notNull()
                table.column("contents", .text).notNull()
                table.column("notes", .text)
                table.column("isTransfer", .boolean).notNull()
            }
        }

        return migrator
    }
}
