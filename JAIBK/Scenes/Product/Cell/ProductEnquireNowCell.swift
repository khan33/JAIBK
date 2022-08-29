//
//  ProductEnquireNowCell.swift
//  JAIBK
//
//  Created by Atta khan on 20/04/2022.
//

import UIKit

class ProductEnquireNowCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        return view
    }()
        
        
    private (set) lazy var lblNeedHelp: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.text = "Need help on this product ?"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var enquireNowBtn: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        btn.setTitle("Enquire Now", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 6
        return btn
        
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
        
        
        
        if !lblNeedHelp.isDescendant(of: containerView) {
            containerView.addSubview(lblNeedHelp)
        }
        lblNeedHelp.snp.remakeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
        }
        if !enquireNowBtn.isDescendant(of: containerView) {
            containerView.addSubview(enquireNowBtn)
        }
        enquireNowBtn.snp.remakeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(16)
            make.width.equalTo(containerView).multipliedBy(0.4)
        }
        
    }
}
