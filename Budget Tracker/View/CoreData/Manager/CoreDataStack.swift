//
//  CoreDataStack.swift
//  Budget Tracker
//
//  Created by Wang Po on 22/9/2023.
//

import Foundation
import CoreData

/// `CoreDataStack` manages the Core Data stack setup and provides utility methods for database operations
class CoreDataStack {
    
    private let modelName: String
    /// The managed object context associated with the main queue
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    /// Initializes a new CoreDataStack
    /// - Parameter modelName: The name of the Core Data model
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    /// The persistent container for Core data
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    /// Saves changes in the managed object context, if any
    func saveContext() {
        guard managedContext.hasChanges else {return}
        do{
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    /// Updats the managed object context
    func updateContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    /// Discards any uncommitted changes to managed objects
    func clearChange() {
        managedContext.rollback()
    }
  /// Delete all history content from the database, comment out this at the moment
    func deleteAllHistory() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: HistoryContent.self))
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        do {
//            try storeContainer.persistentStoreCoordinator.execute(deleteRequest, with: managedContext)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
    }
}
