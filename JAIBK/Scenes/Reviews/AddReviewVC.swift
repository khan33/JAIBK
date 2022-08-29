//
//  AddReviewVC.swift
//  JAIBK
//
//  Created by Atta khan on 17/08/2022.
//

import UIKit
import Cosmos
class AddReviewVC: UIViewController, UINavigationControllerDelegate {
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
    private (set) lazy var ratingMainView: UIView = { [unowned self] in
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) lazy var ratingView: CosmosView = {[unowned self] in
        let cosmosView = CosmosView()
        cosmosView.rating = 0
        cosmosView.settings.updateOnTouch = true
        cosmosView.settings.fillMode = .full
        cosmosView.settings.starSize = 24
        cosmosView.settings.starMargin = 6
        cosmosView.settings.filledColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        cosmosView.settings.filledImage = UIImage(named: "StarFilled")
        cosmosView.settings.emptyImage = UIImage(named: "StarEmpty")
        return cosmosView
    }()
    
    
    
    private var titleTxt: String = ""
    private var emailTxt: String = ""
    private var messageTxt: String = ""
    
    var titleView: EnquireTextFieldView!
    var uplaodImgView: UploadView!
    var enterMessageView: MessageTextField!
    var imagePicker: UIImagePickerController!
    var image: UIImage = UIImage()
    var base64String: String = ""
    
    var product: Products
    
    init(product: Products) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupViews()
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
extension AddReviewVC {
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
        titleTxt = product.title ?? ""
        
        titleView = EnquireTextFieldView(title: "Title", placeholder: "Enter Title"){ [weak self] (enteredText) in
            guard let self = self else {return}
            self.titleTxt = enteredText
        }
        titleView.txtField.isUserInteractionEnabled = false
        titleView.setData(text: titleTxt)
        
        stackView.addArrangedSubview(titleView)
        
        ratingMainView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        stackView.addArrangedSubview(ratingMainView)
        
        if !ratingView.isDescendant(of: ratingMainView) {
            ratingMainView.addSubview(ratingView)
        }
        ratingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
        
        enterMessageView = MessageTextField(title: "Enter your Message", placeholder: "") { text in
            self.messageTxt = text
        }
        enterMessageView.setData(text: messageTxt)
        stackView.addArrangedSubview(enterMessageView)
        
        uplaodImgView = UploadView(placeholder: "Upload Image View", isPasswordEnable: false, icon: "user") {
            self.uploadSheet()
        }
        stackView.addArrangedSubview(uplaodImgView)
        
        
        let btnView = CenterButtonView.init(title: "Submit") { [weak self] (clicked) in
            guard let self = self else {return}
            let ratingNumber = self.ratingView.rating
            
            if self.titleTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter Name")
                return
            }
            
            if self.messageTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter message")
                return
            }
            
            let request = ProductReviewRequestModel.AddReviewRequest(product_id: self.product.product_id ?? "0", rating: String(describing: ratingNumber), review: self.messageTxt, image: self.base64String)
            
            ServiceManager.shared.sendRequest(request: request, model: GarageModel.self) { result in
                switch result {
                case .success(let response):
                    if response.success ?? false {
                        DispatchQueue.main.async {
                            self.showAlertOkAction(withTitle: "Alert", message: response.message ?? "Success,Review added successfully.") {
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
    
    
    func configNav() {
        self.title = "Write Review"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
extension AddReviewVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let jpegCompressionQuality: CGFloat = 0.3 // Set this to whatever suits your purpose
        
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
