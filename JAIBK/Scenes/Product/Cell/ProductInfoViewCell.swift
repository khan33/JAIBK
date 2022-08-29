//
//  ProductInfoViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit
import Cosmos

class ProductInfoViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        return view
    }()
    private (set) lazy var lblBrand: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Brand Name"
//        UIColor.hexStringToUIColor(hex: "#000000")
        lbl.font = UIFont(name: AppFontName.book, size: 14)

        return lbl
    }()
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Product title goes here"
        lbl.font = UIFont(name: AppFontName.bold, size: 24)

        return lbl
    }()
    private (set) lazy var ratingView: CosmosView = {[unowned self] in
        let cosmosView = CosmosView()
        cosmosView.rating = 0
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.fillMode = .full
        cosmosView.settings.starSize = 10
        cosmosView.settings.starMargin = 2
        cosmosView.settings.filledColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        cosmosView.settings.filledImage = UIImage(named: "StarFilled")
        cosmosView.settings.emptyImage = UIImage(named: "StarEmpty")
        return cosmosView
    }()
    
    private (set) lazy var lblTotalReview: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.medium, size: 14)
        lbl.text = "(0 Reviews)"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#9B9B9B")
        return lbl
    }()
    private (set) lazy var lblWriteReview: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: AppFontName.medium, size: 14)
        btn.setTitle("Write a Review", for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#9B9B9B"), for: .normal)
        return btn
    }()
    
    
    private (set) lazy var lblPrice: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.bold, size: 14)
        lbl.text = "AED 450"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#6082E0")
        return lbl
    }()
    
    private (set) lazy var lblProductInfo: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.bold, size: 14)
        lbl.text = "Product info"
        lbl.textColor = .black
        
        return lbl
    }()
    private (set) lazy var lblProductDesc: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.text = ""
        UIColor.hexStringToUIColor(hex: "#000000")
        lbl.numberOfLines = 0
        return lbl
    }()
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let attributedString = NSMutableAttributedString(string: "Write a Review")
        let range: NSRange = attributedString.mutableString.range(of: "Write a Review", options: .caseInsensitive)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)

        lblWriteReview.setAttributedTitle(attributedString, for: .normal)
        loadUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    var data: Products? {
        didSet {
            guard let item = data else { return }
            lblBrand.text = item.brand_name
            lblName.text = item.title
            lblProductDesc.text = item.description
            
            if let price =  item.price {
                lblPrice.text = "AED \(String(describing: price))"
            }
        }
    }
    
    private func loadUIView()  {
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        
        if !lblBrand.isDescendant(of: containerView) {
            containerView.addSubview(lblBrand)
        }
        lblBrand.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        if !lblName.isDescendant(of: containerView) {
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(lblBrand.snp.bottom).offset(8)
        }

        if !ratingView.isDescendant(of: containerView) {
            containerView.addSubview(ratingView)
        }
        ratingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(lblName.snp.bottom).offset(8)
        }

        if !lblTotalReview.isDescendant(of: containerView) {
            containerView.addSubview(lblTotalReview)
        }
        lblTotalReview.snp.makeConstraints { make in
            make.leading.equalTo(ratingView.snp.trailing).offset(4)
            make.top.equalTo(lblName.snp.bottom).offset(8)
        }

        if !lblWriteReview.isDescendant(of: containerView) {
            containerView.addSubview(lblWriteReview)
        }
        lblWriteReview.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(lblName.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.width.equalTo(120)
        }
        if !lblPrice.isDescendant(of: containerView) {
            containerView.addSubview(lblPrice)
        }
        lblPrice.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(ratingView.snp.bottom).offset(10)
        }


        if !lblProductInfo.isDescendant(of: containerView) {
            containerView.addSubview(lblProductInfo)
        }
        lblProductInfo.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(lblPrice.snp.bottom).offset(16)
        }

        if !lblProductDesc.isDescendant(of: containerView) {
            containerView.addSubview(lblProductDesc)
        }
        lblProductDesc.snp.remakeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(lblProductInfo.snp.bottom).offset(10)
            make.bottom.equalTo(containerView.snp.bottom).offset(-16)
        }
        
    }
    
}
