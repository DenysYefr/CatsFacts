//
//  CoreDataStack.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation
import CoreData

typealias CoreDataClosure = (NSManagedObjectContext) -> ()

class CoreDataStack {
    
    private let _main: NSManagedObjectContext
    private let _background: NSManagedObjectContext
    private let _coordinator: NSPersistentStoreCoordinator
    
    static let shared = CoreDataStack()
    
    private init() {
        _coordinator = CoreDataStack.coordinator()
        _main = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        _main.persistentStoreCoordinator = _coordinator
        _main.undoManager = UndoManager()
        
        _background = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        _background.persistentStoreCoordinator = _coordinator
    }
    
    static var main: NSManagedObjectContext {
        return shared._main
    }
    
    static var background: NSManagedObjectContext {
        return shared._background
    }
        
    static var contextForCurrentThread: NSManagedObjectContext {
        if Thread.isMainThread {
            return shared._main
        } else {
            return shared._background
        }
    }
    
    static func save(context: @escaping CoreDataClosure) {
                
        background.perform {
            context(background)
            save(context: background)
        }
    }
    
    static func deleteAllObjects<Type: NSManagedObject>(type: Type.Type) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Type.self))
        let context = background
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                }
            }
            save(context: context)
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
}

private extension CoreDataStack {
    
    private static func coordinator() -> NSPersistentStoreCoordinator {
        
        let options = [
            NSMigratePersistentStoresAutomaticallyOption : true,
            NSInferMappingModelAutomaticallyOption : true
        ]
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: Self.model)
        do { try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                        configurationName: nil,
                                        at: Self.storeUrl,
                                        options: options)
        } catch let error as NSError {
            
            fatalError("ERROR: \(error), \(error.userInfo)")
        }
        return coordinator
    }
    
    
    private static var storeUrl: URL? {
        
        guard let documentsDirectory = try? FileManager.default.url(for: .documentDirectory,
                                                                    in: .userDomainMask,
                                                                    appropriateFor: nil,
                                                                    create: true)
            else {
                return nil
        }

        return documentsDirectory.appendingPathComponent("CatsFacts.sqlite")
    }
    
    private static var model: NSManagedObjectModel {
        
        guard let modelUrl = Bundle.main.url(forResource: "CatsFactsDataModel", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelUrl) else
        {
            fatalError("Can't load CoreData Model")
        }
        return model
    }
    
    @discardableResult
    private static func save(context: NSManagedObjectContext) -> Bool {
        
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                debugPrint(error)
                return false
            }
        }
        return false
    }
}
