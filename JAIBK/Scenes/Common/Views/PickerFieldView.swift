//
//  PickerFieldView.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit

class PickerFieldView: UIView {
    
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
    private (set) lazy var lblStar: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.red
        label.text = "*"
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
        return view
    }()
    

    lazy var downBtn: UIButton = {[unowned self] in
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("", for: .normal)
        
        return btn
        
    }()
    
    private var enterTextCloser: (() -> Void)!
    var heading: String = ""
    init(title: String, placeholder: String, icon: String,  enterTextCloser: @escaping () -> Void) {
        super.init(frame: CGRect.zero)
        self.enterTextCloser = enterTextCloser
        downBtn.setImage(UIImage(named: icon), for: .normal)
        lblValue.text = title
        setUpContainerView()
        txtField.placeholder = placeholder
        txtField.delegate = self
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
            make.trailing.leading.equalToSuperview()
        }
        
        if !lblValue.isDescendant(of: containerView) {
            containerView.addSubview(lblValue)
        }
        
        lblValue.snp.makeConstraints{ (make) -> Void in
            make.leading.equalTo(containerView)
            make.top.equalTo(containerView).offset(10)
        }
        
        
        if !lblStar.isDescendant(of: containerView) {
            containerView.addSubview(lblStar)
        }
        
        lblStar.snp.makeConstraints{ (make) -> Void in
            make.leading.equalTo(lblValue.snp.trailing).offset(0)
            make.top.equalTo(lblValue.snp.top).offset(-2)
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
        
        if !downBtn.isDescendant(of: containerView) {
            containerView.addSubview(downBtn)
        }
        downBtn.snp.makeConstraints{ (make) -> Void in
            make.trailing.equalTo(txtField.snp.trailing).offset(-16)
            make.centerY.equalTo(txtField.snp.centerY)
            make.width.height.equalTo(24)
        }
        
        
        
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        //enterTextCloser(textField.text ?? "")
    }
    
    
    func setData(text: String?) {
        txtField.text = text
    }

}

extension PickerFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("click here first time...")
        self.enterTextCloser()
        return true
    }
}
