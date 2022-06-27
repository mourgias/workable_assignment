//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var cancellable = Cancellable()
    
    // MARK: UI Properties
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGray
        view.clipsToBounds = true
        view.addCornerRadius(10)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //private let voteAverageLabel = UILabel()
    
    private let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar_icon")
        return imageView
    }()
    
    private let releaseDateLabel = UILabel()
    
    private(set) var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .white
        return button
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // reuse strong references
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cancellable.removeAll()
    }
    
    // MARK: Setup View
    
    func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(wrapperView)
        wrapperView.addSubviews([titleLabel, posterImageView,
                                 calendarImageView, releaseDateLabel,
                                 favoriteButton])
    }
    
    // MARK: Setup Layout
    
    func setupLayout() {
        
        wrapperView.layout(
            .top(7.5),
            .leading(12),
            .trailing(12),
            .bottom(7.5)
        )
        
        titleLabel.layout(
            .top(15),
            .leading(10, .to(posterImageView, .trailing)),
            .trailing(15)
        )
        
        posterImageView.layout(
            .top(0),
            .leading(0),
            .bottom(0),
            .height(150),
            .width(120)
        )
        
        calendarImageView.layout(
            .top(10, .to(titleLabel, .bottom)),
            .leading(0, .to(titleLabel, .leading))
        )
        
        releaseDateLabel.layout(
            .leading(5, .to(calendarImageView, .trailing)),
            .centerY(0, .to(calendarImageView))
        )
        
        favoriteButton.layout(
            .leading(0, .to(titleLabel, .leading)),
            .top(10, .to(releaseDateLabel, .bottom))
        )
    }
 
    // MARK: Set Content
    
    func setContent(movie: MovieDataModel) {
        
        titleLabel.attributedText = movie.title.style(font: .semiBold, size: 16)

        //voteAverageLabel.attributedText = movie.voteAveragePercent.style(font: .semiBold, size: 13)

        releaseDateLabel.attributedText = movie.releaseDateFormatted.style(font: .semiBold, size: 13)

        posterImageView.setImage(with: movie.posterImageUrl, placeholder: UIImage(named: "poster_placeholder"))
        
        favoriteButton.isSelected = movie.isFavorite
    }
}
