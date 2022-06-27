//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    
    private let wrapperView = UIView()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        // imageView.image = UIImage(named: "cast_placeholder")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
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
        
        posterImageView.addCornerRadius(10)
    }
    
    private func setupView() {
        // backgroundColor = .red
        addSubviews([posterImageView, titleLabel])
        
        posterImageView.layout(
            .centerX(0),
            .top(0),
            .height(140),
            .width(95)
        )
        
        titleLabel.layout(
            .top(5, .to(posterImageView, .bottom)),
            .leading(0, .to(posterImageView, .leading)),
            .trailing(3)
            // .bottom(0)
        )
    }
    
    func setContent(movie: SimilarDataModel) { // UIImage(named: "cast_placeholder")
        posterImageView.setImage(with: movie.posterImage, placeholder: nil, cacheMethod: .memory)
        titleLabel.attributedText = movie.title.style(font: .semiBold, size: 12)
    }
}
