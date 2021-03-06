//
//  PaymentMethodVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class AddressListVC: UIViewController {
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
        collectionView.register(PaymentViewCell.self, forCellWithReuseIdentifier: "PaymentViewCell")
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupViews()
    }
    func configNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Payment Methods"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func getAddress() {
        ServiceManager.shared.sendRequest(request: AddressRequestModel.AddressRequest(), model: CityModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func editAddress() {
        
    }
    
    
    private func deleteAddress(id: String) {
        ServiceManager.shared.sendRequest(request: AddressRequestModel.DeleteAddressRequest(id: id), model: CityModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension AddressListVC {
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
extension AddressListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PaymentViewCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 20 , height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
