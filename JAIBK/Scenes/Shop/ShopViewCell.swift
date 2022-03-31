//
//  ShopViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit
import SDWebImage

class ShopViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private (set) lazy var productImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Car Parts"
        lbl.font = UIFont(name: AppFontName.bold, size: 21)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
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
        //containerView.setGradientBorder(width: 10.0, colors: [.green, .red])
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(contentView).inset(8)
        }
        if !lblName.isDescendant(of: containerView){
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.leading.equalTo(containerView).offset(20)
        }
        
        if !productImageView.isDescendant(of: containerView){
            containerView.addSubview(productImageView)
        }
        productImageView.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.trailing.equalTo(containerView).offset(-20)
            make.width.height.equalTo(66)
        }
        containerView.layoutIfNeeded()
        containerView.setGradientBorder(width: 2.0, colors: [UIColor.hexStringToUIColor(hex: "#6082E0"), UIColor.hexStringToUIColor(hex: "#49B7B1")])
    }
    
    var category: CategoryData? {
        didSet {
            guard let data = category else { return }
            lblName.text = data.title
            
            if let img = data.image {
                productImageView.sd_setImage(with: URL(string: Constant.baseURL + "images/categories/" + img ), placeholderImage: UIImage(named: "item"), options: .retryFailed)
            }
        }
    }
    
}
