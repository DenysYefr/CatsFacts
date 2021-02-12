//
//  View.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

public protocol View: UIViewController {
    
    associatedtype PresenterType: Presenter
    
    var presenter: PresenterType? { get set }
    
    func setupPresenter()
}
