//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    private let wrapperView = UIView()
    
    private let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "cast_placeholder")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
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
        
        actorImageView.addCornerRadius(actorImageView.bounds.height / 2)
    }
    
    private func setupView() {
        addSubviews([actorImageView, nameLabel])
        
        actorImageView.layout(
            .centerX(0),
            .top(0),
            .height(65),
            .width(65)
        )
        
        nameLabel.layout(
            .top(5, .to(actorImageView, .bottom)),
            .leading(3),
            .trailing(3),
            .bottom(0)
        )
    }
    
    func setContent(character: MovieCharacter) {
        actorImageView.setImage(with: character.image, placeholder: UIImage(named: "cast_placeholder"))
        nameLabel.attributedText = character.name.style(font: .semiBold, size: 12, alignment: .center)
    }
}
