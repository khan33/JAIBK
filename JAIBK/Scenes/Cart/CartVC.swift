//
//  CartVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class CartVC: UIViewController {
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
        //collectionView.backgroundColor = UIColor.systemGroupedBackground
        collectionView.register(CartViewCell.self, forCellWithReuseIdentifier: "CartViewCell")
        collectionView.register(EnquireViewCell.self, forCellWithReuseIdentifier: "EnquireViewCell")
        collectionView.register(AccountViewCell.self, forCellWithReuseIdentifier: "AccountViewCell")
        collectionView.register(GuestCheckoutViewCell.self, forCellWithReuseIdentifier: "GuestCheckoutViewCell")
        collectionView.register(PaymentMethodViewCell.self, forCellWithReuseIdentifier: "PaymentMethodViewCell")
        collectionView.register(CheckoutButtonCell.self, forCellWithReuseIdentifier: "CheckoutButtonCell")
        return collectionView;
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
}

extension CartVC {
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
extension CartVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(with: CartViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(with: AccountViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(with: GuestCheckoutViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(with: EnquireViewCell.self, for: indexPath)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(with: CheckoutButtonCell.self, for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 20 , height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
