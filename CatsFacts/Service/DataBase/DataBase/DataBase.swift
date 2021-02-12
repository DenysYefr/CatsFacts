//
//  DataBase.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation
import UIKit
import CoreData

class DataBase {
    
    static let factsFetchRequest = NSFetchRequest<Fact>.init(entityName: String(describing: Fact.self))
    
    func createFactModel(with image: UIImage, text: String) {
        CoreDataStack.save { context in
            let entity = Fact(context: context)
            entity.imageData = image.pngData()
            entity.text = text
        }
    }
    
    func createFactsFRK() -> NSFetchedResultsController<Fact> {
        let fetchRequest = Self.factsFetchRequest
        fetchRequest.sortDescriptors = []
        let controller = NSFetchedResultsController.init(fetchRequest: fetchRequest,
                                                         managedObjectContext: CoreDataStack.background,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil)
        return controller
    }
    
    func deleteAllData() {
        CoreDataStack.deleteAllObjects(type: Fact.self)
    }
}
