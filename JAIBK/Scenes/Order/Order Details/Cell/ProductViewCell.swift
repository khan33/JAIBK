//
//  ProductViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
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
        lbl.text = "Brake caliper grease niglube"
        lbl.font = UIFont(name: AppFontName.bold, size: 13)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var lblBrandName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Brand Name here"
        lbl.font = UIFont(name: AppFontName.book, size: 10)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#4F4F4F")
        return lbl
    }()
    private (set) lazy var lblPrice: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "160.00"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        return lbl
    }()
    private (set) lazy var lblProduct: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Product"
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUIView()  {
        
        if !lblProduct.isDescendant(of: contentView) {
            contentView.addSubview(lblProduct)
        }
        lblProduct.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView).offset(8)
        }
        
        
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(lblProduct.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(contentView).inset(8)
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
        
    }
    
    
    var data: OrderDetailData? {
        didSet {
            guard let data = data else { return }
            lblProductName.text = data.name
            lblPrice.text = data.price
            lblBrandName.text = data.brand_name
            if let img = data.image {
                productImageView.sd_setImage(with: URL(string: Constant.baseURL + "images/products/" + img), placeholderImage: UIImage(named: "item"))
            }
        }
    }
}
