//
//  EnquireVC.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit

class EnquireVC: UIViewController {
    
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
        let cartImage    = UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal)
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal)

        let cartButton   = UIBarButtonItem(image: cartImage,  style: .plain, target: self, action: #selector(didTapCartButton(sender:)))
        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton, cartButton]

        let menuButton = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(didTapMenuButton(sender:)))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func didTapCartButton(sender: AnyObject){
        
    }
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        
        let vc = LeftMenuController()
        vc.modalPresentationStyle = .fullScreen
        presentAnimate(vc)
        
    }

}
extension EnquireVC {
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
        let productInfoView = EnquireTextFieldView(title: "Product Info", placeholder: "Product Id") { text in
        }
        stackView.addArrangedSubview(productInfoView)
        
        
        let quantity = EnquireTextFieldView(title: "Quantity", placeholder: "") { text in
        }
        stackView.addArrangedSubview(quantity)
        
        
        let firstNameView = EnquireTextFieldView(title: "First Name", placeholder: "") { text in
        }
        stackView.addArrangedSubview(firstNameView)
        
        
        let lastNameView = EnquireTextFieldView(title: "Last Name", placeholder: "") { text in
        }
        stackView.addArrangedSubview(lastNameView)
        
        let emailView = EnquireTextFieldView(title: "Email", placeholder: "") { text in
        }
        stackView.addArrangedSubview(emailView)
        let phoneNoView = EnquireTextFieldView(title: "Phone Number", placeholder: "") { text in
        }
        stackView.addArrangedSubview(phoneNoView)
        
        let enterMessageView = EnquireTextFieldView(title: "Enter your Message", placeholder: "") { text in
        }
        enterMessageView.txtField.snp.updateConstraints { (make) in
            make.height.equalTo(100)
        }
        
        stackView.addArrangedSubview(enterMessageView)
        
        let btnView = CenterButtonView.init(title: "Submit") { [weak self] (clicked) in
            guard let self = self else {return}
        }
        stackView.addArrangedSubview(btnView)
        
    }
}

