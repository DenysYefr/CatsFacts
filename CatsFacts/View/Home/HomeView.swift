//
//  HomeView.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

class HomeView: UIViewController, View {
    
    // MARK: - Typealias
    
    typealias PresenterType = HomePresenter
    
    // MARK: - Properties
    
    var presenter: HomePresenter?
    
    // MARK: - Outlet
    
    @IBOutlet weak var factsButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        factsButton.addTarget(self, action: #selector(factsButtonAction), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        factsButton.layer.cornerRadius = factsButton.frame.size.height / 2
    }
    
    // MARK: - SetupPresenter
    
    func setupPresenter() {
        presenter = PresenterType(view: self)
    }
    
    // MARK: - Action
    
    @objc func factsButtonAction() {
        presenter?.presentFacts()
    }
}
