//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGray
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        // imageView.image = UIImage(named: "cast_placeholder")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = avatarImageView.bounds.height / 2
        avatarImageView.addCornerRadius(radius)
        wrapperView.addCornerRadius(10)
    }
    
    private func setupView() {
        addSubview(wrapperView)
        wrapperView.addSubviews([avatarImageView, nameLabel, contentLabel])
        
        wrapperView.layout(
            .edges(10)
        )
        
        avatarImageView.layout(
            .leading(10),
            .top(10),
            .height(40),
            .width(40)
        )
        
        nameLabel.layout(
            .centerY(0, .to(avatarImageView)),
            .leading(9, .to(avatarImageView, .trailing))
        )
        
        contentLabel.layout(
            .top(10, .to(avatarImageView, .bottom)),
            .leading(10),
            .trailing(10),
            .bottom(10)
        )
    }
    
    func setContent(review: ReviewsDataModel) { // UIImage(named: "cast_placeholder")
        avatarImageView.setImage(with: review.image, placeholder: UIImage(named: "cast_placeholder"))
        nameLabel.attributedText = review.author.style(font: .semiBold, size: 12, color: .gray)
        contentLabel.attributedText = review.content.style(font: .medium, size: 15, lineBreakMode: .byTruncatingTail)
    }
}
