//
//  PaymentListVC.swift
//  JAIBK
//
//  Created by Atta khan on 15/03/2022.
//

import UIKit
import SVProgressHUD

class PaymentListVC: UIViewController {
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
        collectionView.backgroundColor = UIColor.systemGroupedBackground
        collectionView.register(PaymentViewCell.self, forCellWithReuseIdentifier: "PaymentViewCell")
        return collectionView;
    }()
    
    var payments: [PaymentData]?
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        loadUIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPayemnt()
    }
    
    private func getPayemnt() {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: PaymentRequestModel.PaymentRequest(), model: PaymentModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
                
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.payments = response.data
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func addPayment() {
        let vc = AddPaymentVC()
        self.navigationController?.pushViewController(vc, animated: false)
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
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPayment))
        self.navigationItem.rightBarButtonItem = addBarButton

    }
    
    @objc func didTapEditBtn(_ sender: UIButton) {
        let tag = sender.tag
        let data = payments?[tag]
        let vc = AddPaymentVC(data: data)
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @objc func didTapRemoveBtn(_ sender: UIButton) {
        let tag = sender.tag
        let id = payments?[tag].id ?? "0"
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this item", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.deletePayment(id: id, index: tag)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(alert, animated: true, completion: nil)
    }
    private func deletePayment(id: String, index: Int) {
        ServiceManager.shared.sendRequest(request: PaymentRequestModel.DeletePaymentRequest(id: id), model: GarageModel.self) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.showAlertOkAction(withTitle: "Alert", message: response.message ?? "Deleted successfully") {
                        self.payments?.remove(at: index)
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension PaymentListVC {
    private func loadUIView()  {
        edgesForExtendedLayout = []
        if !collectionView.isDescendant(of: view) {
            view.addSubview(collectionView)
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(8)
            make.bottom.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
        }
    }
}
extension PaymentListVC: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if payments?.count ?? 0 == 0 {
            collectionView.setEmptyView(title: "No Record Found", message: "")
        } else {
            collectionView.restore()
        }
        return payments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PaymentViewCell.self, for: indexPath)
        cell.data = payments?[indexPath.row]
        cell.editBtn.tag = indexPath.row
        cell.removeBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(didTapEditBtn), for: .touchUpInside)
        cell.removeBtn.addTarget(self, action: #selector(didTapRemoveBtn), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20 , height: 130)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
