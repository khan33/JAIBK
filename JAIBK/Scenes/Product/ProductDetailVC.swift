//
//  ProductDetailVC.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class ProductDetailVC: UIViewController {
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
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
        return btn
    }()
    
    private (set) lazy var plusBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#223263"), for: .normal)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 20)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#C4C4C4")
        btn.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 5, borderColor: UIColor.hexStringToUIColor(hex: "#EBF0FF"), borderWidth: 1)
        return btn
    }()
    
    private (set) lazy var quantityTxtField: UITextField = { [unowned self] in
        let view = UITextField()
        view.text = "1"
        view.textAlignment = .center
        view.font = UIFont(name: AppFontName.book, size: 11)
        
        return view
    }()
    
    private var product_detail: Products?
    private var review : [Review]?
    private var product_images : [Product_images]?
    private var product_data: ProductDetailData?
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
    

    private func getProductById(_ id: String) {
        ServiceManager.shared.sendRequest(request: ProductDetailRequest(id: id), model: ProductDetailModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.product_data = response.data
                        self.product_detail = self.product_data?.product_detail
                        self.product_images = self.product_data?.product_images
                        self.review = self.product_data?.review
                        self.collectionViewHome.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
            make.width.equalTo(quntityView).multipliedBy(0.2)
        }
        
        if !minusBtn.isDescendant(of: quntityView) {
            quntityView.addSubview(minusBtn)
        }
        
        minusBtn.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(quntityView)
            make.height.equalToSuperview()
            make.width.equalTo(quntityView).multipliedBy(0.2)
        }
        
    }
}


extension ProductDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(with: SliderViewCell.self, for: indexPath)
            cell.images = self.product_images
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(with: ProductInfoViewCell.self, for: indexPath)
            cell.data = self.product_detail
            if let total = self.product_data?.total_rating {
                cell.lblTotalReview.text = "(\(String(describing: total)) Reviews)"
            }
            if let avg_rating = product_data?.rating_avg {
                cell.ratingView.rating = Double(avg_rating)
            }
            return cell
        } else if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(with: ProductMoreInfoCell.self, for: indexPath)
            cell.info.removeAll()
            cell.product = self.product_detail
            return cell
        } else if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(with: ProductEnquireNowCell.self, for: indexPath)
            return cell
        } else if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(with: ProdcutReviewCell.self, for: indexPath)
            return cell
        } else if indexPath.row == 5 {
            let cell = collectionView.dequeueReusableCell(with: ViewAllCell.self, for: indexPath)
            cell.lblName.text = "You Might Also Like"
            cell.lblAllView.isHidden = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: ProductSlider.self, for: indexPath)
            cell.products = []
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let c = cell as! ProductMoreInfoCell
            c.info.removeAll()
        }
    }
    
}

