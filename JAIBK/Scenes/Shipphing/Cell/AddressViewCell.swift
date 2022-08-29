//
//  AddressViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 12/08/2022.
//

import UIKit

class AddressViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [lblName, lblAddress, lblPhone, btnStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 4
        view.clipsToBounds = true
        return view
    }()
    
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: AppFontName.bold, size: 14)
        lbl.text = "Hamza awan"
        return lbl
    }()
    
    private (set) lazy var lblAddress: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 11)
        lbl.text = "Expire: 03/2021"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")

        return lbl
    }()
    
    
    private (set) lazy var lblPhone: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 11)
        lbl.text = "0320023234"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")

        return lbl
    }()
    
    
    private (set) lazy var btnStackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [selectedBtn, editBtn, removeBtn])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private (set) lazy var removeBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitle("DELETE", for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#e62e2e")
        btn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.layer.cornerRadius = 4
        return btn
        
    }()
    
    private (set) lazy var editBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitle("EDIT", for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#FFFFFF"), for: .normal)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#89CFF0")
        btn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    private (set) lazy var selectedBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitle("SELECTED", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#fcfcfc"), for: .normal)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        btn.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        btn.layer.cornerRadius = 4
        return btn
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
        
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        containerView.layoutIfNeeded()
        containerView.setGradientBorder(width: 2.0, colors: [UIColor.hexStringToUIColor(hex: "#6082E0"), UIColor.hexStringToUIColor(hex: "#49B7B1")])
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview().inset(16)
        }
        
        btnStackView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    var address: AddressData? {
        didSet {
            guard let data = address else { return }
            lblName.text = data.fullName
            lblPhone.text = data.phone_no
            lblAddress.text = data.fullAddress
        }
    }
    
    
}

