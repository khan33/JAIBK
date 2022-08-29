//
//  ShippingViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class ShippingViewCell: UICollectionViewCell {
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
        lbl.text = "Shipping Details"
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var shippingView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var statusView: PreviewKeyValueView!
    private var shippingStatusView: PreviewKeyValueView!
    private var addressView: PreviewKeyValueView!
    
    private func loadUIView()  {
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(contentView).inset(8)
        }
        
    
        if !lblTitle.isDescendant(of: contentView) {
            contentView.addSubview(lblTitle)
        }
        lblTitle.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(8)
        }
        
        if !shippingView.isDescendant(of: contentView) {
            contentView.addSubview(shippingView)
        }
        shippingView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.trailing.equalTo(contentView).offset(-8)
            make.top.equalTo(lblTitle.snp.bottom).offset(8)
            make.bottom.equalTo(contentView)
        }
        
        
        statusView = PreviewKeyValueView(heading: "Date Shipping", value: "September 16, 2021")
        shippingView.addSubview(statusView)
        
        statusView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(shippingView).inset(16)
            make.top.equalTo(shippingView.snp.top).offset(8)
        }
        statusView.containerView.backgroundColor = .clear
        statusView.lblHeading.textColor = .white
        statusView.lblValue.textColor = .white
        
        
        shippingStatusView = PreviewKeyValueView(heading: "Shipping", value: "")
        shippingView.addSubview(shippingStatusView)
        shippingStatusView.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(shippingView).inset(16)
            make.top.equalTo(statusView.snp.bottom).offset(8)
        }
        shippingStatusView.containerView.backgroundColor = .clear
        shippingStatusView.lblHeading.textColor = .white
        shippingStatusView.lblValue.textColor = .white
        
        addressView = PreviewKeyValueView(heading: "Address", value: "")
        shippingView.addSubview(addressView)
        addressView.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(shippingView).inset(16)
            make.top.equalTo(shippingStatusView.snp.bottom).offset(8)
        }
        addressView.containerView.backgroundColor = .clear
        addressView.lblHeading.textColor = .white
        addressView.lblValue.textColor = .white
    }
    
    
    var shipping: ShippingData? {
        didSet {
            guard let data = shipping else { return }
            statusView.lblValue.text = data.date_shiping
            addressView.lblValue.text = data.address
            shippingStatusView.lblValue.text = data.shiping
        }
    }
}
