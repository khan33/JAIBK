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
        
        collectionView.register(OrderStatusViewCell.self, forCellWithReuseIdentifier: "OrderStatusViewCell")
        collectionView.register(ProductViewCell.self, forCellWithReuseIdentifier: "ProductViewCell")
        collectionView.register(ShippingViewCell.self, forCellWithReuseIdentifier: "ShippingViewCell")
        collectionView.register(PaymentDetailCell.self, forCellWithReuseIdentifier: "PaymentDetailCell")
        return collectionView;
    }()
    private var order_id: String
    
    init(order_id: String) {
        self.order_id = order_id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var orderDetail: OrderDetailModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "Orders"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        getOrderDetail()
        setupViews()
    }
    
    private func getOrderDetail() {
        ServiceManager.shared.sendRequest(request: OrderDetailRequest(order_id: order_id), model: OrderDetailModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.orderDetail = response
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(with: OrderStatusViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(with: ProductViewCell.self, for: indexPath)
            cell.data = orderDetail?.data?[indexPath.row]
            if let img = orderDetail?.data?[indexPath.row].image {
                cell.productImageView.sd_setImage(with: URL(string: Constant.baseURL + img), placeholderImage: UIImage(named: "item"))
            }
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(with: ShippingViewCell.self, for: indexPath)
            cell.shipping = orderDetail?.shipping_data?[indexPath.row]
            return cell
        }  else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(with: PaymentDetailCell.self, for: indexPath)
            cell.data = orderDetail
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: PaymentDetailCell.self, for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 20, height: 80)
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width - 20, height: 140)
        }
        return CGSize(width: collectionView.frame.width - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
class  OrderDetailRequest: RequestModel {
    private var order_id: String
    
    init(order_id: String) {
        self.order_id = order_id
    }
    
    
    override var path: String {
        return Constant.ServiceConstant.ORDER_DETAIL
    }
    
    override var parameters: [String : Any?] {
        return [
            "order_id" : order_id
        ]
    }
    
    
}
