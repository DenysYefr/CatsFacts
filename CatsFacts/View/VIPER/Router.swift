//
//  Router.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

public protocol Router {
    
    associatedtype PresenterType: Presenter
    
    var presenter: PresenterType? { get set }
    
    init(presenter: PresenterType)
    
    func performSegue<ViewType: View>(with id: String, for view: ViewType)
    func pushNavigation<ViewType: View>(push view: ViewType, with navigation: UINavigationController, animated: Bool)
    func pushNavigation(with navigation: UINavigationController, storyboardId: String, animated: Bool)
    func popNavigation(_ navigation: UINavigationController, animated: Bool)
}


extension Router {
    
    func performSegue<ViewType: View>(with id: String, for view: ViewType) {
        view.performSegue(withIdentifier: id, sender: nil)
    }
    
    func pushNavigation<ViewType: View>(push view: ViewType, with navigation: UINavigationController, animated: Bool) {
        navigation.pushViewController(view, animated: animated)
    }
    
    func pushNavigation(with navigation: UINavigationController, storyboardId: String, animated: Bool) {
        let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: storyboardId)
        navigation.pushViewController(viewController, animated: animated)
    }
    
    func popNavigation(_ navigation: UINavigationController, animated: Bool) {
        navigation.popViewController(animated: animated)
    }
}
