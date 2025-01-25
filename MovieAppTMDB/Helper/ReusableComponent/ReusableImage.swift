//
//  ReusableImage.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

import UIKit

final class ReusableImage: UIImageView {
    private var imageName: String
    private var contentModeStyle: UIView.ContentMode
    private var cornerRadius: CGFloat

    init(imageName: String, contentMode: UIView.ContentMode = .scaleToFill, cornerRadius: CGFloat = 0) {
        self.imageName = imageName
        self.contentModeStyle = contentMode
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: imageName)
        contentMode = contentModeStyle
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
