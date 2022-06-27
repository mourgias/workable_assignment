//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class DirectorView: UIView {
    
    // MARK: UI Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Director".style(font: .semiBold, size: 16)
        return label
    }()
    
    private let directorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cast_placeholder")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = directorImageView.bounds.height / 2
        directorImageView.addCornerRadius(height)
    }
    
    // MARK: SetupView
    
    private func setupView() {
        addSubviews([titleLabel, directorImageView, nameLabel])
    }
    
    // MARK: SetupLayout
    
    private func setupLayout() {
        titleLabel.layout(
            .top(0),
            .leading(0)
        )
        
        directorImageView.layout(
            .height(65),
            .width(65),
            .top(15, .to(titleLabel, .bottom)),
            .leading(5)
        )
        
        nameLabel.layout(
            .top(10, .to(directorImageView, .bottom)),
            .leading(0, .to(directorImageView, .leading)),
            .bottom(0)
        )
    }
    
    // MARK: Set content
    
    func setContent(director: APIReponseCast?) {
        
        titleLabel.isHidden = director == nil
        
        guard let director = director else {
            return
        }
        
        directorImageView.setImage(with: director.profileImage, placeholder: UIImage(named: "cast_placeholder"))
        
        nameLabel.attributedText = (director.name ?? "").style(font: .semiBold, size: 12, alignment: .center)
    }
}
