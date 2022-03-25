//
//  ProductCell.swift
//  JAIBK
//
//  Created by Atta khan on 08/03/2022.
//

import UIKit
import Cosmos

class ProductCell: UICollectionViewCell {
    private (set) lazy var productContainerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    
    private (set) lazy var imageContainerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    
    private (set) lazy var productImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit //.scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = .clear // .red
        return view
    }()
    
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = UIFont(name: AppFontName.book, size: 11)
        lbl.text = "CUSTOM WHEELS"
        return lbl
    }()
    
    private (set) lazy var lblBrand: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 11)
        lbl.text = "BRAND NAME"
        return lbl
    }()
    
    private (set) lazy var lblDesc: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: AppFontName.bold, size: 11)
        lbl.text = "Sport Body Parts fo Shevrolet 2015-2017"
        return lbl
    }()
    
    
    
    private (set) lazy var ratingView: CosmosView = {[unowned self] in
        let cosmosView = CosmosView()
        cosmosView.rating = 4
        cosmosView.settings.updateOnTouch = false

        cosmosView.settings.fillMode = .full
        // Other fill modes: .half, .precise

        // Change the size of the stars
        cosmosView.settings.starSize = 12

        // Set the distance between stars
        cosmosView.settings.starMargin = 3

        // Set the color of a filled star
        cosmosView.settings.filledColor = UIColor.orange

        // Set the border color of an empty star
        //cosmosView.settings.emptyBorderColor = UIColor.orange

        // Set the border color of a filled star
        //cosmosView.settings.filledBorderColor = UIColor.orange
        // Set image for the filled star
        cosmosView.settings.filledImage = UIImage(named: "StarFilled")

        // Set image for the empty star
        cosmosView.settings.emptyImage = UIImage(named: "StarEmpty")
        return cosmosView
    }()
    
    
    private (set) lazy var lblReviews: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 11, weight: .regular)
        lbl.text = "(10 Reviews)"
        return lbl
    }()
    private (set) lazy var lblPrice: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.medium, size: 11)
        lbl.text = "AED 450"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#6082E0")
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
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        if !productContainerView.isDescendant(of: contentView) {
            contentView.addSubview(productContainerView)
        }
        productContainerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading) // .offset(8)
            make.trailing.equalTo(contentView.snp.trailing) // .offset(-8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }
        
        if !imageContainerView.isDescendant(of: productContainerView) {
            productContainerView.addSubview(imageContainerView)
        }
        imageContainerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(productContainerView.snp.top).offset(8)
            make.leading.equalTo(productContainerView.snp.leading).offset(16)
            make.trailing.equalTo(productContainerView.snp.trailing).offset(-16)
            make.height.equalTo(120)
        }
        
        
        if !productImageView.isDescendant(of: imageContainerView) {
            imageContainerView.addSubview(productImageView)
        }
        productImageView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(imageContainerView.snp.bottom).offset(-4)
            make.leading.equalTo(imageContainerView.snp.leading).offset(8)
            make.top.equalTo(imageContainerView.snp.top).offset(4)
            make.trailing.equalTo(imageContainerView.snp.trailing).offset(-8)
        }
        
        productImageView.image = UIImage(named: "item")
        
        
        if !lblName.isDescendant(of: productContainerView) {
            productContainerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(imageContainerView.snp.leading).offset(8)
            make.top.equalTo(productImageView.snp.bottom).offset(16)
        }
        
        
        if !lblBrand.isDescendant(of: productContainerView) {
            productContainerView.addSubview(lblBrand)
        }
        lblBrand.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(lblName.snp.trailing).offset(8)
            make.trailing.equalTo(imageContainerView.snp.trailing)
            make.top.equalTo(productImageView.snp.bottom).offset(16)
        }
        
        if !lblDesc.isDescendant(of: productContainerView) {
            productContainerView.addSubview(lblDesc)
        }
        lblDesc.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(imageContainerView.snp.leading).offset(8)
            make.trailing.equalTo(imageContainerView.snp.trailing).offset(-8)
            make.top.equalTo(lblName.snp.bottom).offset(10)
        }
        
        if !ratingView.isDescendant(of: productContainerView) {
            productContainerView.addSubview(ratingView)
        }
        ratingView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(imageContainerView.snp.leading).offset(8)
//            make.trailing.equalTo(imageContainerView.snp.trailing).offset(-8)
            make.top.equalTo(lblDesc.snp.bottom).offset(10)
        }
        
        
        
        if !lblReviews.isDescendant(of: productContainerView) {
            productContainerView.addSubview(lblReviews)
        }
        lblReviews.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(ratingView.snp.trailing).offset(8)
            make.trailing.equalTo(imageContainerView.snp.trailing).offset(-8)
            make.centerY.equalTo(ratingView.snp.centerY)
        }
        
        
        if !lblPrice.isDescendant(of: productContainerView) {
            productContainerView.addSubview(lblPrice)
        }
        lblPrice.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(imageContainerView.snp.leading).offset(8)
            make.trailing.equalTo(productContainerView.snp.trailing).offset(-8)
            make.top.equalTo(ratingView.snp.bottom).offset(8)
        }
    }
}
