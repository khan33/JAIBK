//
//  CheckoutButtonCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class CheckoutButtonCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
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
            make.leading.trailing.top.bottom.equalTo(contentView)
        }
        let btnView = CenterButtonView.init(title: "Checkout") { [weak self] (clicked) in
            guard let self = self else {return}
        }
        containerView.addSubview(btnView)
        btnView.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
}
