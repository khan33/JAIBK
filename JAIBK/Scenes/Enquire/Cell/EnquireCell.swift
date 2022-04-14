//
//  EnquireCell.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import UIKit

class EnquireCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        return view
    }()
    private (set) lazy var lblProductId: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = UIFont(name: AppFontName.bold, size: 19)
        lbl.textColor = .white
        lbl.text = "2139824"
        return lbl
    }()
    
    private (set) lazy var lblDesc: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: AppFontName.book, size: 14)
        lbl.textColor = .white
        lbl.text = "I need this product ..."
        return lbl
    }()
    
    private (set) lazy var lblDate: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 13)
        lbl.textColor = .white
        lbl.text = "24 July 2021"
        return lbl
    }()
    private (set) lazy var lblStatus: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 13)
        lbl.textColor = .white
        lbl.text = "Status"
        return lbl
    }()
    
    private (set) lazy var dottedView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var lblStatusValue: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.book, size: 13)
        lbl.textColor = .white
        lbl.text = "Open"

        return lbl
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
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        if !lblProductId.isDescendant(of: containerView) {
            containerView.addSubview(lblProductId)
        }
        lblProductId.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        if !lblDate.isDescendant(of: containerView) {
            containerView.addSubview(lblDate)
        }
        lblDate.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).inset(20)
        }
        
        if !lblDesc.isDescendant(of: containerView) {
            containerView.addSubview(lblDesc)
        }
        lblDesc.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lblProductId.snp.bottom).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
        }
        
        if !dottedView.isDescendant(of: containerView) {
            containerView.addSubview(dottedView)
        }
        dottedView.snp.remakeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(lblDesc.snp.bottom).offset(16)
            make.height.equalTo(10)
        }
        dottedView.layoutIfNeeded()
        dottedView.makeDashedBorderLine(color: UIColor.white, strokeLength: 7, gapLength: 5, width: 2, orientation: .horizontal)
        
        if !lblStatus.isDescendant(of: containerView) {
            containerView.addSubview(lblStatus)
        }
        lblStatus.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dottedView.snp.bottom).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        if !lblStatusValue.isDescendant(of: containerView) {
            containerView.addSubview(lblStatusValue)
        }
        lblStatusValue.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dottedView.snp.bottom).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
        }
    }
    
    
    var enquire: EnquireData? {
        didSet {
            guard let data = enquire else { return }
            lblProductId.text = data.product_id
            lblDesc.text = data.message
            lblDate.text = data.added_on
            lblStatusValue.text = data.status
        }
    }
}
