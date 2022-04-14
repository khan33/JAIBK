//
//  MessageViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 06/04/2022.
//

import UIKit

class MessageViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    private (set) lazy var lblProductId: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.font = UIFont(name: AppFontName.bold, size: 19)
        lbl.textColor = .black
        lbl.text = "My Comment"
        return lbl
    }()
    private (set) lazy var view: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        return view
    }()
    
    private (set) lazy var lblMessage: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: AppFontName.bold, size: 19)
        lbl.textColor = .white
        lbl.text = "Here goes the message to the buyer, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin in imperdiet tortor"
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
            make.leading.equalTo(containerView.snp.leading)
        }
        
        if !view.isDescendant(of: containerView) {
            containerView.addSubview(view)
        }
        view.snp.makeConstraints { (make) -> Void in
            make.leading.bottom.trailing.equalTo(containerView)
            make.top.equalTo(lblProductId.snp.bottom).offset(20)
        }
        
        if !lblMessage.isDescendant(of: view) {
            view.addSubview(lblMessage)
        }
        lblMessage.snp.makeConstraints { (make) -> Void in
            make.top.leading.trailing.bottom.equalTo(view).inset(8)
        }
        
        
    }
    
}
