//
//  OrderStatusViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 15/08/2022.
//

import UIKit

class OrderStatusViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 0
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
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
        
        
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.top.bottom.equalTo(contentView)
//            make.centerX.equalToSuperview()
        }
        
        let packingView: StatusView = StatusView(title: "Packing", btnTitle: nil)
        stackView.addArrangedSubview(packingView)
        let shippingView: StatusView = StatusView(title: "Shipping", btnTitle: nil)
        stackView.addArrangedSubview(shippingView)
        let arrivingView: StatusView = StatusView(title: "Arriving",  btnTitle: nil)
        stackView.addArrangedSubview(arrivingView)
        let successView: StatusView = StatusView(title: "Success", btnTitle: "4")
        stackView.addArrangedSubview(successView)
        
    }
}


class StatusView: UIView {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) lazy var btn: UIButton = {[unowned self] in
        let view = UIButton()
        view.clipsToBounds = true
        view.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return view
    }()
    
    private (set) lazy var lineView: UIView = {[unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var statusLbl: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = ""
        lbl.font = UIFont(name: AppFontName.bold, size: 11)
        return lbl
    }()
    var isLineRequired: Bool = false
    
    init(title: String, btnTitle: String?) {
        super.init(frame: CGRect.zero)
        if let btnTitle = btnTitle {
            btn.setTitle(btnTitle, for: UIControl.State.init())
            lineView.backgroundColor = UIColor.hexStringToUIColor(hex: "#000000")
            btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#000000")
            btn.setTitleColor(.white, for: .normal)
            statusLbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        } else {
            btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
            btn.setImage(UIImage(systemName: "checkmark"), for: .normal)
            btn.tintColor = .white
            lineView.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
            statusLbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        }
        statusLbl.text = title
        lineView.isHidden = false
        if title == "Success" {
            lineView.isHidden = true
            
        }
        setUpContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpContainerView() {
        if !containerView.isDescendant(of: self) {
            self.addSubview(containerView)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if !btn.isDescendant(of: containerView) {
            containerView.addSubview(btn)
        }
        btn.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.height.width.equalTo(32)
        }
        
        btn.layer.cornerRadius = 16
        
        if !lineView.isDescendant(of: containerView) {
            containerView.addSubview(lineView)
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalTo(btn.snp.centerY)
            make.leading.equalTo(btn.snp.trailing)
            make.height.equalTo(1)
            make.trailing.equalToSuperview()
        }
       
        if !statusLbl.isDescendant(of: containerView) {
            containerView.addSubview(statusLbl)
        }
        statusLbl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(btn.snp.bottom).offset(8)
        }
        
    }
    
}
