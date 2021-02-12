//
//  Router.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

class FactsRouter: Router {
    
    // MARK: - Typealias
    
    typealias PresenterType = FactsPresenter
    
    // MARK: - properties
    
    weak var presenter: FactsPresenter?
    
    // MARK: - Init and deinit
    
    required init(presenter: FactsPresenter) {
        self.presenter = presenter
    }
    
    func presentFactDialog<ViewType: View>(into view: ViewType, with dialogModel: DialogModel) {
        guard let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DialogViewController") as? DialogViewController else { return }
        viewController.model = dialogModel
        viewController.modalPresentationStyle = .overCurrentContext
        view.present(viewController, animated: true, completion: nil)
    }
}
