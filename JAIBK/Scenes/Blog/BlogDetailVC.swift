//
//  BlogDetailVC.swift
//  JAIBK
//
//  Created by Atta khan on 09/03/2022.
//

import UIKit

class BlogDetailVC: UIViewController {
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
        imgView.contentMode = .scaleAspectFit
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
    private var id: String
    
    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getBlogDetail()
    }
    private func getBlogDetail() {
        ServiceManager.shared.sendRequest(request: BlogDetailRequest(id: id), model: BlogModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.lblTitle.text = response.data?[0].name
                        self.lblDesc.attributedText  = response.data?[0].description?.htmlAttributedString()
                        if let img = response.data?[0].image {
                            self.imgView.sd_setImage(with: URL(string: Constant.baseURL + "images/categories/" + img), placeholderImage: UIImage(named: "item"))
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
extension BlogDetailVC {
    fileprivate func setupViews() {
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
            make.top.equalToSuperview().offset(20)
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
        imgView.image = UIImage(named: "vehicle")
        imgView.layer.cornerRadius = 12

        stackView.addArrangedSubview(lblDesc)
        
    }
}
