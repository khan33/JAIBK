//
//  PaymentViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class PaymentViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var cardCoverView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var cardImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "visa")
        return view
    }()
    
    private (set) lazy var lblCardNumber: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "***123"
        lbl.font = UIFont(name: AppFontName.bold, size: 24)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var lblExpireDate: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Expires: 03/2021"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        return lbl
    }()
   
    private (set) lazy var removeBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "remove"), for: .normal)
        btn.setTitle("remove", for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#49B7B1"), for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    private (set) lazy var editBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.setImage(UIImage(named: "remove"), for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#49B7B1"), for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [removeBtn, editBtn])
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 8
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
        
        if !cardCoverView.isDescendant(of: containerView) {
            containerView.addSubview(cardCoverView)
        }
        cardCoverView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.height.equalTo(containerView).multipliedBy(0.8)
            make.width.equalTo(88)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        if !cardImageView.isDescendant(of: cardCoverView) {
            cardCoverView.addSubview(cardImageView)
        }
        cardImageView.snp.makeConstraints { make in
            make.centerY.equalTo(cardCoverView.snp.centerY)
            make.centerX.equalTo(cardCoverView.snp.centerX)
            make.width.equalTo(70)
        }
        
        if !lblCardNumber.isDescendant(of: containerView) {
            containerView.addSubview(lblCardNumber)
        }
        lblCardNumber.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(cardCoverView.snp.trailing).offset(16)
            make.top.equalTo(cardCoverView.snp.top).offset(8)
        }
        
        
        if !lblExpireDate.isDescendant(of: containerView) {
            containerView.addSubview(lblExpireDate)
        }
        lblExpireDate.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(lblCardNumber.snp.leading)
            make.top.equalTo(lblCardNumber.snp.bottom).offset(8)
        }
        
        
        
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(lblCardNumber.snp.leading)
            make.top.equalTo(lblExpireDate.snp.bottom).offset(8)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
}
