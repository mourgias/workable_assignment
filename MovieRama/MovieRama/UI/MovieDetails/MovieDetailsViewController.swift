//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    private var cancellable = Cancellable()
   
    private(set) var viewModel = MovieDetailsViewModel()
    
    // MARK: UI Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .red
        return scrollView
    }()
    
    private let wrapperView = UIView()
    
    private let backDropImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        
        wrapperView.backgroundColor = .yellow
        
        wrapperView.addSubviews([backDropImageView])

        leftNavBarButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        addNavigationBar(leftButton: .back, hideNavBackground: true)
    }
    
    // MARK: Setup Layout
    
    private func setupLayout() {
        
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
        
        backDropImageView.layout(
            .top(0),
            .leading(0),
            .trailing(0),
            .bottom(0),
            .height(300)
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
        // let url = "https://image.tmdb.org/t/p/w500/zGLHX92Gk96O1DJvLil7ObJTbaL.jpg"
        backDropImageView.setImage(with: details?.backDropImageUrl, placeholder: nil)
        
        // view.layoutIfNeeded()
    }
    
    @objc
    func dismissViewController() {
        self.baseNavigationController?.popViewController(animated: true)
    }
}
