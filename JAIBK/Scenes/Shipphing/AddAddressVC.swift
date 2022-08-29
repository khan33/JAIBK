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
    var cities: [CityData]?
    var data: AddressData?
    private var id: String = ""
    var cityView: PickerFieldView!
    var cityDataSource: GenericPickerDataSource<CityData>?
    var selectedCityItem = 0
    
    init(data: AddressData? = nil) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
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
    
    private func getCities() {
        ServiceManager.shared.sendRequest(request: AddressRequestModel.CityRequest(country_code: "AE"), model: CityModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.cities = response.data
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
        
        if let data = data {
            self.firstNamtTxt = data.first_name ?? ""
            self.lastNamtTxt = data.last_name ?? ""
            self.streetAddressTxt = data.address ?? ""
            self.countryTxt = data.country_name ?? ""
            self.cityTxt = data.city_name ?? ""
            self.phoneNoTxt = data.phone_no ?? ""
            self.id = data.id ?? ""
        }
        
        
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
        
        let firstNameView = EnquireTextFieldView(title: "First Name", placeholder: "") { text in
            self.firstNamtTxt = text
        }
        firstNameView.setData(text: self.firstNamtTxt)
        stackView.addArrangedSubview(firstNameView)
        
        
        let lastNameView = EnquireTextFieldView(title: "Last Name", placeholder: "") { text in
            self.lastNamtTxt = text
        }
        lastNameView.setData(text: self.lastNamtTxt)
        stackView.addArrangedSubview(lastNameView)
        
        
        let streetAddressView = EnquireTextFieldView(title: "Street Address", placeholder: "") { text in
            self.streetAddressTxt = text
        }
        streetAddressView.setData(text: self.streetAddressTxt)
        stackView.addArrangedSubview(streetAddressView)
        
        
        cityView = PickerFieldView(title: "City", placeholder: "Select City", icon: "down") {
            self.cityDataSource = GenericPickerDataSource<CityData>(
                withItems: self.cities ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedCityItem,  didSelect: { (data) in
                            self.cityView?.txtField.text = data.name
                            self.cityTxt = data.name ?? ""
                            
                            self.selectedCityItem = self.cities?.firstIndex(where: {$0.name == self.cityTxt}) ?? 0
                        })
            self.cityView?.txtField.setupPickerField(withDataSource: self.cityDataSource!)
        }
        cityView.setData(text: cityTxt)
        stackView.addArrangedSubview(cityView)
        
        
        let phoneNoView = EnquireTextFieldView(title: "Phone Number", placeholder: "") { text in
            self.phoneNoTxt = text
        }
        phoneNoView.txtField.keyboardType = .phonePad
        phoneNoView.setData(text: self.phoneNoTxt)
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
            
            if self.cityTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Select city")
                return
            }
            if self.phoneNoTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter phone number")
                return
            }
            
            var request: RequestModel?
            
            if self.id != "" {
                request = AddressRequestModel.UpdateAddressRequest(first_name: self.firstNamtTxt, last_name: self.lastNamtTxt, street_address: self.streetAddressTxt, country: "AE", city: self.cityTxt, phone_no: self.phoneNoTxt, id: self.id)
            } else {
                request = AddressRequestModel.AddAddressRequest(first_name: self.firstNamtTxt, last_name: self.lastNamtTxt, street_address: self.streetAddressTxt, country: "AE", city: self.cityTxt, phone_no: self.phoneNoTxt)
            }
            
            
            
            ServiceManager.shared.sendRequest(request: request!, model: AddressModel.self) { result in
                switch result {
                case .success(let response):
                    if response.success ?? false {
                        DispatchQueue.main.async {
                            self.showAlertOkAction(withTitle: "Alert", message: response.message ?? "Added successfully.") {
                                self.navigationController?.popViewController(animated: true)
                            }
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
