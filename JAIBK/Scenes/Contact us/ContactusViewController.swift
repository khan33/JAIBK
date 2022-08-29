//
//  ContactusViewController.swift
//  JAIBK
//
//  Created by Atta khan on 12/08/2022.
//

import UIKit

class ContactusViewController: UIViewController {
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
    private var nameTxt: String = ""
    private var emailTxt: String = ""
    private var messageTxt: String = ""
    
    var nameView: EnquireTextFieldView!
    var emailView: EnquireTextFieldView!
    var enterMessageView: MessageTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupViews()
    }
}
extension ContactusViewController {
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
        
        
        nameView = EnquireTextFieldView(title: "Name", placeholder: "Enter Name"){ [weak self] (enteredText) in
            guard let self = self else {return}
            self.nameTxt = enteredText
        }
        nameView.setData(text: nameTxt)
        stackView.addArrangedSubview(nameView)
        
        emailView = EnquireTextFieldView(title: "Email", placeholder: "Enter Email"){ [weak self] (enteredText) in
            guard let self = self else {return}
            self.emailTxt = enteredText
        }
        emailView.setData(text: emailTxt)
        stackView.addArrangedSubview(emailView)
        
        enterMessageView = MessageTextField(title: "Enter your Message", placeholder: "") { text in
            self.messageTxt = text
        }
        enterMessageView.setData(text: messageTxt)
        stackView.addArrangedSubview(enterMessageView)
        let btnView = CenterButtonView.init(title: "Submit") { [weak self] (clicked) in
            guard let self = self else {return}
            if self.nameTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter Name")
                return
            }
            if self.emailTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter Email")
                return
            }
            
            if self.messageTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter message")
                return
            }
            
            // Api call here.....
            
        }
        stackView.addArrangedSubview(btnView)
    }
    
    
    func configNav() {
        self.title = "Contact us"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
