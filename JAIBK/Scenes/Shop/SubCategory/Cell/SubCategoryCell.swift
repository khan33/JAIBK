//
//  SubCategoryCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class SubCategoryCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private (set) lazy var ImgContentView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var productImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "item")
        return view
    }()
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Car Parts"
        lbl.font = UIFont(name: AppFontName.medium, size: 12)

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
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        if !ImgContentView.isDescendant(of: containerView){
            containerView.addSubview(ImgContentView)
        }
        ImgContentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(containerView).multipliedBy(0.7)
            make.top.equalTo(containerView).offset(16)
        }
        
        
        if !productImageView.isDescendant(of: ImgContentView){
            ImgContentView.addSubview(productImageView)
        }
        productImageView.snp.makeConstraints { make in
            make.centerY.equalTo(ImgContentView.snp.centerY)
            make.centerX.equalTo(ImgContentView.snp.centerX)
            make.height.width.equalTo(66)
        }
        if !lblName.isDescendant(of: containerView){
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.top.equalTo(ImgContentView.snp.bottom).offset(8)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        ImgContentView.layoutIfNeeded()
        ImgContentView.setGradientBorder(width: 2.0, colors: [UIColor.hexStringToUIColor(hex: "#6082E0"), UIColor.hexStringToUIColor(hex: "#49B7B1")])
    }
}
