//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: UI Properties
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        //view.clipsToBounds = true
        //view.addCornerRadius(10)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
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
    
    // MARK: Setup View
    
    func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(wrapperView)
        
        wrapperView.addSubviews([titleLabel])
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
            .leading(10),
            .trailing(15),
            .bottom(15)
        )
    }
 
    // MARK: Set Content
    
    func setContent(movie: MovieDataModel) {
        titleLabel.text = movie.title
    }
}
