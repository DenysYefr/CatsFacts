//
//  DataSource.swift
//  CatsFacts
//
//  Created by DenysYefremov on 11.02.2021.
//

import Foundation
import UIKit

typealias FactSelection = ((Fact) -> Void)

class FactsDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private var dataSource: [Fact] = []
    
    private let kLeadingInset: CGFloat = 30
    private let kTrailingInset: CGFloat = 30
    private let kTopInset: CGFloat = 30
    private let kBottomInset: CGFloat = 30
    private let kHeightWidthRatio: CGFloat = 1.5
    
    var factSelection: FactSelection?
    
    // MARK: - Config
    
    func setupDataSource(_ data: [Fact]) {
        self.dataSource = data
    }
    
    // MARK: - Delegate and Data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier,
                                                            for: indexPath) as? FactCell else { return UICollectionViewCell() }
        
        cell.config(with: dataSource[indexPath.row].asCellModel())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width / 2 - kLeadingInset * 2
        let height: CGFloat = width * kHeightWidthRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: kTopInset, left: kLeadingInset, bottom: kBottomInset, right: kTrailingInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        factSelection?(dataSource[indexPath.row])
    }
}
