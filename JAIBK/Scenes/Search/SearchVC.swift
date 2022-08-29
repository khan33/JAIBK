//
//  SearchVC.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit
import SVProgressHUD

class SearchVC: UIViewController {
    
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
    
    lazy var txtField: UITextField = {[unowned self] in
        let view = UITextField()
        view.autocapitalizationType = .none
        view.textAlignment = .left
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#DBDBDB").cgColor
        view.layer.masksToBounds = true
        view.placeholder = "Searchs"
        return view
    }()
    
    private (set) lazy var searchByCarBtn: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setTitle("Search by Car", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.addTarget(self, action: #selector(didTapOnCarSearchBtn), for: .touchUpInside)
        btn.layer.cornerRadius = 8
        return btn
    }()
    private (set) lazy var searchByVIN: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.setTitle("Search by VIN", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.hexStringToUIColor(hex: "#6082E0")
        btn.titleLabel?.font = UIFont(name: AppFontName.bold, size: 12)
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(didTapOnVINSearchBtn), for: .touchUpInside)
        return btn
    }()
    
    private (set) lazy var stackSerachView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [searchByCarBtn, searchByVIN])
        view.distribution = .fillEqually
//        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 8
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var stackPartView: UIStackView = { [unowned self] in
        let view = UIStackView(arrangedSubviews: [lblBy, partsView, servicView])
        view.distribution = .fillEqually
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 6
        view.clipsToBounds = true
        return view
    }()
    
    private (set) lazy var lblBy: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#333333")
        label.text = "Bye"
        label.textAlignment = .left
        label.font = UIFont(name: AppFontName.book, size: 14)
        return label
    }()
    
    
    private (set) lazy var lblChosing: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#000000")
        label.text = "By Choosing the following"
        label.textAlignment = .left
        label.font = UIFont(name: AppFontName.book, size: 14)
        return label
    }()
    var years : [Years]?
    var models : [Models]?
    var makes : [Makes]?
    var engines : [Engines]?
    var yearDataSource: GenericPickerDataSource<Years>?
    var yearView: PickerFieldView!
    private var yearTxt: String = ""
    private var yearIdTxt: String = ""
    private var selectedYearItem: Int = 0
    
    var makesDataSource: GenericPickerDataSource<Makes>?
    var makeView: PickerFieldView!
    private var makeTxt: String = ""
    private var makeIdTxt: String = ""
    private var selectedMakeItem: Int = 0
    
    var modelsDataSource: GenericPickerDataSource<Models>?
    var modelView: PickerFieldView!
    private var modelTxt: String = ""
    private var modelIdTxt: String = ""
    private var selectedModelItem: Int = 0
    
    var engineDataSource: GenericPickerDataSource<Engines>?
    var engineView: PickerFieldView!
    private var engineTxt: String = ""
    private var engineIdTxt: String = ""
    private var selectedEngineItem: Int = 0
    
    var partsView: CheckboxView!
    var servicView: CheckboxView!
    private var checkedPartCheckbox: Bool = false
    private var checkedServiceCheckbox: Bool = false
    var VINNumberView: TextInputView!
    private var vinNumberTxt: String = ""
    var searchType: SearchByType = .car
    private var productsByCar: [Products]?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        txtField.left(image: UIImage(named: "search"), mode: .always)
        configNav()
        setupView()
        getOptions()
    }
    
    private func getOptions() {
        ServiceManager.shared.sendRequest(request: DropdownOption(), model: OptionsModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.years = response.years
                        self.models = response.models
                        self.makes = response.makes
                        self.engines = response.engines
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    @objc func didTapOnCarSearchBtn(_ sender: UIButton) {
        VINNumberView.isHidden = true
        modelView.isHidden = false
        yearView.isHidden = false
        makeView.isHidden = false
        engineView.isHidden = false
        searchType = .car
        
    }
    @objc func didTapOnVINSearchBtn(_ sender: UIButton) {
        VINNumberView.isHidden = false
        modelView.isHidden = true
        yearView.isHidden = true
        makeView.isHidden = true
        engineView.isHidden = true
        searchType = .vin
    }
    
    private func resetStack() {
        stackView.arrangedSubviews.forEach { (view) in
            stackView.removeArrangedSubview(view)
        }
        
        stackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}
extension SearchVC {
   func configNav() {
       self.navigationController?.navigationBar.tintColor = UIColor.black
       navigationItem.title = "Search"
       let backButton = UIBarButtonItem()
       backButton.title = "Back"
       navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func searchViewByCar() {
        lblChosing.text = "By Choosing the following"
        yearView = PickerFieldView(title: "Year", placeholder: "2000", icon: "down") {
            self.yearDataSource = GenericPickerDataSource<Years>(
                withItems: self.years ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedYearItem,  didSelect: { (data) in
                            self.yearView?.txtField.text = data.name
                            self.yearTxt = data.name ?? ""
                            self.yearIdTxt = data.id ?? ""
                            self.selectedYearItem = self.years?.firstIndex(where: {$0.name == self.yearTxt}) ?? 0
                        })
            self.yearView?.txtField.setupPickerField(withDataSource: self.yearDataSource!)
        }
        yearView.setData(text: yearTxt)
        stackView.addArrangedSubview(yearView)
        
        makeView = PickerFieldView(title: "Make", placeholder: "Honda", icon: "down") {
            self.makesDataSource = GenericPickerDataSource<Makes>(
                withItems: self.makes ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedMakeItem,  didSelect: { (data) in
                            self.makeView?.txtField.text = data.name
                            self.makeTxt = data.name ?? ""
                            self.makeIdTxt = data.id ?? ""
                            self.selectedMakeItem = self.makes?.firstIndex(where: {$0.name == self.makeTxt}) ?? 0
                        })
            self.makeView?.txtField.setupPickerField(withDataSource: self.makesDataSource!)
        }
        makeView.setData(text: makeTxt)
        stackView.addArrangedSubview(makeView)
        
        
        
        modelView = PickerFieldView(title: "Model", placeholder: "Civic", icon: "down") {
            self.modelsDataSource = GenericPickerDataSource<Models>(
                withItems: self.models ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedModelItem,  didSelect: { (data) in
                            self.modelView?.txtField.text = data.name
                            self.modelTxt = data.name ?? ""
                            self.modelIdTxt = data.id ?? ""
                            self.selectedModelItem = self.makes?.firstIndex(where: {$0.name == self.makeTxt}) ?? 0
                        })
            self.modelView?.txtField.setupPickerField(withDataSource: self.modelsDataSource!)
        }
        modelView.setData(text: modelTxt)
        stackView.addArrangedSubview(modelView)
        
        
        
        engineView = PickerFieldView(title: "Engine", placeholder: "1.5 V", icon: "down") {
            self.engineDataSource = GenericPickerDataSource<Engines>(
                withItems: self.engines ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedEngineItem,  didSelect: { (data) in
                            self.engineView?.txtField.text = data.name
                            self.engineTxt = data.name ?? ""
                            self.engineIdTxt = data.id ?? ""
                            self.selectedEngineItem = self.makes?.firstIndex(where: {$0.name == self.makeTxt}) ?? 0
                        })
            self.engineView?.txtField.setupPickerField(withDataSource: self.engineDataSource!)
        }
        engineView.setData(text: engineTxt)
        stackView.addArrangedSubview(engineView)
    }
    
    private func searchViewByVIN() {
        lblChosing.text = "Search by Vehicle VIN number"
        VINNumberView = TextInputView(placeholder: "VIN Number", isPasswordEnable: false, icon: "") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.vinNumberTxt = enteredText
        }
        VINNumberView.txtField.setLeftPaddingPoints(10)
        stackView.addArrangedSubview(VINNumberView)
    }
    
    
    func setupView() {
        edgesForExtendedLayout = []
        selectedYearItem = years?.firstIndex(where: {$0.name == yearTxt}) ?? 0
        selectedYearItem = makes?.firstIndex(where: { $0.name == makeTxt}) ?? 0
        selectedModelItem = models?.firstIndex(where: { $0.name == modelTxt }) ?? 0
        selectedEngineItem = engines?.firstIndex(where: { $0.name == engineTxt}) ?? 0
        
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        searchTxtField()
        searchViewByVIN()
        searchViewByCar()
        
        let btnView = CenterButtonView.init(title: "Search") { [weak self] (clicked) in
            guard let self = self else {return}
            
            if self.searchType == .car {
                self.searchByCar()
            } else {
                self.searchByVINNumber()
            }
            
        }
        stackView.addArrangedSubview(btnView)

    }
    
    private func searchByVINNumber() {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: SearchRequestModel.SearchByVIN(vin_number: vinNumberTxt), model: ProductByCategoryModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        if let product = response.products {
                            let vc = ProductsVC(products: product)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func searchByCar() {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: SearchRequestModel.SearchByCarRequest(year: self.yearIdTxt, make: self.makeIdTxt, engine: self.engineIdTxt, model: self.modelIdTxt), model: ProductByCategoryModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        if let product = response.products {
                            let vc = ProductsVC(products: product)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func searchTxtField() {
        stackView.addArrangedSubview(txtField)
        txtField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
        
        stackView.addArrangedSubview(stackSerachView)
        stackSerachView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
        }
        partsView = CheckboxView(heading: "Parts", image: "unchecked") { select in
            self.checkedPartCheckbox = select
            if self.checkedPartCheckbox == true {
                self.checkedServiceCheckbox = false
                self.servicView.btnIcon.isSelected = false
            }
        }
        
        servicView = CheckboxView(heading: "Services", image: "unchecked") { select in
            self.checkedServiceCheckbox = select
            if self.checkedServiceCheckbox == true {
                self.checkedPartCheckbox = false
                self.partsView.btnIcon.isSelected = false
            }
        }
        stackPartView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
        }
        stackView.addArrangedSubview(stackPartView)
        stackView.addArrangedSubview(lblChosing)
        
    }
    
    
    
}
class DropdownOption : RequestModel {
    override var path: String {
        return Constant.ServiceConstant.DROPDOWN_OPTIONS
    }
}


enum SearchByType: String {
    case car = "bycar"
    case vin = "vin"
}
