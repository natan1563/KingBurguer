//
//  FeedTableViewCell.swift
//  KingBurguer
//
//  Created by Natã Romão on 01/03/23.
//

import UIKit
import SDWebImage


protocol FeedCollectionViewDelegate {
    func itemSelected(productId: Int)
}

class FeedTableViewCell: UITableViewCell {
    
    static let identifier = "FeedTableViewCell"
    
    var products: [ProductResponse] = []
    var delegate: FeedCollectionViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 220)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemGreen
        
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension FeedTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
        
        cell.product = products[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemSelected(productId: products[indexPath.row].id)
    }
    
}
