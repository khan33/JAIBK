//
//  SearchButtonCell.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit

class SearchButtonCell: UICollectionViewCell {
    private (set) lazy var searchByCarBtn: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setTitle("Search by Car", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.layer.cornerRadius = 8
        return btn
    }()
    private (set) lazy var searchByVIN: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setTitle("Search by VIN", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#6082E0")
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [searchByCarBtn, searchByVIN])
        view.distribution = .fillEqually
//        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 8
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
        if !stackView.isDescendant(of: contentView) {
            contentView.addSubview(stackView)
        }
        stackView.snp.makeConstraints{ (make) -> Void in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-20)
            
        }
        
    }
    
}
