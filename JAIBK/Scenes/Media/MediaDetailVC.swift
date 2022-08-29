//
//  MediaDetailVC.swift
//  JAIBK
//
//  Created by Atta khan on 17/08/2022.
//

import UIKit

class MediaDetailVC: UIViewController {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var scrollView: UIScrollView = { [unowned self] in
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = true
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var contentView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 16
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var imgView: UIImageView = { [unowned self] in
        var imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 6
        return imgView
    }()
    
    private (set) lazy var lblTitle: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#000000")
        label.font = UIFont(name: AppFontName.bold, size: 20)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    private (set) lazy var lblDesc: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#000000")
        label.font = UIFont(name: AppFontName.book, size: 16)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    private var media: Media
    init(media: Media) {
        self.media = media
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}
extension MediaDetailVC {
    fileprivate func setupViews() {
        self.title = "Media Detail"
        if !containerView.isDescendant(of: self.view) {
            self.view.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        if !scrollView.isDescendant(of: containerView) {
            containerView.addSubview(scrollView)
        }
        scrollView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        if !contentView.isDescendant(of: scrollView) {
            scrollView.addSubview(contentView)
        }
        contentView.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        if !stackView.isDescendant(of: contentView) {
            contentView.addSubview(stackView)
        }
        stackView.snp.makeConstraints{ make -> Void in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(16)
            make.trailing.equalTo(stackView.snp.trailing).offset(-16)
            //make.top.equalTo(stackView.snp)
            make.height.equalTo(310)
        }
        stackView.addArrangedSubview(lblTitle)
        //imgView.image = UIImage(named: "vehicle")
        imgView.layer.cornerRadius = 12

        stackView.addArrangedSubview(lblDesc)
        
        
        lblTitle.text = media.name
        lblDesc.text = media.description
        if let img = media.image {
            imgView.sd_setImage(with: URL(string: Constant.baseURL + "images/media/" + img), placeholderImage: UIImage(named: "media"))
        }
    }
}
