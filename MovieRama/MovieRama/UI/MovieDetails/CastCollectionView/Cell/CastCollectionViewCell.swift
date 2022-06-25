//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    private let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cast_placeholder")
        return imageView
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
        addSubview(actorImageView)
        
        actorImageView.layout(
            .top(0),
            .leading(0),
            .trailing(0),
            .bottom(0),
            .height(50),
            .width(50)
        )
    }
    
    func setContent(image: String?) {
        actorImageView.setImage(with: image, placeholder: UIImage(named: "cast_placeholder"), cacheMethod: .memory)
    }
}
