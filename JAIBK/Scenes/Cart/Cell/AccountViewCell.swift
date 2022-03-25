//
//  AccountViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class AccountViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var lblAccount: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Have an account ?"
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var lblCreateAccount: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Log in or create an account for faster checkout."
        lbl.font = UIFont(name: AppFontName.book, size: 14)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIView()
        let attributedString = NSMutableAttributedString(string: "LOGIN or create an account for faster checkout.")
        let loginRange: NSRange = attributedString.mutableString.range(of: "LOGIN", options: .caseInsensitive)
        let createRange: NSRange = attributedString.mutableString.range(of: "create an account", options: .caseInsensitive)
        
        
        
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.hexStringToUIColor(hex: "#49B7B1"), range: loginRange)
        attributedString.addAttribute(.font, value: UIFont(name: AppFontName.bold, size: 14), range: loginRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: loginRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.hexStringToUIColor(hex: "#49B7B1"), range: createRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: createRange)
        attributedString.addAttribute(.font, value: UIFont(name: AppFontName.bold, size: 14), range: createRange)
        lblCreateAccount.attributedText = attributedString
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
        
        
        if !lblAccount.isDescendant(of: containerView) {
            containerView.addSubview(lblAccount)
        }
        lblAccount.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(24)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
        }
        
        if !lblCreateAccount.isDescendant(of: containerView) {
            containerView.addSubview(lblCreateAccount)
        }
        lblCreateAccount.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(lblAccount.snp.top).offset(36)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
        }
    }
}
