//
//  BannerViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#F2F2F7")
        view.layer.cornerRadius = 8
        return view
    }()
    private (set) lazy var itemImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "image 25")?.withBackground(color: UIColor.hexStringToUIColor(hex: "#F2F2F7"))
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
        
        if !itemImageView.isDescendant(of: containerView){
            containerView.addSubview(itemImageView)
        }
        itemImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(containerView)
        }
        
    }
}
