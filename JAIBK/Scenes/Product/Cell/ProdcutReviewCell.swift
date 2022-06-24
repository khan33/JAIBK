//
//  ProdcutReviewCell.swift
//  JAIBK
//
//  Created by Atta khan on 20/04/2022.
//

import UIKit
import Cosmos

class ProdcutReviewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        return view
    }()
    private (set) lazy var lblReviewProduct: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.text = "Review Product"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.numberOfLines = 0
        return lbl
    }()
    private (set) lazy var lblSeeMore: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.text = "See More"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private (set) lazy var ratingView: CosmosView = {[unowned self] in
        let cosmosView = CosmosView()
        cosmosView.rating = 2
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.fillMode = .full
        cosmosView.settings.starSize = 10
        cosmosView.settings.starMargin = 2
        cosmosView.settings.filledColor = UIColor.hexStringToUIColor(hex: "#FFA900")
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
    private (set) lazy var avatarImgView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit //.scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = .clear // .red
        view.image = UIImage(named:  "Profile")
        return view
    }()
    
    private (set) lazy var lblUserNmae: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.text = "James Lawson"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.numberOfLines = 0
        return lbl
    }()
    private (set) lazy var userRatingView: CosmosView = {[unowned self] in
        let cosmosView = CosmosView()
        cosmosView.rating = 3
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.fillMode = .full
        cosmosView.settings.starSize = 10
        cosmosView.settings.starMargin = 2
        cosmosView.settings.filledColor = UIColor.hexStringToUIColor(hex: "#FFA900")
        cosmosView.settings.filledImage = UIImage(named: "StarFilled")
        cosmosView.settings.emptyImage = UIImage(named: "StarEmpty")
        return cosmosView
    }()
    private (set) lazy var lblRatingDesc: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.text = "We need to confirm our protocol PinterestLayoutDelegate that we had created earlier which ask our ViewController about the height of the cell but how will we calculate it? We‘re going to write two functions one to calculate the appropriate photo’s height and another to calculate the required space to display the description so let’s start with the first one.         Here we need our API to provide so important information to help us figure out the perfect size based on the image aspect ratio to do so the backend developer must supply the dimensions of the photo as shown below"
        UIColor.hexStringToUIColor(hex: "#000000")
        lbl.numberOfLines = 0
        return lbl
    }()
    private (set) lazy var imgView1: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit //.scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = .clear // .red
        
        view.image = UIImage(named:  "Profile")
        return view
    }()
    
    private (set) lazy var imgView2: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit //.scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = .clear // .red
        
        view.image = UIImage(named:  "Profile")
        return view
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
        loadUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    private func loadUIView()  {
        
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        if !lblReviewProduct.isDescendant(of: containerView) {
            containerView.addSubview(lblReviewProduct)
        }
        lblReviewProduct.snp.remakeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        if !lblSeeMore.isDescendant(of: containerView) {
            containerView.addSubview(lblSeeMore)
        }
        lblSeeMore.snp.remakeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
        if !ratingView.isDescendant(of: containerView) {
            containerView.addSubview(ratingView)
        }
        ratingView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(lblReviewProduct.snp.bottom).offset(8)
        }
        if !lblTotalReview.isDescendant(of: containerView) {
            containerView.addSubview(lblTotalReview)
        }
        lblTotalReview.snp.remakeConstraints { make in
            make.leading.equalTo(ratingView.snp.trailing).offset(8)
            make.top.equalTo(lblReviewProduct.snp.bottom).offset(8)
        }
        
        if !avatarImgView.isDescendant(of: containerView) {
            containerView.addSubview(avatarImgView)
        }
        avatarImgView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(lblTotalReview.snp.bottom).offset(16)
            make.width.height.equalTo(88)
            
        }
        if !lblUserNmae.isDescendant(of: containerView) {
            containerView.addSubview(lblUserNmae)
        }
        lblUserNmae.snp.remakeConstraints { make in
            make.leading.equalTo(avatarImgView.snp.trailing).offset(16)
            make.top.equalTo(avatarImgView.snp.top).offset(16)
        }
        
        if !userRatingView.isDescendant(of: containerView) {
            containerView.addSubview(userRatingView)
        }
        userRatingView.snp.remakeConstraints { make in
            make.top.equalTo(lblUserNmae.snp.bottom).offset(8)
            make.leading.equalTo(lblUserNmae)
            
        }
        if !lblRatingDesc.isDescendant(of: containerView) {
            containerView.addSubview(lblRatingDesc)
        }
        lblRatingDesc.snp.remakeConstraints { make in
            make.top.equalTo(avatarImgView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        imgView1.image = UIImage(named: "image 30")
        imgView1.layer.cornerRadius = 12
        if !imgView1.isDescendant(of: containerView) {
            containerView.addSubview(imgView1)
        }
        imgView1.snp.remakeConstraints { make in
            make.top.equalTo(lblRatingDesc.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(88)
            make.bottom.equalTo(containerView).offset(-10)
        }
        imgView2.image = UIImage(named: "image 31")
        imgView2.layer.cornerRadius = 12
        if !imgView2.isDescendant(of: containerView) {
            containerView.addSubview(imgView2)
        }
        imgView2.snp.remakeConstraints { make in
            make.top.equalTo(lblRatingDesc.snp.bottom).offset(16)
            make.leading.equalTo(imgView1.snp.trailing).offset(16)
            make.width.height.equalTo(88)
            make.bottom.equalTo(containerView).offset(-10)
        }
        
    }
}
