//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    private var cancellable = Cancellable()
   
    private(set) var viewModel = MovieDetailsViewModel()
    
    // MARK: UI Properties
    
    private let transparentShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let bottomContentView = UIView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let wrapperView = UIView()
    
    private let backDropImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .white
        return button
    }()
    
    private let favoritesLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Add to favorites".style(font: .medium, size: 12)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Overview".style(font: .semiBold, size: 16)
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Cast".style(font: .semiBold, size: 16)
        return label
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        bindViewModel()
        
        // setContent()
    }
    
    // MARK: SetupView
    
    private func setupView() {
        wrapperView.backgroundColor = .clear

        view.addSubview(backDropImageView)
        backDropImageView.addSubview(transparentShadowView)

        view.addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        
        wrapperView.addSubviews([transparentView, bottomContentView])
        
        transparentView.addSubviews([titleLabel])
        
        bottomContentView.addSubviews([posterImageView, favoriteButton,
                                favoritesLabel, overviewLabel,
                                summaryLabel, castLabel])

        leftNavBarButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        addNavigationBar(leftButton: .back, hideNavBackground: true)
    }
    
    // MARK: Setup Layout
    
    private func setupLayout() {
        
        backDropImageView.layout(
            .top(0),
            .leading(0),
            .trailing(0),
            .height(350)
        )
        
        transparentShadowView.layout(
            .top(0),
            .leading(0),
            .trailing(0),
            .bottom(0)
        )
        
        scrollView.layout(
            .top(0),
            .leading(0),
            .leading(0),
            .bottom(0),
            .width(UIScreen.main.bounds.width)
        )
        
        wrapperView.layout(
            .top(0),
            .leading(0),
            .trailing(0),
            .bottom(0),
            .width(UIScreen.main.bounds.width)
        )
        
        transparentView.layout(
            .top(0),
            .leading(0),
            .trailing(0),
            .height(170)
        )
        
        titleLabel.layout(
            .top(70),
            .centerX(0),
            .leading(38),
            .trailing(38)
        )
        
        bottomContentView.backgroundColor = .darkGray
        bottomContentView.layout(
            .top(0, .to(transparentView, .bottom)),
            .leading(0),
            .trailing(0),
            .bottom(0)
            // .height(150)
        )
        
        posterImageView.layout(
            .height(140),
            .width(95),
            .top(-40),
            .leading(30)
        )
        
        overviewLabel.layout(
            .leading(30),
            .top(15, .to(posterImageView, .bottom))
        )
        
        summaryLabel.layout(
            .leading(30),
            .top(10, .to(overviewLabel, .bottom)),
            .trailing(30)
        )
        
        castLabel.layout(
            .leading(30),
            .top(15, .to(summaryLabel, .bottom)),
            .bottom(30)
        )
        
        // view.layoutIfNeeded()
    }

    // MARK: Bind View Model
    
    private func bindViewModel() {
        viewModel.movieDetails.done {[weak self] details in
            guard let self = self else { return }
            self.setContent(with: details)
        } catchError: { error in
            print(error)
        }.store(in: &cancellable)
    }
    
    private func setContent(with details: APIReponseMovieDetails? = nil) {
        guard let details = details else {
            return
        }
        // let url = "https://image.tmdb.org/t/p/w500/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg"
        backDropImageView.setImage(with: details.backDropImageUrl, placeholder: nil, cacheMethod: .memory)
        
        titleLabel.attributedText = details.title.style(font: .semiBold, size: 20, alignment: .center)
        
        posterImageView.setImage(with: details.posterImageUrl, cacheMethod: .memory)
        
        summaryLabel.attributedText = details.overview?.style(font: .medium, size: 12)
        
        // view.layoutIfNeeded()
    }
    
    @objc
    func dismissViewController() {
        self.baseNavigationController?.popViewController(animated: true)
    }
}
