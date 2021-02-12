//
//  FactResponseModel.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation

class FactResponseModel: ResponseModel {
    
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        super.init()
    }
}
