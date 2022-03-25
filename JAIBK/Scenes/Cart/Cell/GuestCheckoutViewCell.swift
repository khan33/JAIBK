//
//  GuestCheckoutViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class GuestCheckoutViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
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
        
        let emailView = EnquireTextFieldView(title: "Checkout as a guest", placeholder: "Your Email") { text in
            
        }


        containerView.addSubview(emailView)
        emailView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(containerView)
            make.height.equalTo(77)
            
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).offset(-20)
            
        }
        
    }
}
