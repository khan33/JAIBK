//
//  ShippingInfoViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/08/2022.
//

import UIKit

class ShippingInfoViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private (set) lazy var lblShipping: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        lbl.text = "Shipping Info"
        lbl.font = UIFont(name: AppFontName.bold, size: 13)
        lbl.textColor = .white
        return lbl
    }()
    
    private (set) lazy var lblAddress: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Johar Town J blacok house number 175, Lahore Pakistan"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = .white
        return lbl
    }()
    
    private (set) lazy var lblAddAddress: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Add Address"
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.textColor = .white
        return lbl
    }()
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: AppFontName.bold, size: 16),
              .foregroundColor: UIColor.white,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attributeString = NSMutableAttributedString(
                string: "Add Address",
                attributes: attributes
             )
        lblAddAddress.attributedText = attributeString
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
      
        
        if !lblShipping.isDescendant(of: containerView) {
            containerView.addSubview(lblShipping)
        }
        lblShipping.snp.makeConstraints { (make) -> Void in
            make.leading.top.equalToSuperview().offset(16)
        }
        if !lblAddAddress.isDescendant(of: containerView) {
            containerView.addSubview(lblAddAddress)
        }
        lblAddAddress.snp.makeConstraints { (make) -> Void in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        if !lblAddress.isDescendant(of: containerView) {
            containerView.addSubview(lblAddress)
        }
        lblAddress.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(lblShipping.snp.bottom).offset(16)
        }
    }
    
    var address: AddressData? {
        didSet {
            guard let item = address else { return }
            lblAddress.text = item.fullAddress
        }
    }
    
    
    
}
