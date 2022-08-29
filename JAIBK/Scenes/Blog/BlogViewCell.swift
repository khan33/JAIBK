//
//  BlogViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 09/03/2022.
//

import UIKit

class BlogViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var imageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.cornerRadius = 6
        return view
    }()
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: AppFontName.bold, size: 11)
        lbl.text = "Autoline Daily 2021: Top quality news for Aug. 25"
        return lbl
    }()
    
    private (set) lazy var lblDate: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.medium, size: 11)
        lbl.text = "Posted on 10 Feb 2022"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
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
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        if !imageView.isDescendant(of: contentView) {
            contentView.addSubview(imageView)
        }
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.height.equalTo(120)
        }
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "vehicle")
        
        if !lblName.isDescendant(of: contentView) {
            contentView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        
        if !lblDate.isDescendant(of: contentView) {
            contentView.addSubview(lblDate)
        }
        lblDate.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lblName.snp.bottom).offset(8)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        
    }
    
    
    var data : BlogData? {
        didSet {
            guard let item = data else { return }
            lblName.text = item.name
            lblDate.text = item.created_at
            if let img = item.image {
                imageView.sd_setImage(with: URL(string: Constant.baseURL + "images/categories/" + img), placeholderImage: UIImage(named: "item"))
            }
        }
    }
}
