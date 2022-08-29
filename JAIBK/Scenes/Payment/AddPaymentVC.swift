//
//  AddPaymentVC.swift
//  JAIBK
//
//  Created by Atta khan on 15/08/2022.
//

import UIKit

class AddPaymentVC: UIViewController {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
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
    
    var toolBar = UIToolbar()
    var datePicker = UIDatePicker()
    var cardNumberView: EnquireTextFieldView!
    var expireDateView: EnquireTextFieldView!
    private var cardNumberTxt: String = ""
    private var expireDateTxt: String = ""
    private var id: String = ""
    
    private var data: PaymentData?
    
    init(data: PaymentData? = nil) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        createToolBar()
        configNav()
        setupViews()
    }
    func createDatePicker() {
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
    }
    
    func createToolBar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(sender:)))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
        label.text = "Choose your Date"
        let labelButton = UIBarButtonItem(customView:label)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.setItems([flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)
    }
    
    
    @objc func doneButtonPressed(sender: UIBarButtonItem) {
        expireDateView.txtField.resignFirstResponder()
    }
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MM/YYYY"
        expireDateView.txtField.text = dateFormatter.string(from: datePicker.date)
        expireDateTxt = expireDateView.txtField.text ?? ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func configNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Add Payment"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}
extension AddPaymentVC {
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        
        if let data = data {
            self.cardNumberTxt = data.card_numbr ?? ""
            self.expireDateTxt = data.expiry_date ?? ""
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
        
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.makeConstraints{ make -> Void in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(8)
        }
       
        
        cardNumberView = EnquireTextFieldView(title: "Card Number", placeholder: "Card Number") { text in
            self.cardNumberTxt = text
        }
        cardNumberView.txtField.keyboardType = .asciiCapableNumberPad
        cardNumberView.setData(text: cardNumberTxt)
        stackView.addArrangedSubview(cardNumberView)
        
        expireDateView = EnquireTextFieldView(title: "Expire Date", placeholder: "Expire Date") { text in
            self.expireDateTxt = text
        }
        expireDateView.txtField.inputView = datePicker

        expireDateView.setData(text: expireDateTxt)
        
        stackView.addArrangedSubview(expireDateView)
        
        
        
        let btnView = CenterButtonView.init(title: "Save") { [weak self] (clicked) in
            guard let self = self else {return}
            if self.cardNumberTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your card number")
                return
            }
            if self.expireDateTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Select Expiry Date")
                return
            }
            
            var request: RequestModel?
            
            if self.id != "" {
                request = PaymentRequestModel.UpdatePaymentRequest(card_nmbr: self.cardNumberTxt, exp_date: self.expireDateTxt, id: self.id)
            } else {
                request = PaymentRequestModel.AddPaymentRequest(card_nmbr: self.cardNumberTxt, exp_date: self.expireDateTxt)
                
            }
                
            ServiceManager.shared.sendRequest(request: request!, model: PaymentModel.self) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.showAlertOkAction(withTitle: "Alert", message: response.message ?? "") {
                            self.navigationController?.popViewController(animated: true)
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
