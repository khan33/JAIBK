//
//  PaymentCellView.swift
//  JAIBK
//
//  Created by Atta khan on 15/03/2022.
//

import UIKit

class PaymentCellView: UICollectionViewCell {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    private (set) lazy var contentImgView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    
    private (set) lazy var imageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "visa")
        return view
    }()
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [lblCardNo, lblDate, btnStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 4
        view.clipsToBounds = true
        return view
    }()
    
    
    private (set) lazy var lblCardNo: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = "****123"
        return lbl
    }()
    
    private (set) lazy var lblDate: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        lbl.text = "Expire: 03/2021"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        return lbl
    }()
    
    private (set) lazy var btnStackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [removeBtn, editBtn])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 4
        view.clipsToBounds = true
        return view
    }()
    
    
    private (set) lazy var removeBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitle("Remove", for: .normal)
        btn.setImage(UIImage(named: "remove"), for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#49B7B1"), for: .normal)
        return btn
        
    }()
    
    private (set) lazy var editBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.setImage(UIImage(named: "remove"), for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#49B7B1"), for: .normal)
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
        
        if !contentImgView.isDescendant(of: containerView) {
            containerView.addSubview(contentImgView)
        }
        contentImgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(containerView).multipliedBy(0.3)
            make.height.equalTo(containerView).multipliedBy(0.7)
        }
        
        
        
        if !imageView.isDescendant(of: contentImgView) {
            contentImgView.addSubview(imageView)
        }
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentImgView.snp.top).offset(8)
            make.leading.equalTo(contentImgView.snp.leading).offset(8)
            make.trailing.equalTo(contentImgView.snp.trailing).offset(-8)
            make.bottom.equalTo(contentImgView.snp.bottom).offset(-8)
        }
        imageView.layer.cornerRadius = 8
        
        
        
        
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentImgView.snp.top).offset(0)
            make.leading.equalTo(contentImgView.snp.trailing).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            make.bottom.equalTo(contentImgView.snp.bottom).offset(0)
        }
        
    }
    
    
    var data: PaymentData? {
        didSet {
            guard let data = data else { return }
            lblCardNo.text = "*******" + (data.card_numbr ?? "")
            lblDate.text = "Expire: \(data.expiry_date ?? "")"
        }
    }
}
