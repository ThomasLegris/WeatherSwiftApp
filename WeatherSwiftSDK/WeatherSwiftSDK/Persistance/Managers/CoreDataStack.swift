//
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 26/09/2022.
//

import Foundation
import CoreData

/// Manager which handle whole core stack (Persistent container: context, managed object)
public final class CoreDataStack {
    // MARK: - Private Properties
    private lazy var persistentContainer: NSPersistentContainer = {
        // Notes: Check bundle url because CoreDataModel is not in main one (aka `WeatherSwiftApp`)
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: Constants.dataModelName,
                                                             withExtension: Constants.fileExtension) else {
            fatalError("Error loading model from bundle")
        }

        guard let momFile = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let container = NSPersistentContainer(name: Constants.dataModelName, managedObjectModel: momFile)

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Private Enums
    private enum Constants {
        static let dataModelName: String = "CoreDataModel"
        static let fileExtension: String = "momd"
    }

    // MARK: - Internal Properties
    /// Notes: should stay internal to not be exposed to `main` module.
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }

    static let shared: CoreDataStack = CoreDataStack()

    // MARK: - Init
    private init() { }
}
