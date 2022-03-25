//
//  SliderViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class SliderViewCell: UICollectionViewCell {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SliderCell.self, forCellWithReuseIdentifier: "SliderCell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator  = false

        return collectionView
    }()
    let slidePagerView: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.clipsToBounds = true
        page.numberOfPages = 5
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.black
        return page
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUIView()  {
        contentView.addSubview(collectionView)
        contentView.addSubview(slidePagerView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
            slidePagerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            slidePagerView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor, constant: 0),
            slidePagerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
        ])
        
        
    }
}
extension SliderViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SliderCell.self, for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / contentView.frame.width)
        slidePagerView.currentPage = pageNumber
    }
}
