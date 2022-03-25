//
//  PreviewKeyValueView.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class PreviewKeyValueView: UIView {
    
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var lblHeading: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Order Status"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.textAlignment = .left
        return lbl
    }()
    private (set) lazy var lblValue: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Shipping"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.textAlignment = .right
        return lbl
    }()
    
    init(heading: String, value: String, isBorderView: Bool = false) {
        super.init(frame: CGRect.zero)
        lblHeading.text = heading
        lblValue.text = value
        
        setUpContainerView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpContainerView() {
        if !containerView.isDescendant(of: self) {
            self.addSubview(containerView)
        }
        containerView.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        if !lblHeading.isDescendant(of: containerView) {
            containerView.addSubview(lblHeading)
        }
        lblHeading.snp.remakeConstraints { make in
            make.leading.equalTo(containerView)
            make.top.equalTo(containerView.snp.top).offset(8)
            make.width.equalTo(containerView).multipliedBy(0.45)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
        }
        if !lblValue.isDescendant(of: containerView) {
            containerView.addSubview(lblValue)
        }
        lblValue.snp.remakeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(containerView.snp.top).offset(8)
            make.width.equalTo(containerView).multipliedBy(0.45)
        }
        
    }
    
}
