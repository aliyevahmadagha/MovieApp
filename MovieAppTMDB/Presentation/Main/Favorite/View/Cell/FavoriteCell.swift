//
//  FavoriteCell.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation
import UIKit

final class FavoriteCell: UICollectionViewCell {
    
    private lazy var movieImage: ReusableImage = {
        let image = ReusableImage(imageName: "", contentMode: .scaleAspectFill, cornerRadius: 10)
        return image
    }()
    private lazy var movieName: ReusableLabel = {
        let label = ReusableLabel(text: "", textAlignment: .left, fontName: "Times New Roman", fontSize: 30, textColor: .label, numberOfLines: 0, cornerRadius: 0)
        return label
    }()
    
    private lazy var movieStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [movieImage, movieName])
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .vertical
        s.spacing = 12
        return s
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
            equalTo: heightAnchor, multiplier: 0.8)
        .isActive = true
        movieStack.fillSuperview()
    }
    
    func configureCell(model: CellProtocol) {
        movieName.text = model.movieName
        movieImage.loadImageURL(url: model.iconURL)
    }
}
