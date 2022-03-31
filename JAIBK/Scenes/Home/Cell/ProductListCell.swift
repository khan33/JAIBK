//
//  ProductListCell.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
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
        
        if !productImageView.isDescendant(of: containerView){
            containerView.addSubview(productImageView)
        }
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(containerView)
            make.height.equalTo(66)
        }
        if !lblName.isDescendant(of: containerView){
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(8)
            //make.leading.equalTo(containerView.snp.leading).offset(8)
            make.centerX.equalTo(containerView.snp.centerX)
        }
    }
}
