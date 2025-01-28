//
//  FavoriteCell.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation
import UIKit

final class FavoriteCell: UICollectionViewCell {
    
    private lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    private lazy var movieName: ReusableLabel = {
        let label = ReusableLabel(text: "", textAlignment: .center, fontName: "Times New Roman", fontSize: 16, textColor: .label, numberOfLines: 0, cornerRadius: 0)
        return label
    }()
    
    private lazy var movieStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [movieImage, movieName])
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
    }
    
    private func configureUI() {
        addSubview(movieStack)
        movieImage.heightAnchor.constraint(
            equalTo: heightAnchor, multiplier: 0.7)
        .isActive = true
        movieStack.fillSuperview()
    }
    
    func configureCell(model: CellProtocol) {
        movieName.text = model.movieName
        movieImage.loadImageURL(url: model.iconURL)
    }
}
