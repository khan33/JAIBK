//
//  EnquireDetailVC.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import UIKit

class EnquireDetailVC: UIViewController {
    
    private (set) lazy var collectionView:UICollectionView = { [unowned self] in
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.estimatedItemSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        let width = UIScreen.main.bounds.size.width
        flow.estimatedItemSize = CGSize(width: width, height: 260)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator  = false
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ProductViewCell.self, forCellWithReuseIdentifier: "ProductViewCell")
        collectionView.register(MessageViewCell.self, forCellWithReuseIdentifier: "MessageViewCell")
        return collectionView;
    }()
    private var count = 0
    private var enquireDetail: EnquireDetailModel?
    private var product_id: String
    
    init(product_id: String) {
        self.product_id = product_id
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Enquiry Detail"
        loadUIView()
        getEnquireDetail()
    }
    
    private func getEnquireDetail() {
        ServiceManager.shared.sendRequest(request: EnquireRequestModel.EnquireDetailRequest(id: product_id), model: EnquireDetailModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.enquireDetail = response
                        let data = self.enquireDetail?.data
                        if data?.count ?? 0 > 0 {
                            self.count += 1
                            if data?[0].message != "" {
                                self.count = self.count + 1
                            }
                            if data?[0].reply != "" {
                                self.count = self.count + 1
                            }
                        }
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
extension EnquireDetailVC {
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
extension EnquireDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(with: ProductViewCell.self, for: indexPath)
            cell.enquireData = enquireDetail?.data?[indexPath.row]
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(with: MessageViewCell.self, for: indexPath)
            cell.lblComment.text = "My Comment"
            cell.lblMessage.text = enquireDetail?.data?[0].message
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: MessageViewCell.self, for: indexPath)
            cell.lblMessage.text = enquireDetail?.data?[0].reply
            cell.view.backgroundColor = UIColor.hexStringToUIColor(hex: "#6082E0")
            cell.lblComment.text = "Admin Comments"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 240)
    }
}
