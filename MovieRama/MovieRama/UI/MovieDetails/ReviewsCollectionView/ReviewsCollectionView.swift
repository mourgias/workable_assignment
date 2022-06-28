//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class ReviewsCollectionView: UIView {
    
    var movieReviews: [ReviewsDataModel] = [] {
        didSet {
            // Keep it on main thread
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: UI Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Reviews".style(font: .semiBold, size: 16)
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
                
        cv.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.id)
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
        addSubviews([titleLabel, collectionView])
        
        titleLabel.layout(
            .top(0),
            .leading(30)
        )
        
        collectionView.layout(
            .top(10, .to(titleLabel, .bottom)),
            .leading(0),
            .trailing(0),
            .bottom(10),
            .height(190)
        )
    }
}

// MARK: UICollectionViewDataSource - UICollectionViewDelegate

extension ReviewsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let review = movieReviews[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.id, for: indexPath)
        
        switch cell {
        case let (cell as ReviewCollectionViewCell):
            cell.setContent(review: review)
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 50
        let size = CGSize(width: width, height: 190)
        return size
    }
    
}
