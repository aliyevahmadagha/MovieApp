//
//  MoviesSegmentCell.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 25.01.25.
//

import UIKit

final class MoviesSegmentCell: UICollectionViewCell {
    
    private lazy var segmentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [segmentLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var segmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSegmentName(name: String) {
        segmentLabel.text = name
    }
    
    fileprivate func configureUI() {
        contentView.addSubview(segmentStack)
        segmentStack.translatesAutoresizingMaskIntoConstraints = false
        segmentStack.fillSuperview()
    }
}

