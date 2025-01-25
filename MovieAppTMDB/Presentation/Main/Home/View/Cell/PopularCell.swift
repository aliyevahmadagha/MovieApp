//
//  PopularCell.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 24.01.25.
//

import UIKit

final class PopularCell: UICollectionViewCell {
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: "poster")
        image.layer.cornerRadius = 12
        image.layer.borderWidth = 1
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var textStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .vertical
        s.spacing = 4
        return s
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [productImage, textStack])
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureUI() {
        addSubview(stackView)
        productImage.heightAnchor.constraint(
            equalTo: heightAnchor, multiplier: 0.8)
        .isActive = true
        stackView.fillSuperview()
    }
    
    func configureCell(model: CellProtocol) {
        nameLabel.text = model.movieName
        dateLabel.text = model.movieDate
        
        guard !model.iconURL.isEmpty else {return}
        productImage.loadImageURL(url: model.iconURL)
    }
}
