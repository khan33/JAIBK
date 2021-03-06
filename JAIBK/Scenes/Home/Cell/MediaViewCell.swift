//
//  MeidaViewCell.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit
import SDWebImage

class MediaViewCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private (set) lazy var itemImageView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "media")
        return view
    }()
    
    private (set) lazy var coverImgView: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "cover")
        return view
    }()
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "We’ll make your car feel brand new"
        lbl.font = UIFont(name: AppFontName.bold, size: 14)
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()
    
    private (set) lazy var lblDate: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "August 15, 2021"
        lbl.font = UIFont(name: AppFontName.book, size: 12)
        lbl.textColor = .white
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
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
        containerView.layer.cornerRadius = 14
        if !itemImageView.isDescendant(of: containerView){
            containerView.addSubview(itemImageView)
        }
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(containerView)
        }
        if !coverImgView.isDescendant(of: containerView){
            containerView.addSubview(coverImgView)
        }
        coverImgView.contentMode = .scaleAspectFill
        coverImgView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(containerView)
        }

//
        if !lblName.isDescendant(of: containerView){
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.bottom.equalTo(coverImgView.snp.bottom).offset(-24)
            make.leading.equalTo(coverImgView.snp.leading).offset(16)
            make.centerX.equalTo(coverImgView.snp.centerX)
        }

        if !lblDate.isDescendant(of: containerView){
            containerView.addSubview(lblDate)
        }
        lblDate.snp.makeConstraints { make in
            make.bottom.equalTo(lblName.snp.top).offset(-10)
            make.leading.equalTo(coverImgView.snp.leading).offset(16)
        }
    }
    
    var mediaItem: Media? {
        didSet {
            guard let data = mediaItem else { return }
            lblName.text = mediaItem?.name
            lblDate.text = mediaItem?.created_at
            if let img = mediaItem?.image {
                itemImageView.sd_setImage(with: URL(string: Constant.baseURL + "images/media/" + img), placeholderImage: UIImage(named: "media"))
            }
        }
    }
}
