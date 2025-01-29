//
//  TrendingSegmentCell.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 25.01.25.
//

import UIKit

protocol TrendingSegmentProtocol: AnyObject {
    func didClickedSegment(index: Int)
}

final class TrendingSegmentCell: UICollectionViewCell {
    
    private lazy var segmentController: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Day", "Week"])
        segment.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
        segment.tintColor = .purple
        segment.layer.borderWidth = 2
        segment.backgroundColor = .systemPurple
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private lazy var segmentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [segmentLabel, segmentController])
        return stack
    }()
    
    private lazy var segmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .purple
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    weak var delegate: TrendingSegmentProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func segmentClicked() {
        delegate?.didClickedSegment(index: segmentController.selectedSegmentIndex)
    }
    
    func configureSegmentName(name: String) {
        segmentLabel.text = name
    }
    
    fileprivate func configureUI() {
        contentView.addSubview(segmentStack)
        segmentController.widthAnchor.constraint(equalTo: segmentStack.widthAnchor, multiplier: 0.4).isActive = true
        segmentStack.translatesAutoresizingMaskIntoConstraints = false
        segmentStack.fillSuperview()
    }
}
