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
        layout.estimatedItemSize = CGSize.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
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
        
        page.pageIndicatorTintColor = UIColor.gray
        page.currentPageIndicatorTintColor = UIColor.black
        return page
    }()
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    
    private var totalImages = 0
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
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 220))
    }
    var images: [Product_images]? {
        didSet {
            totalImages = images?.count ?? 0
            slidePagerView.numberOfPages = totalImages
            collectionView.reloadData()
        }
    }
    private func loadUIView()  {
        contentView.addSubview(collectionView)
        contentView.addSubview(slidePagerView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            slidePagerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            slidePagerView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor, constant: 0),
            slidePagerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
        ])
        
        
    }
}
extension SliderViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalImages
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SliderCell.self, for: indexPath)
        if let img = images?[indexPath.row].image {
            cell.productImageView.sd_setImage(with: URL(string: Constant.baseURL + "images/products/" + img), placeholderImage: UIImage(named: "item"))
        }
        return cell
    }
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / contentView.frame.width)
        slidePagerView.currentPage = pageNumber
    }
}
