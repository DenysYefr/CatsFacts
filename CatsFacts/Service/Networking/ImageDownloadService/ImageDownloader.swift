//
//  ImageDownloader.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation
import UIKit

class ImageDownloader: Operation {
    
    private let fact: String
    
    init(fact: String) {
        self.fact = fact
        super.init()
    }
    
    override func main() {
        
        guard !isCancelled else { return }
        NetworkService().downloadImage { (result) in
            switch result {
            case .success(let image):
                DataBase().createFactModel(with: image, text: self.fact)
            case .failure(let error):
                print(error)
                self.cancel()
            }
        }
    }
}
