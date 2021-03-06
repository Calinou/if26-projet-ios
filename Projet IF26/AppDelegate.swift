import UIKit
import Combine
import GRDB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Set up the current world
        let dbPool = try! setupDatabase(application)
        current = World(database: { dbPool })

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // MARK: Database

    private func setupDatabase(_ application: UIApplication) throws -> DatabasePool {
        let databaseURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
        let dbPool = try AppDatabase.openDatabase(atPath: databaseURL.path)

        // Be a nice iOS citizen, don't consume too much memory
        dbPool.setupMemoryManagement(in: application)

        return dbPool
    }
}
