//
//  DataDownloader.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation
import Alamofire

class DataDownloader {
    
    var isNetworkAvailable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func start() {
        DataBase().deleteAllData()
        requestFacts { [weak self] facts in
            guard let self = self else { return }
            self.downloadImages(facts: facts)
        }
    }
    
    private func downloadImages(facts: [FactResponseModel]) {
        ImageDownloadService().downloadBatchOfImages(with: facts)
    }
    
    private func requestFacts(completion: @escaping ([FactResponseModel]) -> Void) {
        NetworkService().requestFacts { (result) in
            switch result {
            case .success(let facts):
                completion(facts)
            case .failure(let error):
                print(error)
            }
        }
    }
}
