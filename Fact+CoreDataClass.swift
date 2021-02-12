//
//  Fact+CoreDataClass.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//
//

import Foundation
import CoreData
import UIKit

@objc(Fact)
public class Fact: NSManagedObject {
    
    @NSManaged public var imageData: Data?
    @NSManaged public var text: String?
    
    func asCellModel() -> FactCellModel {
        var image: UIImage?
        if let data = imageData {
            image = UIImage(data: data)
        }
        
        return FactCellModel(title: text ?? "", image: image?.compress())
    }
}
