//
//  PendingDownloadOperations.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation

class PendingDownloadOpertions {
    
    lazy var uploadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.catsfacts.downloadImages.queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
