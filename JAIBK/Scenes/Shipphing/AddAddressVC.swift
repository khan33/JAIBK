//
//  AddAddressVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class AddAddressVC: UIViewController {
    
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
    
    private var firstNamtTxt: String = ""
    private var lastNamtTxt: String = ""
    private var streetAddressTxt: String = ""
    private var countryTxt: String = ""
    private var countryCodeTxt: String = ""
    private var cityTxt: String = ""
    private var phoneNoTxt: String = ""
    
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
        navigationItem.title = "Add Address"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
    
    private func getCountries() {
        ServiceManager.shared.sendRequest(request: AddressRequestModel.CountryRequest(), model: CountryModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getCities(code: String) {
        ServiceManager.shared.sendRequest(request: AddressRequestModel.CityRequest(country_code: code), model: CityModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

}
extension AddAddressVC {
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
        
        let productInfoView = EnquireTextFieldView(title: "First Name", placeholder: "") { text in
        }
        stackView.addArrangedSubview(productInfoView)
        
        
        let quantity = EnquireTextFieldView(title: "Last Name", placeholder: "") { text in
        }
        stackView.addArrangedSubview(quantity)
        
        
        let firstNameView = EnquireTextFieldView(title: "Street Address", placeholder: "") { text in
        }
        stackView.addArrangedSubview(firstNameView)
        
        
        let lastNameView = EnquireTextFieldView(title: "Country", placeholder: "") { text in
        }
        stackView.addArrangedSubview(lastNameView)
        
        let emailView = EnquireTextFieldView(title: "City", placeholder: "") { text in
        }
        stackView.addArrangedSubview(emailView)
        let phoneNoView = EnquireTextFieldView(title: "Phone Number", placeholder: "") { text in
        }
        stackView.addArrangedSubview(phoneNoView)
        
        
        let btnView = CenterButtonView.init(title: "Add Address") { [weak self] (clicked) in
            guard let self = self else {return}
            if self.firstNamtTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.lastNamtTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter last name")
                return
            }
            if self.streetAddressTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter street address")
                return
            }
            
            if self.countryTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Select country")
                return
            }
            
            if self.cityTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Select city")
                return
            }
            if self.phoneNoTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter phone number")
                return
            }
            
            let request = AddressRequestModel.AddAddressRequest(first_name: self.firstNamtTxt, last_name: self.lastNamtTxt, street_address: self.streetAddressTxt, country: self.countryCodeTxt, city: self.cityTxt, phone_no: self.phoneNoTxt)
            ServiceManager.shared.sendRequest(request: request, model: CityModel.self) { result in
                switch result {
                case .success(let response):
                    if response.success ?? false {
                        DispatchQueue.main.async {
                            
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
