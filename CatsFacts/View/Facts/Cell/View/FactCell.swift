//
//  FactCell.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

class FactCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "factCell"
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configLayout()
    }
    
    private func configLayout() {
        contentView.layer.cornerRadius = 8
        imageView.frame = bounds
        titleLabel.constraints.forEach { $0.isActive = false }
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // MARK: - Config
    
    public func config(with model: FactCellModel) {
        titleLabel.text = model.title
        imageView.image = model.image
    }
}
