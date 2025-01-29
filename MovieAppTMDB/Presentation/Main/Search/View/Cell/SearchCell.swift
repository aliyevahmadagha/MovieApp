//
//  SearchCell.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 29.01.25.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    
    private lazy var movieImage: ReusableImage = {
        let i = ReusableImage(imageName: "front", contentMode: .scaleAspectFill, cornerRadius: 10)
        return i
    }()
    
    private lazy var movieName: ReusableLabel = {
        let l = ReusableLabel(text: "Sonic the hedgehog", textAlignment: .left, fontName: "Charbroil", fontSize: 30, textColor: .purple, numberOfLines: 0, cornerRadius: 0)
        return l
    }()
   
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [movieImage, movieName])
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .horizontal
        s.spacing = 12
        return s
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .clear
        configureUI()
    }
    
    private func configureUI() {
        addViews(view: [ stackView])
        movieImage.widthAnchor.constraint(
            equalTo: widthAnchor, multiplier: 0.3)
        .isActive = true
        movieName.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        
        stackView.fillSuperview(padding: .init(all: 10))
    }
    
    func configureCell(model: CellProtocol) {
        movieName.text = model.movieName
        movieImage.loadImageURL(url: model.iconURL)
    }
}
