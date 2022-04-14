//
//  EnquireTextFieldView.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class EnquireTextFieldView: UIView {
    
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var lblValue: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#000000")
        label.text = "Make "
        label.textAlignment = .left
        label.font = UIFont(name: AppFontName.bold, size: 15)
        return label
    }()
   
    
    lazy var txtField: UITextField = {[unowned self] in
        let view = UITextField()
        view.autocapitalizationType = .none
        view.setLeftPaddingPoints(10)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#DBDBDB").cgColor
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        view.font = UIFont(name: AppFontName.bold, size: 14)
        return view
    }()
    
    
    private var enterTextCloser: ((_ text: String) -> Void)!
    var heading: String = ""
    init(title: String, placeholder: String, enterTextCloser: @escaping (_ text: String) -> Void) {
        super.init(frame: CGRect.zero)
        self.enterTextCloser = enterTextCloser
        lblValue.text = title
        setUpContainerView()
        txtField.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpContainerView() {
        if !containerView.isDescendant(of: self) {
            self.addSubview(containerView)
        }
        containerView.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(8)
        }

        if !lblValue.isDescendant(of: containerView) {
            containerView.addSubview(lblValue)
        }
        
        lblValue.snp.makeConstraints{ (make) -> Void in
            make.leading.equalTo(containerView)
            make.top.equalTo(containerView).offset(10)
        }
        
        if !txtField.isDescendant(of: containerView) {
            containerView.addSubview(txtField)
        }
        txtField.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(48)
            make.leading.equalTo(containerView)
            make.trailing.equalTo(containerView)
            make.top.equalTo(lblValue.snp.bottom).offset(8)
            make.bottom.equalTo(containerView).offset(0)
        }
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        enterTextCloser(textField.text ?? "")
    }
    
    func setData(text: String?) {
        txtField.text = text
    }


}
