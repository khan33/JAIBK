//
//  CartVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit
import SVProgressHUD

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
        collectionView.register(ShippingInfoViewCell.self, forCellWithReuseIdentifier: "ShippingInfoViewCell")
        collectionView.register(AccountViewCell.self, forCellWithReuseIdentifier: "AccountViewCell")
        collectionView.register(GuestCheckoutViewCell.self, forCellWithReuseIdentifier: "GuestCheckoutViewCell")
        collectionView.register(PaymentMethodViewCell.self, forCellWithReuseIdentifier: "PaymentMethodViewCell")
        collectionView.register(CheckoutButtonCell.self, forCellWithReuseIdentifier: "CheckoutButtonCell")
        collectionView.register(PaymentDetailCell.self, forCellWithReuseIdentifier: "PaymentDetailCell")
        

        
        return collectionView;
    }()
    
    var cartData: [CartData]?
    var address: [AddressData]?
    var cart: CartModel?
    private var viewComponents : [CartComponentEnum] = []
    private var compnents: [String] = []
    var quantity = 1
    var payment_method: paymentMethod = .cash
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        navConfig()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getCart()
    }
    
    private func navConfig() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Cart"
    
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal)

        
        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton]

        let menuButton = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(didTapMenuButton(sender:)))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        let vc = LeftMenuController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func minusQuntity(_ sender: UIButton) {
        let tag = sender.tag
        
        let indexPath = IndexPath(item: 0, section: tag);
        if let cell = collectionView.cellForItem(at: indexPath) as? CartViewCell {
            quantity = Int(cell.quantityTxtField.text ?? "1") ?? 1
            if quantity > 1 {
                quantity = quantity - 1
            }
            cell.quantityTxtField.text = String(quantity)
        }
        let id = self.cartData?[tag].product_id ?? ""
        UpdateCart(id)
    }
    
    
    @objc func addQuntity(_ sender: UIButton) {
        let tag = sender.tag
        let indexPath = IndexPath(item: 0, section: tag);
        if let cell = collectionView.cellForItem(at: indexPath) as? CartViewCell {
            quantity = Int(cell.quantityTxtField.text ?? "1") ?? 1
            quantity = quantity + 1
            cell.quantityTxtField.text = String(quantity)
        }
        let id = self.cartData?[tag].product_id ?? ""
        UpdateCart(id)
    }
    
    private func UpdateCart(_ productId: String) {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: CartRequestModel.UpdateCartRequest(product_id: productId, quantity: self.quantity, type: "product"), model: GarageModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.getCart()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func getCart() {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: CartRequestModel.CartRequest(), model: CartModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.cart = response
                        self.address = self.cart?.address
                        self.cartData = self.cart?.data
                        
                        self.setUIComponents()
                        self.collectionView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.setUIComponents()
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @objc func removeCart(_ sender: UIButton) {
        let tag = sender.tag
        let id = self.cartData?[tag].product_id ?? ""

        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: CartRequestModel.DeleteCartRequest(id: id, type: "product"), model: CartModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.getCart()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func didTapOnPaymentBtn(_ sender: UIButton) {
        let tag = sender.tag
        let index = viewComponents.firstIndex(where: { $0.self == .payment}) ?? 0
        let indexPath = IndexPath(item: 0, section: index)
        if let cell = collectionView.cellForItem(at: indexPath) as? PaymentMethodViewCell {
            if tag == 0 {
                let origImage1 = UIImage(named: "radiobutton_deselect")
                let tintedImage1 = origImage1?.withRenderingMode(.alwaysTemplate)
                cell.radioBtn2.setImage(tintedImage1, for: .normal)
                cell.radioBtn2.tintColor = .white
                let origImage = UIImage(named: "radiobutton_select")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                cell.radioBtn1.setImage(tintedImage, for: .normal)
                cell.radioBtn1.tintColor = .white
                payment_method = .cash
            } else {
                let origImage1 = UIImage(named: "radiobutton_select")
                let tintedImage1 = origImage1?.withRenderingMode(.alwaysTemplate)
                cell.radioBtn2.setImage(tintedImage1, for: .normal)
                cell.radioBtn2.tintColor = .white
                let origImage = UIImage(named: "radiobutton_deselect")
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                cell.radioBtn1.setImage(tintedImage, for: .normal)
                cell.radioBtn1.tintColor = .white
                payment_method = .credit
            }
        }
    }
    
    
    private func setUIComponents() {
        viewComponents.removeAll()
        
        self.cartData?.forEach({ item in
            viewComponents.append(.cart)
        })
        
        if let token = UserDefaults.standard.string(forKey: "token"), token != "" {
        } else {
            viewComponents.append(.account)
            viewComponents.append(.guest)
        }
        viewComponents.append(.shippingInfo)
        
        viewComponents.append(.payment)
        viewComponents.append(.summery)
        viewComponents.append(.checkout)
    }
    
    private func getComponent(index: Int) -> String {
        return viewComponents[index].name
    }
    
    private func checkout() {
        SVProgressHUD.show()
        var reqeust = CheckoutRequestModel.CheckoutRequest(
                        first_name: self.address?[0].first_name ?? "",
                        last_name: self.address?[0].last_name ?? "",
                        email:  "",
                        address: self.address?[0].address ?? "",
                        country: self.address?[0].country ?? "",
                        city: self.address?[0].city ?? "",
                        payment_methood: self.payment_method.rawValue
        )
        ServiceManager.shared.sendRequest(request: reqeust, model: CartModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
        if viewComponents.count == 0 {
            collectionView.setEmptyView(title: "No Record Found", message: "")
        } else {
            collectionView.restore()
        }
        return viewComponents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let component = getComponent(index: indexPath.section)
        if component == CartComponentEnum.cart.name {
            let cell = collectionView.dequeueReusableCell(with: CartViewCell.self, for: indexPath)
            cell.product = cartData?[indexPath.section]
            cell.plusBtn.tag = indexPath.section
            cell.plusBtn.addTarget(self, action: #selector(addQuntity), for: .touchUpInside)
            cell.minusBtn.tag = indexPath.section
            cell.minusBtn.addTarget(self, action: #selector(minusQuntity), for: .touchUpInside)
            cell.removeBtn.tag = indexPath.section
            cell.removeBtn.addTarget(self, action: #selector(removeCart), for: .touchUpInside)
            return cell
        } else if component == CartComponentEnum.account.name {
            let cell = collectionView.dequeueReusableCell(with: AccountViewCell.self, for: indexPath)
            return cell
        } else if component == CartComponentEnum.guest.name {
            let cell = collectionView.dequeueReusableCell(with: GuestCheckoutViewCell.self, for: indexPath)
            return cell
        } else if component == CartComponentEnum.shippingInfo.name {
            let cell = collectionView.dequeueReusableCell(with: ShippingInfoViewCell.self, for: indexPath)
            if address?.count ?? 0 > 0 {
                cell.address = address?[0]
            }
            return cell
        } else if component == CartComponentEnum.payment.name {
            let cell = collectionView.dequeueReusableCell(with: PaymentMethodViewCell.self, for: indexPath)
            cell.radioBtn1.tag = 0
            cell.radioBtn2.tag = 1
            cell.radioBtn1.addTarget(self, action: #selector(didTapOnPaymentBtn), for: .touchUpInside)
            cell.radioBtn2.addTarget(self, action: #selector(didTapOnPaymentBtn), for: .touchUpInside)
            return cell
        } else if component == CartComponentEnum.summery.name {
            let cell = collectionView.dequeueReusableCell(with: PaymentDetailCell.self, for: indexPath)
            cell.itemsView.lblHeading.text = "Items(\(self.cart?.count_item ?? 0))"
            cell.itemsView.lblValue.text = "\(self.cart?.sub_total ?? 0)"
            cell.shippingView.lblValue.text = "\(self.cart?.shipig ?? 0)"
            cell.priceView.lblHeading.text = "Total"
            cell.priceView.lblValue.text = "\(self.cart?.total ?? 0)"
            
            
            return cell
        } else if component == CartComponentEnum.checkout.name {
            let cell = collectionView.dequeueReusableCell(with: CheckoutButtonCell.self, for: indexPath)
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let component = getComponent(index: indexPath.section)
        if component == CartComponentEnum.cart.name {
            return CGSize(width: collectionView.frame.width - 20 , height: 130)
        } else if component == CartComponentEnum.account.name {
            return CGSize(width: collectionView.frame.width - 20 , height: 130)
        } else if component == CartComponentEnum.guest.name {
            return CGSize(width: collectionView.frame.width - 20 , height: 130)
        } else if component == CartComponentEnum.shippingInfo.name {
            return CGSize(width: collectionView.frame.width - 20 , height: 100)
        } else if component == CartComponentEnum.payment.name {
            return CGSize(width: collectionView.frame.width - 20 , height: 130)
        } else if component == CartComponentEnum.summery.name {
            return CGSize(width: collectionView.frame.width - 20 , height: 200)
        } else if component == CartComponentEnum.checkout.name {
            return CGSize(width: collectionView.frame.width - 20 , height: 55)
        }
        return CGSize(width: collectionView.frame.width - 20 , height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
}



enum CartComponentEnum {
    case cart
    case account
    case guest
    case shippingInfo
    case payment
    case summery
    case checkout

    var name: String {
        switch self {
        case .cart:
            return "cart1"
        case .account:
            return "account"
        case .guest:
            return "guest user"
        case .shippingInfo:
            return "shipping info"
        case .payment:
            return "payment "
        case .summery:
            return "item summery"
        case .checkout:
            return "checkout"
        }
    }
}


enum paymentMethod: String {
    case credit =  "CC"
    case cash = "COD"
}
