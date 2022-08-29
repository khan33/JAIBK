//
//  PaymentMethodViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class PaymentMethodViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#6082E0")
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private (set) lazy var lblPayment: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Select Payment Method"
        lbl.font = UIFont(name: AppFontName.bold, size: 13)
        lbl.textColor = .white
        return lbl
    }()
    
    private (set) lazy var radioBtn1: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        return btn
    }()
    
    private (set) lazy var radioBtn2: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        return btn
    }()
    
    
    
    private (set) lazy var cashImgView: UIImageView = {[unowned self] in
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Credit")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private (set) lazy var cardImgView: UIImageView = {[unowned self] in
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Paypal")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    private (set) lazy var lblCash: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Credit Card or Debit"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = .white
        return lbl
    }()
    
    private (set) lazy var lblCard: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Method two"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = .white
        return lbl
    }()
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
               
        let origImage = UIImage(named: "radiobutton_select")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        radioBtn1.setImage(tintedImage, for: .normal)
        radioBtn1.tintColor = .white
        
        let origImage1 = UIImage(named: "radiobutton_deselect")
        let tintedImage1 = origImage1?.withRenderingMode(.alwaysTemplate)
        radioBtn2.setImage(tintedImage1, for: .normal)
        radioBtn2.tintColor = .white
        
        
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
      
        
        if !lblPayment.isDescendant(of: containerView) {
            containerView.addSubview(lblPayment)
        }
        lblPayment.snp.makeConstraints { (make) -> Void in
            make.leading.top.equalToSuperview().offset(16)
        }
        if !radioBtn1.isDescendant(of: containerView) {
            containerView.addSubview(radioBtn1)
        }
        radioBtn1.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(lblPayment.snp.bottom).offset(16)
            make.width.height.equalTo(16)
        }
        
        if !cashImgView.isDescendant(of: containerView) {
            containerView.addSubview(cashImgView)
        }
        cashImgView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(radioBtn1.snp.trailing).offset(10)
            make.centerY.equalTo(radioBtn1)
            make.height.width.equalTo(24)
        }
        
        
        if !lblCash.isDescendant(of: containerView) {
            containerView.addSubview(lblCash)
        }
        lblCash.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(cashImgView.snp.trailing).offset(10)
            make.centerY.equalTo(radioBtn1)
        }
        
        
        
        if !radioBtn2.isDescendant(of: containerView) {
            containerView.addSubview(radioBtn2)
        }
        radioBtn2.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(radioBtn1.snp.bottom).offset(16)
            make.width.height.equalTo(16)
        }
        
        if !cardImgView.isDescendant(of: containerView) {
            containerView.addSubview(cardImgView)
        }
        cardImgView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(radioBtn2.snp.trailing).offset(10)
            make.centerY.equalTo(radioBtn2)
            make.height.width.equalTo(24)
        }
        
        if !lblCard.isDescendant(of: containerView) {
            containerView.addSubview(lblCard)
        }
        lblCard.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(cardImgView.snp.trailing).offset(10)
            make.centerY.equalTo(radioBtn2)
        }
        
    }
}
