//
//  CoreNetwork.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import Alamofire

typealias NetworkResponse<ResponseModelType: Decodable> = ((Result<ResponseModelType, Error>) -> Void)
typealias NetworkDataResponse = ((Result<Data, Error>) -> Void)

enum NetworkError: Error {
    case unableToDecode
    case unableGetPath
}

class CoreNetwork {
    
    static let networkQueue = DispatchQueue(label: "com.catsfacts.network.queue")
    
    static let session = Alamofire.Session()
    
    func request<ResponseModelType: Decodable>(requestModel: RequestModel?,
                                                   router: NetworkRouter,
                                                   responseModel: ResponseModelType.Type,
                                                   completion: @escaping NetworkResponse<ResponseModelType>) {
        guard let path = router.path else {
            completion(.failure(NetworkError.unableGetPath))
            return
        }
        Self.networkQueue.async {
            Self.session.request(path, method: router.method, parameters: requestModel, headers: router.headers).responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let result: ResponseModelType? = DataParser.decode(data: data)
                    guard let _result = result else {
                        completion(.failure(NetworkError.unableToDecode))
                        return
                    }
                    completion(.success(_result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func download(url: URL, completion: @escaping NetworkDataResponse) {
        Self.networkQueue.async {
            Self.session.download(url).responseData { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
