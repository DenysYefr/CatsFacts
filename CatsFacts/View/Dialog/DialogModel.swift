//
//  DialogModel.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation
import UIKit

struct DialogModel {
    
    var text: String?
    var image: UIImage?
    
    init(with fact: Fact) {
        self.text = fact.text
        if let data = fact.imageData {
            self.image = UIImage(data: data)
        }
    }
}
