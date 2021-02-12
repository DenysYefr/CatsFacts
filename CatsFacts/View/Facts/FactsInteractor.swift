//
//  Interactor.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import CoreData
import Alamofire

typealias FactObserve = (([Fact], IndexPath?, NSFetchedResultsChangeType) -> Void)

class FactsInteractor: NSObject, Interactor {
    
    // MARK: - Typealias
    
    typealias PresenterType = FactsPresenter
    
    // MARK: - properties
    
    weak var presenter: FactsPresenter?
    var fetchedResultsController: NSFetchedResultsController<Fact>?
    var factsObserver: FactObserve?
    
    var dataDownloader: DataDownloader? = DataDownloader()
    
    // MARK: - Init and deinit
    
    required init(presenter: FactsPresenter) {
        super.init()
        self.presenter = presenter
        if dataDownloader?.isNetworkAvailable == true {
            dataDownloader?.start()
        }
        self.setupFRK()
    }
    
    deinit {
        factsObserver = nil
        fetchedResultsController = nil
        dataDownloader = nil
    }
    
    private func setupFRK() {
        fetchedResultsController = DataBase().createFactsFRK()
        fetchedResultsController?.delegate = self
        fetchData()
    }
    
    private func fetchData() {
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
}

extension FactsInteractor: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let objects = fetchedResultsController?.fetchedObjects else { return }
        factsObserver?(objects, newIndexPath, type)
    }
}
