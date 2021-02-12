//
//  DataParser.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation

class DataParser {
    
    static func decode<Model: Decodable>(data: Any) -> Model? {
        do {
            let json = try JSONSerialization.data(withJSONObject: data, options: [])
            let result = try JSONDecoder().decode(Model.self, from: json)
            return result
        } catch let error as NSError {
            print(error.userInfo)
            return nil
        }
    }
}
