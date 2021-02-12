//
//  ImageURLResponseModel.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation

class ImageURLResponseModel: ResponseModel {
    
    var file: String
    
    enum CodingKeys: String, CodingKey {
        case file
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        file = try container.decode(String.self, forKey: .file)
        super.init()
    }
}
