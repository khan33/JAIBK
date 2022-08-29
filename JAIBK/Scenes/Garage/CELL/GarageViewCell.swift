//
//  GarageViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class GarageViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var imgCoverView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#D6D6D6")
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    private (set) lazy var productImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "item")
        return view
    }()
    
    private (set) lazy var lblProductName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        lbl.text = "Car Name"
        lbl.font = UIFont(name: AppFontName.bold, size: 14)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var lblModelName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Model Name"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        return lbl
    }()
    private (set) lazy var lblPetrol: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = ""
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
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
        btn.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#49B7B1"), for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 14)
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
    
    var garage: GarageData? {
        didSet {
            guard let data = garage else { return }
            lblProductName.text = data.title
            lblModelName.text = data.model_name
            if let img = data.image {
                productImageView.sd_setImage(with: URL(string: Constant.baseURL + "images/garage/" + img), placeholderImage: UIImage(named: "item"))
            }
        }
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
        
        if !imgCoverView.isDescendant(of: containerView) {
            containerView.addSubview(imgCoverView)
        }
        imgCoverView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.height.equalTo(containerView).multipliedBy(0.8)
            make.width.equalTo(88)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        if !productImageView.isDescendant(of: imgCoverView) {
            imgCoverView.addSubview(productImageView)
        }
        productImageView.snp.makeConstraints { make in
            make.centerY.equalTo(imgCoverView.snp.centerY)
            make.centerX.equalTo(imgCoverView.snp.centerX)
            make.width.equalTo(70)
        }
        
        if !lblProductName.isDescendant(of: containerView) {
            containerView.addSubview(lblProductName)
        }
        lblProductName.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(imgCoverView.snp.trailing).offset(16)
            make.top.equalTo(imgCoverView.snp.top).offset(8)
        }
        
        
        if !lblModelName.isDescendant(of: containerView) {
            containerView.addSubview(lblModelName)
        }
        lblModelName.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(lblProductName.snp.leading)
            make.top.equalTo(lblProductName.snp.bottom).offset(8)
        }
        if !lblPetrol.isDescendant(of: containerView) {
            containerView.addSubview(lblPetrol)
        }
        lblPetrol.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.centerY.equalTo(lblModelName.snp.centerY)
        }
        
        
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(lblProductName.snp.leading)
            make.top.equalTo(lblModelName.snp.bottom).offset(8)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
}
