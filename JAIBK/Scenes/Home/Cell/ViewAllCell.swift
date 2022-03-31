//
//  ViewAllCell.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit

class ViewAllCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "Most Popular"
        lbl.font = UIFont(name: AppFontName.bold, size: 19)

        return lbl
    }()
    private (set) lazy var lblAllView: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "VIEW ALL"
        lbl.font = UIFont(name: AppFontName.medium, size: 11)

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
        let attributedString = NSMutableAttributedString(string: "VIEW ALL")
        let range: NSRange = attributedString.mutableString.range(of: "VIEW ALL", options: .caseInsensitive)
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
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        if !lblName.isDescendant(of: containerView){
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.leading.equalTo(containerView.snp.leading).offset(0)
        }
        
        
        if !lblAllView.isDescendant(of: containerView){
            containerView.addSubview(lblAllView)
        }
        lblAllView.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(0)
        }
        
        
        if !AllViewBtn.isDescendant(of: containerView) {
            containerView.addSubview(AllViewBtn)
        }
        AllViewBtn.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(lblAllView)
        }
    }
}
