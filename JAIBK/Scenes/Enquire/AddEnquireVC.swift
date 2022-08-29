//
//  EnquireVC.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit

class AddEnquireVC: UIViewController {
    
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
    var productInfoView: EnquireTextFieldView!
    var quantity: EnquireTextFieldView!
    var firstNameView: EnquireTextFieldView!
    var lastNameView: EnquireTextFieldView!
    var emailView: EnquireTextFieldView!
    var phoneNoView: EnquireTextFieldView!
    var enterMessageView: MessageTextField!
    
    
    private var productIdTxt: String = ""
    private var productNameTxt: String = ""
    private var firstNameTxt: String = ""
    private var lastNameTxt: String = ""
    private var emailTxt: String = ""
    private var phoneNoTxt: String = ""
    private var messageTxt: String = ""
    private var quantityTxt: String = ""
    var product: Products?
    
    init(product: Products?) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupViews()
    }
    
    func configNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Enquire"
        
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal)

        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton]

        let menuButton = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(didTapMenuButton(sender:)))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        
        let vc = LeftMenuController()
        vc.modalPresentationStyle = .fullScreen
        presentAnimate(vc)
        
    }

}
extension AddEnquireVC {
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        
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
        productNameTxt = product?.title ?? ""
        productInfoView = EnquireTextFieldView(title: "Product Info", placeholder: "Product Id") { text in
            self.productNameTxt = text
        }
        productInfoView.txtField.isUserInteractionEnabled = false
        productInfoView.setData(text: productNameTxt)
        stackView.addArrangedSubview(productInfoView)
        
        
        quantity = EnquireTextFieldView(title: "Quantity", placeholder: "") { text in
            self.quantityTxt = text
        }
        quantity.txtField.keyboardType = .asciiCapableNumberPad
        quantity.setData(text: quantityTxt)
        stackView.addArrangedSubview(quantity)
        
        
        firstNameView = EnquireTextFieldView(title: "First Name", placeholder: "") { text in
            self.firstNameTxt = text
        }
        firstNameView.setData(text: firstNameTxt)
        stackView.addArrangedSubview(firstNameView)
        
        
        lastNameView = EnquireTextFieldView(title: "Last Name", placeholder: "") { text in
            self.lastNameTxt = text
        }
        lastNameView.setData(text: lastNameTxt)
        stackView.addArrangedSubview(lastNameView)
        
        emailView = EnquireTextFieldView(title: "Email", placeholder: "") { text in
            self.emailTxt = text
        }
        emailView.txtField.keyboardType = .emailAddress

        emailView.setData(text: emailTxt)
        stackView.addArrangedSubview(emailView)
        phoneNoView = EnquireTextFieldView(title: "Phone Number", placeholder: "") { text in
            self.phoneNoTxt = text
        }
        phoneNoView.txtField.keyboardType = .asciiCapableNumberPad
        phoneNoView.setData(text: phoneNoTxt)
        stackView.addArrangedSubview(phoneNoView)
        
        enterMessageView = MessageTextField(title: "Enter your Message", placeholder: "") { text in
            self.messageTxt = text
        }
        enterMessageView.setData(text: messageTxt)
        
        
        stackView.addArrangedSubview(enterMessageView)
        
        let btnView = CenterButtonView.init(title: "Submit") { [weak self] (clicked) in
            guard let self = self else {return}
            if self.quantityTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter Quantity")
                return
            }
            if self.firstNameTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your first name")
                return
            }
            
            if self.lastNameTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your last name")
                return
            }
            
            
            if self.emailTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your email")
                return
            }
            
            
            if self.phoneNoTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your phone number")
                return
            }
            
            
            if self.messageTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your message")
                return
            }
            print(self.messageTxt)
            let addRequest = EnquireRequestModel.AddEnquireRequest(id: self.product?.product_id ?? "", name: self.productNameTxt, quantity: self.quantityTxt, first_name: self.firstNameTxt, last_name: self.lastNameTxt, email: self.emailTxt, phone: self.emailTxt, message: self.messageTxt)
            ServiceManager.shared.sendRequest(request: addRequest, model: EnquireModel.self) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        if response.success ?? false {
                            self.showAlertOkAction(withTitle: "Alert", message: response.message ?? "Enquiry added successfully.") {
                                self.navigationController?.popViewController(animated: true)
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
        
    }
}

