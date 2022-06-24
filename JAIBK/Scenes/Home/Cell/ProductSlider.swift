//
//  ProductSlider.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit

class ProductSlider: UICollectionViewCell {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: "ProductListCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private (set) lazy var leftBtn: UIButton = {[unowned self] in
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("", for: .normal)
        view.setImage(UIImage(named: "right_icon"), for: .normal)
        view.addTarget(self, action: #selector(didTapOnLeftBtn), for: .touchUpInside)
        return view
    }()
    
    
    private (set) lazy var rightBtn: UIButton = {[unowned self] in
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("", for: .normal)
        view.setImage(UIImage(named: "left_icon"), for: .normal)
        view.addTarget(self, action: #selector(didTapOnRightBtn), for: .touchUpInside)
        return view
    }()
    
    var productSlider: Bool = false
    var counter = 0
    var categories: [Categories]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    var products: [Products]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
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
    
    
}
extension ProductSlider {
    private func loadUIView()  {
        contentView.addSubview(collectionView)
        if !leftBtn.isDescendant(of: contentView) {
            contentView.addSubview(leftBtn)
        }
        if !rightBtn.isDescendant(of: contentView) {
            contentView.addSubview(rightBtn)
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            
            leftBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftBtn.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            
            rightBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            rightBtn.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
        
        
        
    }
    @objc func didTapOnLeftBtn() {
        guard categories?.count ?? 0 > 0 else {return}
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems.last
        counter = (visibleIndexPaths?.row ?? 0) + 1
        if counter < categories?.count ?? 0 {
            self.collectionView.isPagingEnabled = false
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.collectionView.isPagingEnabled = true
        }
    }
    
    @objc func didTapOnRightBtn() {
        guard categories?.count ?? 0 > 0 else {return}
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems.last
        
        if visibleIndexPaths?.row ?? 0 > 3 {
            counter = (visibleIndexPaths?.row ?? 0) - 3
            self.collectionView.isPagingEnabled = false
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.collectionView.isPagingEnabled = true
        }
    }
}


extension ProductSlider: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if productSlider {
            return products?.count ?? 0
        }
        return categories?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if productSlider {
            let cell = collectionView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
            cell.product = products?[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(with: ProductListCell.self, for: indexPath)
        cell.lblName.text = categories?[indexPath.row].title
        if let img = categories?[indexPath.row].image {
            cell.productImageView.sd_setImage(with: URL(string: Constant.baseURL + "images/categories/" + img), placeholderImage: UIImage(named: "item"))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
