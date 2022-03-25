//
//  MenuCell.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit

class MenuCell: UITableViewCell {
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Login"
        lbl.font = UIFont(name: AppFontName.medium, size: 17)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.textAlignment = .center
        return lbl
    }()
    
    private (set) lazy var imgview: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "forward")
        return view
    }()
    
    private (set) lazy var lblValue: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "English"
        lbl.font = UIFont(name: AppFontName.bold, size: 19)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        lbl.textAlignment = .center
        return lbl
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
        lblValue.isHidden = true
        if !lblName.isDescendant(of: contentView) {
            contentView.addSubview(lblName)
        }
        lblName.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        
        if !imgview.isDescendant(of: contentView) {
            contentView.addSubview(imgview)
        }
        imgview.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
        if !lblValue.isDescendant(of: contentView) {
            contentView.addSubview(lblValue)
        }
        lblValue.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
        
    }

}
