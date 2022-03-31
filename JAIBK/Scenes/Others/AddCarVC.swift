//
//  AddCarVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class AddCarVC: UIViewController {
    
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
        navigationItem.title = "Add Address"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    

}
extension AddCarVC {
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
        let yearView = PickerFieldView(title: "Year", placeholder: "2000", icon: "down") {
            
        }

        stackView.addArrangedSubview(yearView)
        
        
        let makeView = PickerFieldView(title: "Make", placeholder: "Honda", icon: "down") {
            
        }
        stackView.addArrangedSubview(makeView)
        
        
        let modelView = PickerFieldView(title: "Model", placeholder: "Civic", icon: "down") {
            
        }
        stackView.addArrangedSubview(modelView)
        
        
        let engineView = PickerFieldView(title: "Engine", placeholder: "1.5 V", icon: "down") { 
            
        }
        stackView.addArrangedSubview(engineView)
        
        let platNumberView = EnquireTextFieldView(title: "Plat Number", placeholder: "Plat number") { text in
        }
        stackView.addArrangedSubview(platNumberView)
        
        let colorView = EnquireTextFieldView(title: "Color", placeholder: "Colr") { text in
        }
        stackView.addArrangedSubview(colorView)
        
        let VINView = EnquireTextFieldView(title: "By Choosing the following", placeholder: "VIN Number") { text in
        }
        stackView.addArrangedSubview(VINView)
        
        
        let btnView = CenterButtonView.init(title: "Save") { [weak self] (clicked) in
            guard let self = self else {return}
        }
        stackView.addArrangedSubview(btnView)
        
    }
}
