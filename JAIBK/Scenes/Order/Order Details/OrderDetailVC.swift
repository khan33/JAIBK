//
//  OrderDetailVC.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class OrderDetailVC: UIViewController {
    private (set) lazy var collectionView:UICollectionView = { [unowned self] in
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
       
        collectionView.register(ProductViewCell.self, forCellWithReuseIdentifier: "ProductViewCell")
        collectionView.register(ShippingViewCell.self, forCellWithReuseIdentifier: "ShippingViewCell")
        collectionView.register(PaymentDetailCell.self, forCellWithReuseIdentifier: "PaymentDetailCell")
        return collectionView;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "Orders"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        setupViews()
    }

}
extension OrderDetailVC {
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        
        if !collectionView.isDescendant(of: view) {
            view.addSubview(collectionView)
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(24)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}
extension OrderDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(with: ProductViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(with: ShippingViewCell.self, for: indexPath)
            return cell
        }  else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(with: PaymentDetailCell.self, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: PaymentDetailCell.self, for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
