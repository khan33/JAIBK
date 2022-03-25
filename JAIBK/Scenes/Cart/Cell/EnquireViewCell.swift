//
//  EnquireViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class EnquireViewCell: UICollectionViewCell {
    
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .hexStringToUIColor(hex: "#49B7B1")
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    private (set) lazy var lblValue: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        lbl.text = "Need to know more ?"
        lbl.font = UIFont(name: AppFontName.book, size: 13)
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    private (set) lazy var enquireNowBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.clipsToBounds = true
        return btn
    }()
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: AppFontName.bold, size: 14),
              .foregroundColor: UIColor.white,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attributeString = NSMutableAttributedString(
                string: "Enquire Now",
                attributes: attributes
             )
        enquireNowBtn.setAttributedTitle(attributeString, for: .normal)
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
        
        if !lblValue.isDescendant(of: containerView) {
            containerView.addSubview(lblValue)
        }
        lblValue.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        if !enquireNowBtn.isDescendant(of: containerView) {
            containerView.addSubview(enquireNowBtn)
        }
        enquireNowBtn.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(containerView.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
        }
    }
    
}
