//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class SimilarMoviesCollectionView: UIView {
    
    var similarMovies: [SimilarDataModel] = [] {
        didSet {
            // Keep it on main thread
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: UI Properties
    
    private let recommendationLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Recommendations".style(font: .semiBold, size: 18)
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5// CGFloat.greatestFiniteMagnitude // 30 // horizontal
        layout.minimumInteritemSpacing = 10// CGFloat.greatestFiniteMagnitude // vertical
        
       // layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
       // layout.itemSize = CGSize(width: 60, height: 60)// UICollectionViewFlowLayout.automaticSize
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 60, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceHorizontal = true
                
        cv.register(SimilarMoviesCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMoviesCollectionViewCell.id)
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetupView
    
    func setupView() {
        addSubviews([recommendationLabel, collectionView])
        
        recommendationLabel.layout(
            .top(0),
            .leading(30)
        )
        
        collectionView.layout(
            .top(15, .to(recommendationLabel, .bottom)),
            .leading(0),
            .trailing(0),
            .bottom(10),
            .height(190)
        )
    }
}

// MARK: UICollectionViewDataSource - UICollectionViewDelegate

extension SimilarMoviesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = similarMovies[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCollectionViewCell.id, for: indexPath)
        
        switch cell {
        case let (cell as SimilarMoviesCollectionViewCell):
            cell.setContent(movie: movie)
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 120, height: 190)
        return size
    }
    
}
