//
//  LoginVC.swift
//  JAIBK
//
//  Created by Atta khan on 18/02/2022.
//

import UIKit

class LoginVC: UIViewController {
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
    
    private (set) lazy var logoImgView: UIImageView = { [unowned self] in
        var imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "logo")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private (set) lazy var lblTitle: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.init(red: 34 / 255 , green: 50/255, blue: 99/255, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        label.text = "Let’s Get Started"
        label.textAlignment = .center
        return label
    }()
    
    
   
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
}

extension LoginVC {
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
        stackView.addArrangedSubview(logoImgView)
        logoImgView.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(110)
        }
        stackView.addArrangedSubview(lblTitle)
        
        let emailView = TextInputView(placeholder: "Your email", isPasswordEnable: false, icon: "email") { [weak self] (enteredText) in
            guard let self = self else {return}
        }
        stackView.addArrangedSubview(emailView)
        
        
        let passwordView = TextInputView(placeholder: "Password", isPasswordEnable: true, icon: "password") { [weak self] (enteredText) in
            guard let self = self else {return}
        }
        stackView.addArrangedSubview(passwordView)
        let btnView = CenterButtonView.init(title: "Login") { [weak self] (clicked) in
            guard let self = self else {return}
        }
        stackView.addArrangedSubview(btnView)
        
        
        
    }
}
