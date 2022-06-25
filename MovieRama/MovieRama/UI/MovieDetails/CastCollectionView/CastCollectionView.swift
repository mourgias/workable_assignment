//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class CastCollectionView: UIView {
    
    // MARK: UI Properties
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "Cast".style(font: .semiBold, size: 16)
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30 // CGFloat.greatestFiniteMagnitude //30 // horizontal
        layout.minimumInteritemSpacing = 30 // CGFloat.greatestFiniteMagnitude // vertical
        
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = CGSize(width: 50, height: 50)// UICollectionViewFlowLayout.automaticSize
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 60, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceHorizontal = true
                
        cv.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
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
        addSubviews([castLabel, collectionView])
        
        castLabel.layout(
            .top(0),
            .leading(30)
        )
        
        collectionView.backgroundColor = .red
        collectionView.layout(
            .top(10, .to(castLabel, .bottom)),
            .leading(0),
            .trailing(0),
            .bottom(10),
            .height(50)
        )
    }
}

// MARK: UICollectionViewDataSource - UICollectionViewDelegate

extension CastCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath)
        
        switch cell {
        case let (cell as CastCollectionViewCell):
            cell.setContent(image: "")
            
        default:
            break
        }
        
        return cell
    }
}
