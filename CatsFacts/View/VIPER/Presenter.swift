//
//  Presenter.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation

public protocol Presenter {
    
    associatedtype ViewType: View
    associatedtype InteractorType: Interactor
    associatedtype RouterType: Router
    
    var view: ViewType? { get set }
    var interactor: InteractorType? { get set }
    var router: RouterType? { get set }
    
    init(view: ViewType)
}
