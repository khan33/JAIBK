//
//  EnquireNowCell.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit

class EnquireNowCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var imageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "cellImage")
        return view
    }()
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Still Haven't Found What You're looking For? "
        lbl.font = UIFont(name: AppFontName.medium, size: 14)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    private (set) lazy var lblAllView: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Enquire Now"
        lbl.font = UIFont(name: AppFontName.bold, size: 13)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    private (set) lazy var AllViewBtn: UIButton = {[unowned self] in
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let attributedString = NSMutableAttributedString(string: "Enquire Now")
        let range: NSRange = attributedString.mutableString.range(of: "Enquire Now", options: .caseInsensitive)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
        
        lblAllView.attributedText = attributedString
        
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
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        if !imageView.isDescendant(of: containerView) {
            containerView.addSubview(imageView)
        }
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        imageView.contentMode = .scaleAspectFill
        
        if !lblName.isDescendant(of: containerView){
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY).offset(-8)
            make.leading.equalTo(containerView.snp.leading).offset(4)
        }
        
        
        if !lblAllView.isDescendant(of: containerView){
            containerView.addSubview(lblAllView)
        }
        lblAllView.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(lblName.snp.bottom).offset(8)
        }
        
        if !AllViewBtn.isDescendant(of: containerView) {
            containerView.addSubview(AllViewBtn)
        }
        AllViewBtn.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(lblAllView)
        }
    }
}
