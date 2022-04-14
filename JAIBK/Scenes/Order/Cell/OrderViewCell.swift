//
//  OrderViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class OrderViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var lblOrderId: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "LQNSU346JK"
        lbl.font = UIFont(name: AppFontName.bold, size: 14)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        return lbl
    }()
    private (set) lazy var lblOrderDate: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "Order at E-comm : Jan 1, 2021"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    
    
    
    private (set) lazy var dottedView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIView()
        
        
        
    }
    
    private var priceView: PreviewKeyValueView!
    private var itemsView: PreviewKeyValueView!
    private var statusView: PreviewKeyValueView!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUIView()  {
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(contentView).inset(8)
        }
        containerView.layoutIfNeeded()
        containerView.setGradientBorder(width: 2.0, colors: [UIColor.hexStringToUIColor(hex: "#6082E0"), UIColor.hexStringToUIColor(hex: "#49B7B1")])
        
        if !lblOrderId.isDescendant(of: containerView) {
            containerView.addSubview(lblOrderId)
        }
        lblOrderId.snp.remakeConstraints { make in
            make.leading.top.equalTo(containerView).offset(16)
        }
        
        
        if !lblOrderDate.isDescendant(of: containerView) {
            containerView.addSubview(lblOrderDate)
        }
        lblOrderDate.snp.remakeConstraints { make in
            make.leading.equalTo(lblOrderId)
            make.top.equalTo(lblOrderId.snp.bottom).offset(16)
        }
        if !dottedView.isDescendant(of: containerView) {
            containerView.addSubview(dottedView)
        }
        dottedView.snp.remakeConstraints { make in
            make.leading.equalTo(lblOrderId)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(lblOrderDate.snp.bottom).offset(16)
            make.height.equalTo(10)
        }
        dottedView.layoutIfNeeded()
        dottedView.makeDashedBorderLine(color: UIColor.hexStringToUIColor(hex: "#949494"), strokeLength: 7, gapLength: 5, width: 2, orientation: .horizontal)
        
        statusView = PreviewKeyValueView(heading: "Order Status", value: "Shipping")
        containerView.addSubview(statusView)
        statusView.snp.makeConstraints{ make in
            make.leading.equalTo(lblOrderId)
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
            make.top.equalTo(dottedView.snp.bottom)
        }
        
        itemsView = PreviewKeyValueView(heading: "Items", value: "2 Items purchased")
        containerView.addSubview(itemsView)
        itemsView.snp.makeConstraints{ make in
            make.leading.equalTo(lblOrderId)
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
            make.top.equalTo(statusView.snp.bottom)
        }
        
        priceView = PreviewKeyValueView(heading: "Price", value: "AED 300.00")
        containerView.addSubview(priceView)
        priceView.snp.makeConstraints{ make in
            make.leading.equalTo(lblOrderId)
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
            make.top.equalTo(itemsView.snp.bottom)
        }
        priceView.lblValue.font = UIFont(name: AppFontName.bold, size: 12)
        priceView.lblHeading.font = UIFont(name: AppFontName.bold, size: 12)
    }
    
    
    
    var order: OrderData? {
        didSet {
            guard let data = order else { return }
            lblOrderId.text = data.order_id
            lblOrderDate.text = data.added_on
            itemsView.lblValue.text = "\(data.items!) Items purchased"
            statusView.lblValue.text = data.status
            priceView.lblValue.text = "AED \(data.price!)"
        }
    }
    
    
    
}
