//
//  CartViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class CartViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var imgCoverView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#EFEFEF")
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var productImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "item")
        return view
    }()
    
    private (set) lazy var lblProductName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        lbl.text = ""
        lbl.font = UIFont(name: AppFontName.bold, size: 11)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var lblBrandName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = ""
        lbl.font = UIFont(name: AppFontName.book, size: 10)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#4F4F4F")
        return lbl
    }()
    private (set) lazy var lblPrice: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = ""
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        return lbl
    }()
    private (set) lazy var removeBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "Trash"), for: .normal)
        btn.setTitle("", for: .normal)
        return btn
    }()
    private (set) lazy var minusBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#223263"), for: .normal)
        btn.setTitle("-", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 20)
        btn.roundCorners([.layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 5, borderColor: UIColor.hexStringToUIColor(hex: "#EBF0FF"), borderWidth: 1)
        return btn
    }()
    
    private (set) lazy var plusBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#223263"), for: .normal)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 20)
        
        btn.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 5, borderColor: UIColor.hexStringToUIColor(hex: "#EBF0FF"), borderWidth: 1)
        return btn
    }()
    
    private (set) lazy var quantityTxtField: UITextField = { [unowned self] in
        let view = UITextField()
        view.text = "1"
        view.textAlignment = .center
        view.font = UIFont(name: AppFontName.book, size: 11)
        view.textColor = UIColor.hexStringToUIColor(hex: "#223263")
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#EBF0FF")
        return view
    }()
    
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [minusBtn, quantityTxtField ,plusBtn])
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 0
        view.clipsToBounds = true
        return view
    }()
    
    var quantity: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        quantityTxtField.isUserInteractionEnabled = false
        loadUIView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUIView()  {
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(contentView).inset(8)
        }
        containerView.layoutIfNeeded()
        containerView.setGradientBorder(width: 2.0, colors: [UIColor.hexStringToUIColor(hex: "#6082E0"), UIColor.hexStringToUIColor(hex: "#49B7B1")])
        
        if !imgCoverView.isDescendant(of: containerView) {
            containerView.addSubview(imgCoverView)
        }
        imgCoverView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.height.equalTo(containerView).multipliedBy(0.8)
            make.width.equalTo(88)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        if !productImageView.isDescendant(of: imgCoverView) {
            imgCoverView.addSubview(productImageView)
        }
        productImageView.snp.makeConstraints { make in
            make.centerY.equalTo(imgCoverView.snp.centerY)
            make.centerX.equalTo(imgCoverView.snp.centerX)
            make.width.equalTo(70)
        }
        
        if !lblProductName.isDescendant(of: containerView) {
            containerView.addSubview(lblProductName)
        }
        lblProductName.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(imgCoverView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(imgCoverView.snp.top).offset(8)
        }
        
        
        if !lblBrandName.isDescendant(of: containerView) {
            containerView.addSubview(lblBrandName)
        }
        lblBrandName.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(lblProductName.snp.leading)
            make.top.equalTo(lblProductName.snp.bottom).offset(8)
        }
        if !lblPrice.isDescendant(of: containerView) {
            containerView.addSubview(lblPrice)
        }
        lblPrice.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(lblProductName.snp.leading)
            make.top.equalTo(lblBrandName.snp.bottom).offset(8)
        }
        if !removeBtn.isDescendant(of: containerView) {
            containerView.addSubview(removeBtn)
        }
        removeBtn.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(imgCoverView.snp.top).offset(8)
            make.height.width.equalTo(21)
        }
        
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(lblBrandName.snp.bottom).offset(8)
            make.width.equalTo(120)
        }
    }
    
    var product: CartData? {
        didSet {
            guard let item = product else { return }
            lblProductName.text = item.title
            lblBrandName.text = item.brand_name
            
            lblPrice.text = "AED \(String(describing: item.price!))"
            
            if let img = item.image {
                productImageView.sd_setImage(with: URL(string: Constant.baseURL + "images/products/" + img), placeholderImage: UIImage(named: "item"))
            }
            
            quantityTxtField.text = item.quantity
            
        }
    }
    
    
    
}
