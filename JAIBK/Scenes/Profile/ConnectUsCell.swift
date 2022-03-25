//
//  ConnectUsCell.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit

class ConnectUsCell: UITableViewCell {
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Connect with us"
        lbl.font = UIFont(name: AppFontName.book, size: 14)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.textAlignment = .center
        return lbl
    }()
    
    private (set) lazy var fbBtn: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "fb"), for: .normal)
        return btn
    }()
    private (set) lazy var instaBtn: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "instagram"), for: .normal)
        return btn
    }()
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [fbBtn, instaBtn])
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 8
        view.clipsToBounds = true
        return view
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews() {
        if !lblName.isDescendant(of: contentView) {
            contentView.addSubview(lblName)
        }
        lblName.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(30)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        if !stackView.isDescendant(of: contentView) {
            contentView.addSubview(stackView)
        }
        stackView.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(lblName.snp.bottom).offset(8)
            make.width.equalTo(66)
//            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
    }

}
