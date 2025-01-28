//
//  FavoriteSectionCell.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation
import UIKit

final class FavoriteSectionCell: UICollectionViewCell {
    
    private lazy var favoriteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "My Favorite Movies"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        contentView.addSubview(favoriteLabel)
        favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteLabel.fillSuperview()
    }
}
