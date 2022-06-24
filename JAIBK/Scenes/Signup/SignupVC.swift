//
//  SignupVC.swift
//  JAIBK
//
//  Created by Atta khan on 18/02/2022.
//

import UIKit
import SVProgressHUD
import Photos
class SignupVC: UIViewController, UINavigationControllerDelegate {
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
    
    private (set) lazy var logoImgView: UIImageView = { [unowned self] in
        var imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "logo")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private (set) lazy var lblTitle: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.init(red: 34 / 255 , green: 50/255, blue: 99/255, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        label.text = "Let’s Get Started"
        label.textAlignment = .center
        return label
    }()
    
    
    private (set) lazy var areYourLbl: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.init(red: 34 / 255 , green: 50/255, blue: 99/255, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.text = "Are you?"
        label.textAlignment = .center
        return label
    }()
    
    private (set) lazy var signInBtn: UIImageView = { [unowned self] in
        var view = UIImageView()
        view.image = UIImage(named: "account_ SignIn")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private (set) lazy var accountLbl: UILabel = { [unowned self] in
        var label = UILabel()
        label.textColor =  UIColor.hexStringToUIColor(hex: "#9098B1")
        label.font = UIFont(name: AppFontName.book, size: 16)
        label.text = "Already have an account? Sign In"
        label.textAlignment = .center
        return label
    }()
    
    
    private (set) lazy var stackView1: UIStackView = { [unowned self] in
        let view = UIStackView()
        view.distribution = .fillEqually
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = 6
        view.clipsToBounds = true
        return view
    }()
    
    var fistNameView: TextInputView!
    var lastNameView: TextInputView!
    var emailView: TextInputView!
    var companyNameView: TextInputView!
    var uplaodImgView: UploadView!
    var passwordView: TextInputView!
    var confirmPasswordView: TextInputView!
    var sellerView: CheckboxView!
    var buyerView: CheckboxView!
    
    
    private var firstNamtTxt: String = ""
    private var lastNamtTxt: String = ""
    private var emailTxt: String = ""
    private var companyNameTxt: String = ""
    private var uploadTxt: String = ""
    private var passwordTxt: String = ""
    private var confirmPasswordTxt: String = ""
    
    private var checkedBuyerCheckbox: Bool = false
    private var checkedSellerCheckbox: Bool = false
    
    private var userType: UserType = .buyer
    private var userRole = UserType.buyer.getUserRole()
    var imagePicker: UIImagePickerController!
    var image: UIImage = UIImage()
    var base64String: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let str = accountLbl.text!
        
        let attributedString = NSMutableAttributedString(string: str)
        
        let range: NSRange = attributedString.mutableString.range(of: "Sign In", options: .caseInsensitive)
        
        attributedString.addAttribute(.font, value: UIFont(name: AppFontName.bold, size: 16), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.hexStringToUIColor(hex: "#000000"), range: range)
        accountLbl.attributedText = attributedString
        accountLbl.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        tapgesture.numberOfTouchesRequired = 1
        accountLbl.addGestureRecognizer(tapgesture)

        
        setupViews()
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let _ = self.accountLbl.text else { return }
        let vc = LoginVC()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func uploadSheet() {
        imagePicker =  UIImagePickerController()
        let optionMenu = UIAlertController(title: "Choose Your Option", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let option1 = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openCamera()
        })
        
        let option2 = UIAlertAction(title: "Photo Library ", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openGallary()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(option1)
        optionMenu.addAction(option2)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        return
    }
    func openCamera() {
        imagePicker =  UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self .present(self.imagePicker, animated: true, completion: nil)
        }
        else {
            let alertWarning = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                
            }
            alertWarning.addAction(okAction)
            self.present(alertWarning, animated: true, completion: nil)
            
        }
    }
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
       
}

extension SignupVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            let fileName = url.lastPathComponent
            uplaodImgView.setData(text: fileName)
        }
        
        image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let jpegCompressionQuality: CGFloat = 0.5 // Set this to whatever suits your purpose
        
        let imgData = NSData(data: image.jpegData(compressionQuality: jpegCompressionQuality)!)
        var imageSize: Int = imgData.count
        print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
        if let string = image.jpegData(compressionQuality: jpegCompressionQuality)?.base64EncodedString() {
            base64String = "data:image/jpeg;base64,\(string)"
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        imagePicker.dismiss(animated: true, completion: nil)
    }
}


extension SignupVC {
    fileprivate func setupViews() {
        
        firstNamtTxt = "Atta"
        lastNamtTxt = "Khan"
        emailTxt = "test432@gmail.com"
        passwordTxt = "admin123"
        confirmPasswordTxt = "admin123"
        
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
        stackView.addArrangedSubview(logoImgView)
                
        logoImgView.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(110)
        }
        stackView.addArrangedSubview(lblTitle)
        stackView.addArrangedSubview(stackView1)
        
        buyerView = CheckboxView(heading: "Buyer", image: "unchecked") { select in
            self.checkedBuyerCheckbox = select
            if self.checkedBuyerCheckbox == true {
                self.checkedSellerCheckbox = false
                self.sellerView.btnIcon.isSelected = false
                self.companyNameView.isHidden = true
                self.uplaodImgView.isHidden = true
                self.userType = UserType.buyer
                self.userRole = self.userType.getUserRole()
                
            }
        }
        self.checkedBuyerCheckbox = true
        self.buyerView.btnIcon.isSelected = true
        sellerView = CheckboxView(heading: "Seller", image: "unchecked") { select in
            self.checkedSellerCheckbox = select
            if self.checkedSellerCheckbox == true {
                self.checkedBuyerCheckbox = false
                self.buyerView.btnIcon.isSelected = false
                self.companyNameView.isHidden = false
                self.uplaodImgView.isHidden = false
                self.userType = UserType.seller
                self.userRole = self.userType.getUserRole()
            }
        }
        self.sellerView.btnIcon.isSelected = false
        stackView1.addArrangedSubview(areYourLbl)
        stackView1.addArrangedSubview(buyerView)
        stackView1.addArrangedSubview(sellerView)

        fistNameView = TextInputView(placeholder: "First Name", isPasswordEnable: false, icon: "user") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.firstNamtTxt = enteredText
        }
        fistNameView.setData(text: firstNamtTxt)
        stackView.addArrangedSubview(fistNameView)
        lastNameView = TextInputView(placeholder: "Last Name", isPasswordEnable: false, icon: "user") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.lastNamtTxt = enteredText
        }
        lastNameView.setData(text: lastNamtTxt)
        stackView.addArrangedSubview(lastNameView)

        emailView = TextInputView(placeholder: "Your email", isPasswordEnable: false, icon: "email") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.emailTxt = enteredText
        }
        emailView.setData(text: emailTxt)
        stackView.addArrangedSubview(emailView)

        companyNameView = TextInputView(placeholder: "Company Name", isPasswordEnable: false, icon: "email") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.companyNameTxt = enteredText
        }
        companyNameView.setData(text: companyNameTxt)
        stackView.addArrangedSubview(companyNameView)

        uplaodImgView = UploadView(placeholder: "Upload Image View", isPasswordEnable: false, icon: "user") {
            self.uploadSheet()
        }
        
        stackView.addArrangedSubview(uplaodImgView)

        self.companyNameView.isHidden = true
        self.uplaodImgView.isHidden = true
        
        passwordView = TextInputView(placeholder: "Password", isPasswordEnable: true, icon: "password") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.passwordTxt = enteredText
        }
        passwordView.setData(text: passwordTxt)
        stackView.addArrangedSubview(passwordView)
        
        confirmPasswordView = TextInputView(placeholder: "Password Again", isPasswordEnable: true, icon: "password") { [weak self] (enteredText) in
            guard let self = self else {return}
            self.confirmPasswordTxt = enteredText
        }
        confirmPasswordView.setData(text: confirmPasswordTxt)
        stackView.addArrangedSubview(confirmPasswordView)

        let btnView = CenterButtonView.init(title: "Sign Up") { [weak self] (clicked) in
            guard let self = self else {return}
            
            if self.firstNamtTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            
            if self.lastNamtTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter last name")
                return
            }
            
            if self.emailTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter email")
                return
            }
            if self.userType == .seller {
                if self.companyNameTxt == "" {
                    self.showAlert(withTitle: "Alert", message: "Enter your company name")
                    return
                }
                
                
                if self.base64String == "" {
                    self.showAlert(withTitle: "Alert", message: "Upload your Image")
                    return
                }
            }
            if self.passwordTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your password")
                return
            }
            
            if self.confirmPasswordTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter your confirm password")
                return
            }
            
            
            if self.confirmPasswordTxt != self.passwordTxt {
                self.showAlert(withTitle: "Alert", message: "Confirm Passwrod mismatch with password")
                return
            }
            let request = SingupRequest(firstname: self.firstNamtTxt, lastname: self.lastNamtTxt, email: self.emailTxt, password: self.passwordTxt, confirm_password: self.confirmPasswordTxt, user_type: self.userType.rawValue, company: self.companyNameTxt, seller_img: self.base64String, role: self.userRole)
            print(request)
            SVProgressHUD.show()
            ServiceManager.shared.sendRequest(request: request, model: UserModel.self) { result in
                SVProgressHUD.dismiss()
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        if response.success ?? false {
                            if let data = response.data {
                                AppUtils.shared.saveUser(user: data)
                                AppUtils.shared.saveToken(token: data.token ?? "")
                            }
                        } else {
                            self.showAlert(withTitle: "Alert", message: response.message ?? "")
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            
            
        }
        stackView.addArrangedSubview(btnView)

        stackView.addArrangedSubview(accountLbl)
 
    }
    
    
    
}


class SingupRequest : RequestModel {
    private var firstname: String
    private var lastname: String
    private var email: String
    private var password: String
    private var confirm_password: String
    private var user_type: String
    private var company: String
    private var seller_img: String
    private var role: String
   
    init(firstname: String, lastname: String, email: String,  password: String, confirm_password: String, user_type: String, company: String, seller_img: String, role: String ) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.company = company
        self.password = password
        self.confirm_password = confirm_password
        self.user_type = user_type
        self.seller_img = seller_img
        self.role = role
    }
    
    
    
    override var path: String {
        return Constant.ServiceConstant.SIGN_UP
    }
    override var body: [String : Any?] {
        return [
            "firstname": firstname,
            "lastname": lastname,
            "email" : email,
            "password" : password,
            "confirm_password" : confirm_password,
            "user_type" : user_type,
            "company" : company,
            "seller_img" : seller_img,
            "role" : role
        ]
    }
    
    override var headers: [String : String] {
        return [
            "Content-Type" : "Application/json",
        ]
    }
    
}


enum UserType: String {
    case seller = "seller"
    case buyer = "buyer"
    
    func getUserRole() -> String {
        switch self {
        case .seller:
            return "2"
        case .buyer:
            return "3"
        default:
            return "1"
        }
    }
}
