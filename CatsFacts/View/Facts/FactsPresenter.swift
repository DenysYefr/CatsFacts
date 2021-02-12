//
//  Presenter.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation

class FactsPresenter: Presenter {
    
    // MARK: - Typealias
    
    typealias ViewType = FactsView
    typealias InteractorType = FactsInteractor
    typealias RouterType = FactsRouter
    
    // MARK: - Properties
    
    weak var view: FactsView?
    var interactor: FactsInteractor?
    var router: FactsRouter?
    
    // MARK: - Init and deinit
    
    required init(view: FactsView) {
        self.view = view
        self.router = FactsRouter(presenter: self)
        self.interactor = FactsInteractor(presenter: self)
        self.subscribeToInteractor()
        self.subcribeToItemSelection()
        self.view?.dataSource.setupDataSource(interactor?.fetchedResultsController?.fetchedObjects ?? [])
    }
    
    // MARK: - Private
    
    private func subscribeToInteractor() {
        self.interactor?.factsObserver = { [weak self] facts, index, type in
            guard let self = self else { return }
            DispatchQueue.main.async {
//                self.view?.dataSource.setupDataSource(facts)
                let collectionView = self.view?.collectionView
                collectionView?.performBatchUpdates({
                    self.view?.dataSource.setupDataSource(facts)
                    switch type {
                    case .insert:
                        if let _index = index {
                            collectionView?.insertItems(at: [_index])
                        }
                    case .delete:
                        if let _index = index {
                            collectionView?.deleteItems(at: [_index])
                        }
                    case .update:
                        if let _index = index, (collectionView?.indexPathsForVisibleItems.contains(_index) ?? false) {
                            collectionView?.reloadItems(at: [_index])
                        }
                    default: return
                    }
                },
                completion: nil)
            }
        }
    }
    
    private func subcribeToItemSelection() {
        view?.dataSource.factSelection = { [weak self] fact in
            guard let self = self, let _view = self.view else { return }
            self.router?.presentFactDialog(into: _view, with: DialogModel(with: fact))
        }
    }
}
