//
//  NetworkService.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

typealias ImageDownloadResult = ((Result<UIImage, Error>) -> Void)
typealias FactsDownloadResult = ((Result<[FactResponseModel], Error>) -> Void)

enum NetworkServiceError: Error {
    case decodingImageError
}

class NetworkService {
    
    public func requestFacts(completion: @escaping FactsDownloadResult) {
        CoreNetwork().request(requestModel: nil, router: .facts, responseModel: [FactResponseModel].self) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }
    
    public func downloadImage(completion: @escaping ImageDownloadResult) {
        requestImageURL { (result) in
            switch result {
            case .success(let model):
                CoreNetwork().download(url: URL(string: model.file)!) { (result) in
                    switch result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            completion(.failure(NetworkServiceError.decodingImageError))
                            return
                        }
                        completion(.success(image))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func requestImageURL(completion: @escaping (Result<ImageURLResponseModel, Error>) -> Void) {
        CoreNetwork().request(requestModel: nil, router: .image, responseModel: ImageURLResponseModel.self) { (result) in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
