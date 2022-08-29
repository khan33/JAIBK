//
//  PaymentDetailCell.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class PaymentDetailCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var lblTitle: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Payment Details"
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var dottedView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    
    var shippingView: PreviewKeyValueView!
    var itemsView: PreviewKeyValueView!
    var priceView: PreviewKeyValueView!
    
    
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
        if !lblTitle.isDescendant(of: contentView) {
            contentView.addSubview(lblTitle)
        }
        lblTitle.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(8)
        }
        
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(contentView).inset(8)
        }
        containerView.layoutIfNeeded()
        containerView.setGradientBorder(width: 2.0, colors: [UIColor.hexStringToUIColor(hex: "#6082E0"), UIColor.hexStringToUIColor(hex: "#49B7B1")])
        
        
        itemsView = PreviewKeyValueView(heading: "Items(2)", value: "0.00")
        containerView.addSubview(itemsView)
        itemsView.snp.makeConstraints{ make in
            make.leading.top.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
        }
        
        shippingView = PreviewKeyValueView(heading: "Shipping", value: "0.00")
        containerView.addSubview(shippingView)
        
        
        shippingView.snp.makeConstraints{ make in
            make.leading.equalTo(itemsView)
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
            make.top.equalTo(itemsView.snp.bottom)
        }
        
        if !dottedView.isDescendant(of: containerView) {
            containerView.addSubview(dottedView)
        }
        dottedView.snp.remakeConstraints { make in
            make.leading.equalTo(itemsView)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(shippingView.snp.bottom).offset(16)
            make.height.equalTo(10)
        }
        dottedView.layoutIfNeeded()
        dottedView.makeDashedBorderLine(color: UIColor.hexStringToUIColor(hex: "#949494"), strokeLength: 7, gapLength: 5, width: 2, orientation: .horizontal)
        
        priceView = PreviewKeyValueView(heading: "Price", value: "0.00")
        containerView.addSubview(priceView)
        priceView.snp.makeConstraints{ make in
            make.leading.equalTo(itemsView)
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
            make.top.equalTo(dottedView.snp.bottom)
        }
        priceView.lblValue.font = UIFont(name: AppFontName.bold, size: 12)
        priceView.lblHeading.font = UIFont(name: AppFontName.bold, size: 12)
    }
    
    var data: OrderDetailModel? {
        didSet {
            guard let item = data else { return }
            itemsView.lblHeading.text = "Items(\(item.total_items!))"
            itemsView.lblValue.text = "\(item.total_items!) Items purchased"
            priceView.lblValue.text = "AED \(item.total!)"
            shippingView.lblValue.text = "\(item.shiping!)"
        }
    }
}
