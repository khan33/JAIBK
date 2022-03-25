//
//  SliderCell.swift
//  JAIBK
//
//  Created by Atta khan on 24/03/2022.
//

import UIKit

class SliderCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#EFEFEF")
        view.layer.cornerRadius = 6
        return view
    }()
    private (set) lazy var productImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "image 29")
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
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        if !productImageView.isDescendant(of: containerView){
            containerView.addSubview(productImageView)
        }
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(containerView)
        }
    }
    
}
