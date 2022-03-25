//
//  SearchByCarVC.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit

class SearchByCarVC: UIViewController {
    
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
        let view = UIStackView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        txtField.left(image: UIImage(named: "search"), mode: .always)
        configNav()
        setupView()
    }

}
extension SearchByCarVC {
   func configNav() {
       self.navigationController?.navigationBar.tintColor = UIColor.black
       navigationItem.title = "Search"
       let backButton = UIBarButtonItem()
       backButton.title = "Back"
       navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    func setupView() {
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        stackView.addArrangedSubview(txtField)
        txtField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
        
        stackView.addArrangedSubview(stackSerachView)
        stackSerachView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
        }
        
        let PartsView = CheckboxView(heading: "Parts", image: "unchecked") { select in
            print(select)
        }
        
        let servicView = CheckboxView(heading: "Services", image: "unchecked") { select in
            print(select)
        }
        stackPartView.addArrangedSubview(lblBy)
        stackPartView.addArrangedSubview(PartsView)
        stackPartView.addArrangedSubview(servicView)
        stackPartView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
        }
        stackView.addArrangedSubview(stackPartView)
        stackView.addArrangedSubview(lblChosing)
        
        
        let yearView = PickerFieldView(title: "Year", placeholder: "2000", icon: "down") { text in
        }
        stackView.addArrangedSubview(yearView)
        
        
        let makeView = PickerFieldView(title: "Make", placeholder: "Honda", icon: "down") { text in
        }
        stackView.addArrangedSubview(makeView)
        
        
        
        let modelView = PickerFieldView(title: "Model", placeholder: "Civic", icon: "down") { text in
        }
        stackView.addArrangedSubview(modelView)
        
        
        
        let engineView = PickerFieldView(title: "Engine", placeholder: "1.5 V", icon: "down") { text in
        }
        stackView.addArrangedSubview(engineView)
        
        let btnView = CenterButtonView.init(title: "Search") { [weak self] (clicked) in
            guard let self = self else {return}
        }
        stackView.addArrangedSubview(btnView)

    }
}
