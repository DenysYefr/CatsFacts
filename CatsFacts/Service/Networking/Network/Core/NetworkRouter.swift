//
//  Router.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import Alamofire

enum NetworkRouter {
    
    case image
    case facts
    
    var path: URL? {
        switch self {
        case .image: return App.imageURL
        case .facts: return App.factsURL
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .image: return .get
        case .facts: return .get
        }
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
}
