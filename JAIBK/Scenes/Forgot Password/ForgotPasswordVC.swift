//
//  ForgotPasswordVC.swift
//  JAIBK
//
//  Created by Atta khan on 05/04/2022.
//

import UIKit

class ForgotPasswordVC: UIViewController {
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
        label.text = "Forgot Password"
        label.textAlignment = .center
        return label
    }()
    private (set) lazy var confirmLbl: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#9098B1")
        label.font = UIFont(name: AppFontName.book, size: 16)
        label.text = "Confirm Your email"
        label.textAlignment = .center
        return label
    }()
    var emailView: TextInputView!
    private var emailTxt: String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}


extension ForgotPasswordVC {
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
        stackView.addArrangedSubview(confirmLbl)
        
        emailView = TextInputView(placeholder: "Your email", isPasswordEnable: false, icon: "email") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.emailTxt = enteredText
        }
        emailView.setData(text: emailTxt)
        stackView.addArrangedSubview(emailView)
        
        
        
        let btnView = CenterButtonView.init(title: "RESET PASSWORD") { [weak self] (clicked) in
            guard let self = self else {return}
            if self.emailTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your email.")
                return
            }
            ServiceManager.shared.sendRequest(request: ForgotPasswordRequest(email: self.emailTxt), model: UserModel.self) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        if response.success ?? false {
                            print(response.data)
                        } else {
                            self.showAlert(withTitle: "Alert", message: response.message ?? "")
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        stackView.addArrangedSubview(btnView)
        
    }
    
}
class ForgotPasswordRequest : RequestModel {
    private var email: String
   
    init(email: String) {
        self.email = email
    }
    
    override var path: String {
        return Constant.ServiceConstant.FORGOT_PASSWORD
    }
    override var body: [String : Any?] {
        return [
            "email": email
        ]
    }
    
    override var headers: [String : String] {
        return [
            "Content-Type" : "Application/json",
        ]
    }
    
    override var method: RequestHTTPMethod {
        return .post
    }
    
}
