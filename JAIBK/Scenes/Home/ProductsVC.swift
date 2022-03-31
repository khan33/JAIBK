//
//  ProductsVC.swift
//  JAIBK
//
//  Created by Atta khan on 30/03/2022.
//

import UIKit

class ProductsVC: UIViewController {
    private (set) lazy var collectionViewHome:UICollectionView = { [unowned self] in
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.estimatedItemSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator  = false
        
        //collectionView.register(SearchButtonCell.self, forCellWithReuseIdentifier: "SearchButtonCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView;
    }()
    
    private var products: [Products]
   
    init(products: [Products]) {
        self.products = products
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configNav()
        setupViews()
    }
    
    
    private func configCollectionView() {
        collectionViewHome.reloadData()
    }
    
    
    
    
    
    @objc func didTapCartButton(sender: AnyObject){
        
    }
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        
        let vc = LeftMenuController()
        self.navigationController?.pushViewController(vc, animated: false)
        //presentAnimate(vc)
        
    }
}
extension ProductsVC {
    func configNav() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "All Products"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
     }
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        
        if !collectionViewHome.isDescendant(of: view) {
            view.addSubview(collectionViewHome)
        }
        collectionViewHome.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(24)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    @objc func didTapOnCarSearchBtn(_ sender: UIButton) {
        let vc = SearchByCarVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapOnVINSearchBtn(_ sender: UIButton) {
        let vc = SearchByVIN()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension ProductsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
        cell.product = products[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
