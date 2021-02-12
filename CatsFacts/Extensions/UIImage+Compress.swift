//
//  UIImage+Compress.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation
import UIKit

extension UIImage {
    
    func compress() -> UIImage? {
        guard let jpegData = self.jpegData(compressionQuality: 0.25) else { return nil }
        let compressedImage = UIImage(data: jpegData)
        return compressedImage
    }
}
