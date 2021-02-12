//
//  View.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

class FactsView: UIViewController, View {
    
    // MARK: - Typealias
    
    typealias PresenterType = FactsPresenter
    
    //MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var presenter: FactsPresenter?
    let dataSource = FactsDataSource()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        setupCollectionView()
    }
    
    // MARK: - SetupPresenter
    
    func setupPresenter() {
        self.presenter = FactsPresenter(view: self)
    }
    
    // MARK: - Private
    
    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: String(describing: FactCell.self), bundle: Bundle.main),
                                forCellWithReuseIdentifier: FactCell.identifier)
    }
}
