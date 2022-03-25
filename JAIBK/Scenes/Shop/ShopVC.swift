//
//  ShopVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class ShopVC: UIViewController {
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
       
        collectionView.register(ShopViewCell.self, forCellWithReuseIdentifier: "ShopViewCell")
        return collectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Browse by"
        let cartImage    = UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal)
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal)

        let cartButton   = UIBarButtonItem(image: cartImage,  style: .plain, target: self, action: #selector(didTapCartButton(sender:)))
        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton, cartButton]

        let menuButton = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(didTapMenuButton(sender:)))
        navigationItem.leftBarButtonItem = menuButton
        
        
        setupViews()
    }
    @objc func didTapCartButton(sender: AnyObject){
        
    }
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        
        let vc = LeftMenuController()
        vc.modalPresentationStyle = .fullScreen
        presentAnimate(vc)
        
    }
}
extension ShopVC {
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
}
extension ShopVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ShopViewCell.self, for: indexPath)
        //cell.containerView.setGradientBorder(width: 10, colors: [UIColor.red, UIColor.blue])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           let vc = CarMaintanceVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = SubCategoryVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
