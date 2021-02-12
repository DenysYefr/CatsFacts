//
//  DialogViewController.swift
//  CatsFacts
//
//  Created by DenysYefremov on 12.02.2021.
//

import Foundation
import UIKit

class DialogViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var model: DialogModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.clipsToBounds = true
        contentView.addTarget(nil, action: #selector(dismissPopup), for: .touchUpInside)
        imageView.isUserInteractionEnabled = false
        label.isUserInteractionEnabled = false
        label.text = model?.text
        if let image = model?.image {
            imageView.image = image
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        contentView.layer.cornerRadius = 13
    }
    
    @objc func dismissPopup() {
        dismiss(animated: true, completion: nil)
    }
}
