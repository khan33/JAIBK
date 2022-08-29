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
        collectionView.register(AddressViewCell.self, forCellWithReuseIdentifier: "AddressViewCell")
        return collectionView
    }()
    
    var addresses: [AddressData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        getAddress()
    }
    
    
    
    func configNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Address"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAddress))
        self.navigationItem.rightBarButtonItem = addBarButton
    }

    @objc func addAddress() {
        let vc = AddAddressVC()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func getAddress() {
        ServiceManager.shared.sendRequest(request: AddressRequestModel.AddressRequest(), model: AddressModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.addresses = response.data as! [AddressData]
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func deleteAddress(id: String, index: Int) {
        ServiceManager.shared.sendRequest(request: AddressRequestModel.DeleteAddressRequest(id: id), model: AddAddressModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.showAlertOkAction(withTitle: "Alert", message: response.message ?? "Deleted successfully") {
                            self.addresses?.remove(at: index)
                            self.collectionView.reloadData()
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func didTapUpdateBtn(_ sender: UIButton) {
        let tag = sender.tag
        let data = self.addresses?[tag]
        let vc = AddAddressVC(data: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSelectedBtn(_ sender: UIButton) {
        let tag = sender.tag
        let id = self.addresses?[tag].id ?? "0"
    }
    
    @objc func didTapRemoveBtn(_ sender: UIButton) {
        let tag = sender.tag
        let id = self.addresses?[tag].id ?? "0"
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this item", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.deleteAddress(id: id, index: tag)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(alert, animated: true, completion: nil)
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
        if addresses?.count ?? 0 == 0 {
            collectionView.setEmptyView(title: "No Record Found", message: "")
        } else {
            collectionView.restore()
        }
        return addresses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: AddressViewCell.self, for: indexPath)
        cell.address = addresses?[indexPath.row]
        
        cell.selectedBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.removeBtn.tag = indexPath.row
        
        cell.removeBtn.addTarget(self, action: #selector(didTapRemoveBtn), for: .touchUpInside)
        cell.editBtn.addTarget(self, action: #selector(didTapUpdateBtn), for: .touchUpInside)
        cell.selectedBtn.addTarget(self, action: #selector(didTapSelectedBtn), for: .touchUpInside)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 20 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
