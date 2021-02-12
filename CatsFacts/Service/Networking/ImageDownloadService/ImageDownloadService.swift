//
//  ImageDownloader.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation

class ImageDownloadService {
    
    private let kBatchCount = 10
    private lazy var pendingOperations: PendingDownloadOpertions = PendingDownloadOpertions()
    
    func downloadBatchOfImages(with facts: [FactResponseModel]) {
        
        for _ in 0..<kBatchCount {
            pendingOperations.uploadQueue.addOperation(ImageDownloader(fact: facts.randomElement()?.text ?? ""))
        }
    }
}
