//
//  UploadView.swift
//  JAIBK
//
//  Created by Atta khan on 05/04/2022.
//


import UIKit

class UploadView: UIView {
    
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
        view.textAlignment = .left
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#DBDBDB").cgColor
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    private (set) lazy var uplaodBtn: UIButton = { [unowned self] in
        let button = UIButton()
        button.setTitle("UPLOAD", for: .normal)
        button.backgroundColor = .hexStringToUIColor(hex: "#49B7B1")
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: AppFontName.book, size: 12)
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        button.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 7.0, borderColor: UIColor.hexStringToUIColor(hex: "#49B7B1"), borderWidth: 1)
        return button
    }()
    
    
    private (set) lazy var borderView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    private var enterTextCloser: (() -> Void)!
    var heading: String = ""
    init(placeholder: String, isPasswordEnable: Bool, icon: String, enterTextCloser: @escaping () -> Void) {
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
        
        if !uplaodBtn.isDescendant(of: containerView) {
            containerView.addSubview(uplaodBtn)
        }
        uplaodBtn.trailingAnchor.constraint(equalTo: txtField.trailingAnchor, constant: 0).isActive = true
        uplaodBtn.topAnchor.constraint(equalTo: txtField.topAnchor, constant: 0).isActive = true
        uplaodBtn.bottomAnchor.constraint(equalTo: txtField.bottomAnchor, constant: 0).isActive = true
        uplaodBtn.widthAnchor.constraint(equalTo: txtField.widthAnchor, multiplier: 0.25).isActive = true
        
    }
    
   
    
    @objc private func uploadImage() {
        print("click here...")
        enterTextCloser()
    }
    
    func setData(text: String?) {
        txtField.text = text
    }
}
