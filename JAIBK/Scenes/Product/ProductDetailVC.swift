//
//  ProductDetailVC.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit
import SVProgressHUD

class ProductDetailVC: UIViewController {
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 1000)
        return layout
    }()
    
    private (set) lazy var collectionViewHome:UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator  = false
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(SliderViewCell.self, forCellWithReuseIdentifier: "SliderViewCell")
        collectionView.register(ProductInfoViewCell.self, forCellWithReuseIdentifier: "ProductInfoViewCell")
        collectionView.register(ProductMoreInfoCell.self, forCellWithReuseIdentifier: "ProductMoreInfoCell")
        collectionView.register(ProductEnquireNowCell.self, forCellWithReuseIdentifier: "ProductEnquireNowCell")
        collectionView.register(ProdcutReviewCell.self, forCellWithReuseIdentifier: "ProdcutReviewCell")
        collectionView.register(ViewAllCell.self, forCellWithReuseIdentifier: "ViewAllCell")
        collectionView.register(ProductSlider.self, forCellWithReuseIdentifier: "ProductSlider")
        return collectionView;
    }()
    
    
    private (set) lazy var cartView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    lazy var addToCartBtn: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        btn.setTitle("Add to Cart", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(didTapOnAddToCartBtn), for: .touchUpInside)
        return btn
        
    }()
    
    private (set) lazy var quntityView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#C4C4C4").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private (set) lazy var minusBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#223263"), for: .normal)
        btn.setTitle("-", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 20)
        btn.roundCorners([.layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 5, borderColor: UIColor.hexStringToUIColor(hex: "#EBF0FF"), borderWidth: 1)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#C4C4C4")
        btn.tag = 0
        btn.addTarget(self, action: #selector(updateQuntity), for: .touchUpInside)
        return btn
    }()
    
    private (set) lazy var plusBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#223263"), for: .normal)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 20)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#C4C4C4")
        btn.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 5, borderColor: UIColor.hexStringToUIColor(hex: "#EBF0FF"), borderWidth: 1)
        btn.tag = 1
        btn.addTarget(self, action: #selector(updateQuntity), for: .touchUpInside)
        return btn
    }()
    
    private (set) lazy var quantityTxtField: UITextField = { [unowned self] in
        let view = UITextField()
        view.text = "1"
        view.textAlignment = .center
        view.font = UIFont(name: AppFontName.book, size: 13)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    var quantity = 1
    private var product_detail: Products?
    private var review : [Review]?
    private var product_images : [Product_images]?
    private var product_data: ProductDetailData?
    private var related_products: [Products]?
    private var viewComponents : [ProductDetailComponentEnum] = []
    var id: String
    
    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductById(id)
        navConfig()
        setupView()
    }
    
    private func navConfig() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "Item Detail"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc func didTapOnAddToCartBtn() {
        addToCart()
    }
    @objc func updateQuntity(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 0 {
            if quantity > 1 {
                quantity = quantity - 1
            }
        } else {
            quantity = quantity + 1
            
        }
        quantityTxtField.text = String(quantity)
    }
    
    @objc func didTapOnEnquireNowBtn(_ sender: UIButton) {
        let vc = AddEnquireVC(product: product_detail)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func didTapOnWriteReviewBtn(_ sender: UIButton) {
        if let product = product_detail {
            let vc = AddReviewVC(product: product)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getProductById(_ id: String) {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: ProductDetailRequest(id: id), model: ProductDetailModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.product_data = response.data
                        self.product_detail = self.product_data?.product_detail
                        self.product_images = self.product_data?.product_images
                        self.review = self.product_data?.review
                        self.related_products = self.product_data?.related_product
                        self.setUIComponents()
                        self.collectionViewHome.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addToCart() {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: CartRequestModel.AddCartRequest(product_id: self.id, type: "product", quantity: quantity), model: GarageModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.showAlertOkAction(withTitle: "Alert", message: response.message ?? "Cart updated successfully!.") {
//                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func setUIComponents() {
        viewComponents.removeAll()
        viewComponents.append(.slider)
        viewComponents.append(.info)
        viewComponents.append(.moreInfo)
        viewComponents.append(.enquireNow)
        if self.review?.count ?? 0 > 0 {
            viewComponents.append(.review)
        }
        
        if self.related_products?.count ?? 0 > 0 {
            viewComponents.append(.like)
            viewComponents.append(.relatedProduct)
        }
        
        
    }
    
    private func getComponent(index: Int) -> String {
        return viewComponents[index].name
    }
}

extension ProductDetailVC {
    private func setupView() {
        edgesForExtendedLayout = []
        
        if !collectionViewHome.isDescendant(of: view) {
            view.addSubview(collectionViewHome)
        }
        collectionViewHome.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(16)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
        }
        
        if !cartView.isDescendant(of: view) {
            view.addSubview(cartView)
        }
        cartView.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(collectionViewHome.snp.bottom)
            make.bottom.equalTo(view.snp.bottom).offset(-10)
            make.height.equalTo(55)
        }
        
        if !addToCartBtn.isDescendant(of: cartView) {
            cartView.addSubview(addToCartBtn)
        }
        addToCartBtn.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(cartView.snp.trailing).offset(-8)
            make.width.equalTo(cartView).multipliedBy(0.65)
            make.height.equalToSuperview()
        }
        
        if !quntityView.isDescendant(of: cartView) {
            cartView.addSubview(quntityView)
        }
        quntityView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(cartView.snp.leading).offset(8)
            make.trailing.equalTo(addToCartBtn.snp.leading).offset(-8)
            make.height.equalToSuperview()
        }
        
        if !quantityTxtField.isDescendant(of: quntityView) {
            quntityView.addSubview(quantityTxtField)
        }
        quantityTxtField.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(quntityView)
            make.centerY.equalTo(quntityView)
        }
        
        if !plusBtn.isDescendant(of: quntityView) {
            quntityView.addSubview(plusBtn)
        }
        
        plusBtn.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(quntityView)
            make.height.equalToSuperview()
            make.width.equalTo(quntityView).multipliedBy(0.3)
        }
        
        if !minusBtn.isDescendant(of: quntityView) {
            quntityView.addSubview(minusBtn)
        }
        
        minusBtn.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(quntityView)
            make.height.equalToSuperview()
            make.width.equalTo(quntityView).multipliedBy(0.3)
        }
        
    }
}


extension ProductDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewComponents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let component = getComponent(index: indexPath.row)
        
        
        if component == ProductDetailComponentEnum.slider.name {
            let cell = collectionView.dequeueReusableCell(with: SliderViewCell.self, for: indexPath)
            cell.images = self.product_images
            return cell
        }
        else if component == ProductDetailComponentEnum.info.name {
            let cell = collectionView.dequeueReusableCell(with: ProductInfoViewCell.self, for: indexPath)
            cell.data = self.product_detail
            if let total = self.product_data?.total_rating {
                cell.lblTotalReview.text = "(\(String(describing: total)) Reviews)"
            }
            if let avg_rating = product_data?.rating_avg {
                cell.ratingView.rating = Double(avg_rating)
            }

            cell.lblWriteReview.addTarget(self, action: #selector(didTapOnWriteReviewBtn), for: .touchUpInside)
            if self.product_data?.is_review == true {
                cell.lblWriteReview.isHidden = true
            }
            return cell
        }
        else if component == ProductDetailComponentEnum.moreInfo.name  {
            let cell = collectionView.dequeueReusableCell(with: ProductMoreInfoCell.self, for: indexPath)
            cell.info.removeAll()
            cell.product = self.product_detail
            return cell
        }
        else if component == ProductDetailComponentEnum.enquireNow.name  {
            let cell = collectionView.dequeueReusableCell(with: ProductEnquireNowCell.self, for: indexPath)
            cell.enquireNowBtn.addTarget(self, action: #selector(didTapOnEnquireNowBtn), for: .touchUpInside)
            return cell
        }
        else if component == ProductDetailComponentEnum.review.name  {
            let cell = collectionView.dequeueReusableCell(with: ProdcutReviewCell.self, for: indexPath)
            cell.review = review
            if let total = self.product_data?.total_rating {
                cell.lblTotalReview.text = "(\(String(describing: total)) Reviews)"
            }
            if let avg_rating = product_data?.rating_avg {
                cell.ratingView.rating = Double(avg_rating)
            }
            return cell
        }
        else if component == ProductDetailComponentEnum.like.name {
            let cell = collectionView.dequeueReusableCell(with: ViewAllCell.self, for: indexPath)
            cell.lblName.text = "You Might Also Like"
            cell.lblAllView.isHidden = true
            return cell
        }
        else if component == ProductDetailComponentEnum.relatedProduct.name  {
            let cell = collectionView.dequeueReusableCell(with: ProductSlider.self, for: indexPath)
            cell.productSlider = true
            cell.products = self.related_products
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let component = getComponent(index: indexPath.row)
        if component == ProductDetailComponentEnum.slider.name {
            return CGSize(width: collectionView.frame.width , height: 388)
        }
        else if component == ProductDetailComponentEnum.info.name {
            return CGSize(width: collectionView.frame.width , height: 288)
        }
        else if component == ProductDetailComponentEnum.moreInfo.name {
            return CGSize(width: collectionView.frame.width, height: 344)
        }
        else if component == ProductDetailComponentEnum.enquireNow.name{
            return CGSize(width: collectionView.frame.width , height: 88)
        }
        else if component == ProductDetailComponentEnum.review.name {
            return CGSize(width: collectionView.frame.width, height: 320)
        }
        else if component == ProductDetailComponentEnum.like.name {
            return CGSize(width: collectionView.frame.width, height: 88)
        }
        else if component == ProductDetailComponentEnum.relatedProduct.name  {
            return CGSize(width: collectionView.frame.width, height: 220)
        }
        
        return CGSize.zero
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let c = cell as! ProductMoreInfoCell
            c.info.removeAll()
        }
    }
    
}

enum ProductDetailComponentEnum {
    case slider
    case info
    case moreInfo
    case enquireNow
    case review
    case like
    case relatedProduct

    var name: String {
        switch self {
        case .slider:
            return "Image Slider"
        case .info:
            return "Product Info"
        case .moreInfo:
            return "More Info"
        case .enquireNow:
            return "Enquire Now"
        case .review:
            return "Product Review"
        case .like:
            return "like"
        case .relatedProduct:
            return "Related Product"
        }
    }
}
