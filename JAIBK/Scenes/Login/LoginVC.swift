//
//  LoginVC.swift
//  JAIBK
//
//  Created by Atta khan on 18/02/2022.
//

import UIKit
import SVProgressHUD

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
        label.font = UIFont(name: AppFontName.book, size: 16)
        label.text = "Let’s Get Started"
        label.textAlignment = .center
        return label
    }()
    private (set) lazy var accountLbl: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#9098B1")
        label.font = UIFont(name: AppFontName.book, size: 16)
        label.text = "Already have an account? Sign up here"
        label.textAlignment = .center
        return label
    }()
    
    private (set) lazy var forgotPasswrdBtn: UIButton = { [unowned self] in
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Forgot Password", for: .normal)
        btn.setTitleColor(UIColor.hexStringToUIColor(hex: "#9098B1"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(didTapOnForgotPasswrodBtn), for: .touchUpInside)
        btn.contentHorizontalAlignment = .right
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 16)
        return btn
    }()
    
    
    
    var passwordView: TextInputView!
    var emailView: TextInputView!
   
    private var emailTxt: String = ""
    private var passwordTxt: String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = accountLbl.text!
        let attributedString = NSMutableAttributedString(string: str)
        let range: NSRange = attributedString.mutableString.range(of: "Sign up here", options: .caseInsensitive)
        attributedString.addAttribute(.font, value: UIFont(name: AppFontName.bold, size: 16), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.hexStringToUIColor(hex: "#000000"), range: range)
        accountLbl.attributedText = attributedString
        accountLbl.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        tapgesture.numberOfTouchesRequired = 1
        accountLbl.addGestureRecognizer(tapgesture)
        setupViews()
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let _ = self.accountLbl.text else { return }
        let vc = SignupVC()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func didTapOnForgotPasswrodBtn(_ sender: UIButton) {
        let vc = ForgotPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginVC {
    fileprivate func setupViews() {
        
        emailTxt = "awan@gmail.com"
        passwordTxt = "admin123"
        
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
        
        emailView = TextInputView(placeholder: "Your email", isPasswordEnable: false, icon: "email") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.emailTxt = enteredText
        }
        emailView.setData(text: emailTxt)
        stackView.addArrangedSubview(emailView)
        
        
        passwordView = TextInputView(placeholder: "Password", isPasswordEnable: true, icon: "password") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.passwordTxt = enteredText
        }
        passwordView.setData(text: passwordTxt)
        stackView.addArrangedSubview(passwordView)
        
        stackView.addArrangedSubview(forgotPasswrdBtn)
        
        
        let btnView = CenterButtonView.init(title: "Login") { [weak self] (clicked) in
            
            
            
            guard let self = self else {return}
            if self.emailTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your email.")
                return
            }
            
            if self.passwordTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your password.")
                return
            }
            SVProgressHUD.show()
            ServiceManager.shared.sendRequest(request: LoginRequest(email: self.emailTxt, password: self.passwordTxt, fcm_token: "fjkklasfjlsaf"), model: UserModel.self) { result in
                SVProgressHUD.dismiss()
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        if response.success ?? false {
                            if let data = response.data {
                                
                                UserDefaults.standard.set(data.user?.userName, forKey: "userName")
                                UserDefaults.standard.set(data.token ?? "", forKey: "token")
                                
                                let viewController = TabBar()
                                UIApplication.shared.windows.first?.rootViewController = viewController
                                UIApplication.shared.windows.first?.makeKeyAndVisible()
                            }
                            
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
        
        stackView.addArrangedSubview(accountLbl)
    }
    
}
class LoginRequest : RequestModel {
    private var email: String
    private var password: String
    private var fcm_token: String
   
    init(email: String, password: String, fcm_token: String) {
        self.email = email
        self.password = password
        self.fcm_token = fcm_token
    }
    
    override var path: String {
        return Constant.ServiceConstant.LOGIN
    }
    override var body: [String : Any?] {
        return [
            "email": email,
            "password": password,
            "fcm_token" : fcm_token
        ]
    }
    
    
    
    override var method: RequestHTTPMethod {
        return .post
    }
    
}


class LogoutRequest : RequestModel {
    
    
    override var path: String {
        return Constant.ServiceConstant.LOGOUT
    }
    
    override var method: RequestHTTPMethod {
        return .post
    }
    
}
