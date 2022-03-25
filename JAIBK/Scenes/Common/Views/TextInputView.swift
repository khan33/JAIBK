//
//  TextInputView.swift
//  JAIBK
//
//  Created by Atta khan on 15/02/2022.
//

import UIKit

class TextInputView: UIView {
    
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    
    lazy var txtField: UITextField = {[unowned self] in
        let view = UITextField()
        view.autocapitalizationType = .none
        //view.setLeftPaddingPoints(5)
        view.textAlignment = .left
        view.textColor = .black
        //view.font = AppFonts.txtFieldFont
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 7.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#DBDBDB").cgColor
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return view
    }()
    private (set) lazy var borderView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    private var enterTextCloser: ((_ text: String) -> Void)!
    var heading: String = ""
    init(placeholder: String, isPasswordEnable: Bool, icon: String, enterTextCloser: @escaping (_ text: String) -> Void) {
        super.init(frame: CGRect.zero)
        self.enterTextCloser = enterTextCloser
        if isPasswordEnable {
            txtField.isSecureTextEntry = true
        } else {
            txtField.isSecureTextEntry = false
        }
        txtField.left(image: UIImage(named: icon))
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
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        if !txtField.isDescendant(of: containerView) {
            containerView.addSubview(txtField)
        }
        
        txtField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        txtField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        txtField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        txtField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        txtField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
    
        
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        enterTextCloser(textField.text ?? "")
    }
    
    func setData(text: String?) {
        txtField.text = text
    }
}
