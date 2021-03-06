//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    struct Defines {
        static let leadingAlignment: CGFloat = 40
    }
    
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
    
    private let bottomContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .appDarkGray
        view.roundMaskedCorners([.topLeft, .topRight], radius: 13)
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
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
    
    private let genreLabel = UILabel()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.addCornerRadius(10)
        imageView.clipsToBounds = true
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
        label.attributedText = "Overview".style(font: .semiBold, size: 18)
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let castView = CastCollectionView()
    
    private let directorView: DirectorView = {
        let view = DirectorView()
        view.isHidden = true
        return view
    }()
    
    private let similarMoviesView = SimilarMoviesCollectionView()
    
    private let reviews = ReviewsCollectionView()
    
    private let upperVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 28
        // stackView.alignment = UIStackView.Alignment.fill
        stackView.axis = .vertical
        // stackView.distribution = UIStackView.Distribution.
        return stackView
    }()
    
    private let lowerVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 28
        // stackView.alignment = UIStackView.Alignment.fill
        stackView.axis = .vertical
        // stackView.distribution = UIStackView.Distribution.
        return stackView
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        bindViewModel()
        bindButtonHandlers()
    }
    
    // MARK: SetupView
    
    private func setupView() {
        wrapperView.backgroundColor = .clear

        view.addSubview(backDropImageView)
        backDropImageView.addSubview(transparentShadowView)

        view.addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        
        wrapperView.addSubviews([transparentView, bottomContentView])
        
        transparentView.addSubviews([titleLabel, genreLabel])
        
        bottomContentView.addSubviews([posterImageView, favoriteButton,
                                       favoritesLabel, overviewLabel,
                                       summaryLabel, upperVerticalStackView,
                                    lowerVerticalStackView])
        
        upperVerticalStackView.addArrangedSubviews([castView, directorView])
        lowerVerticalStackView.addArrangedSubviews([similarMoviesView, reviews])
        
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
        
        genreLabel.layout(
            .top(10, .to(titleLabel, .bottom)),
            .centerX(0)
        )
        
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
            .leading(Defines.leadingAlignment)
        )
        
        favoriteButton.layout(
            .leading(15, .to(posterImageView, .trailing)),
            .top(30)
        )
        
        favoritesLabel.layout(
            .leading(10, .to(favoriteButton, .trailing)),
            .centerY(0, .to(favoriteButton))
        )
        
        overviewLabel.layout(
            .leading(Defines.leadingAlignment),
            .top(15, .to(posterImageView, .bottom))
        )
        
        summaryLabel.layout(
            .leading(Defines.leadingAlignment),
            .top(10, .to(overviewLabel, .bottom)),
            .trailing(30)
        )
        
        upperVerticalStackView.layout(
            .leading(Defines.leadingAlignment - 30),
            .trailing(0),
            .top(27, .to(summaryLabel, .bottom))
        )
        
        lowerVerticalStackView.layout(
            .top(45, .to(upperVerticalStackView, .bottom)),
            .leading(Defines.leadingAlignment - 30),
            .trailing(0),
            .bottom(30)
        )
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
    
    private func bindButtonHandlers() {
        
        favoriteButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.favoriteButton.isSelected.toggle()
                
                if self.favoriteButton.isSelected {
                    self.viewModel.addToFavorites()
                } else {
                    self.viewModel.removeFromFavorites()
                }
            }
            .store(in: &cancellable)
        
        leftNavBarButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismissViewController()
            }
            .store(in: &cancellable)
    }
    
    private func setContent(with details: MovieDetailsDataModel? = nil) {
        guard let details = details else {
            return
        }
        
        // let url = "https://image.tmdb.org/t/p/w500/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg"
        backDropImageView.setImage(with: details.backDropImage, placeholder: nil, cacheMethod: .memory)
        
        titleLabel.attributedText = details.title.style(font: .semiBold, size: 20, alignment: .center)
        
        posterImageView.setImage(with: details.posterImage, cacheMethod: .memory)
        
        summaryLabel.attributedText = details.summary?.style(font: .medium, size: 14, lineSpacing: 3)
        
        genreLabel.attributedText = details.genre.style(font: .medium, size: 14)
        
        castView.cast = details.cast
        
        if let director = details.director {
            directorView.isHidden = false
            directorView.setContent(director: director)
        }
        
        similarMoviesView.similarMovies = details.similar
        
        reviews.isHidden = details.reviews.isEmpty
        reviews.movieReviews = details.reviews
        
        favoriteButton.isSelected = details.isFavorite
    }
    
    // MARK: Action Handlers
    
    func dismissViewController() {
        self.baseNavigationController?.popViewController(animated: true)
    }
}
