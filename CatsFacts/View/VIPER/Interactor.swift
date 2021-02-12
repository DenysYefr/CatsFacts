//
//  Interactor.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation

public protocol Interactor {
    
    associatedtype PresenterType: Presenter
    
    var presenter: PresenterType? { get set }
    
    init(presenter: PresenterType)
}
