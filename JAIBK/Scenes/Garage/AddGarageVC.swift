//
//  AddGarageVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class AddGarageVC: UIViewController, UINavigationControllerDelegate {
    
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
    
    var yearView: PickerFieldView!
    var makeView: PickerFieldView!
    var modelView: PickerFieldView!
    var engineView: PickerFieldView!
    var titleView: EnquireTextFieldView!
    var descView: EnquireTextFieldView!
    var platNumberView: EnquireTextFieldView!
    var colorView: EnquireTextFieldView!
    var VINView: EnquireTextFieldView!
    var uplaodImgView: UploadView!
    private var yearTxt: String = ""
    private var makeTxt: String = ""
    private var modelTxt: String = ""
    private var engineTx: String = ""
    private var titleTxt: String = ""
    private var descTxt: String = ""
    private var platNoTxt: String = ""
    private var colorTxt: String = ""
    private var VinTxt: String = ""
    
    
    var imagePicker: UIImagePickerController!
    var image: UIImage = UIImage()
    var base64String: String = ""
    
    var years : [Years]?
    var models : [Models]?
    var makes : [Makes]?
    var engines : [Engines]?
    var yearDataSource: GenericPickerDataSource<Years>?
    var makesDataSource: GenericPickerDataSource<Makes>?
    var engineDataSource: GenericPickerDataSource<Engines>?
    var modelsDataSource: GenericPickerDataSource<Models>?
    private var selectedModelItem: Int = 0
    private var selectedYearItem: Int = 0
    private var selectedMakeItem: Int = 0
    private var selectedEngineItem: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    func configNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Add Car"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
extension AddGarageVC {
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        selectedYearItem = years?.firstIndex(where: {$0.name == yearTxt}) ?? 0
        selectedYearItem = makes?.firstIndex(where: { $0.name == makeTxt}) ?? 0
        selectedModelItem = models?.firstIndex(where: { $0.name == modelTxt }) ?? 0
        selectedEngineItem = engines?.firstIndex(where: { $0.name == engineTx}) ?? 0
        
        
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
        yearView = PickerFieldView(title: "Year", placeholder: "Select Year", icon: "down") {
            self.yearDataSource = GenericPickerDataSource<Years>(
                withItems: self.years ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedYearItem,  didSelect: { (data) in
                            self.yearView?.txtField.text = data.name
                            self.yearTxt = data.name ?? ""
                            self.selectedYearItem = self.years?.firstIndex(where: {$0.name == self.yearTxt}) ?? 0
                        })
            self.yearView?.txtField.setupPickerField(withDataSource: self.yearDataSource!)
        }
        yearView.setData(text: yearTxt)

        stackView.addArrangedSubview(yearView)
        
        
        makeView = PickerFieldView(title: "Make", placeholder: "Select Make", icon: "down") {
            self.makesDataSource = GenericPickerDataSource<Makes>(
                withItems: self.makes ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedMakeItem,  didSelect: { (data) in
                            self.makeView?.txtField.text = data.name
                            self.makeTxt = data.name ?? ""
                            self.selectedMakeItem = self.makes?.firstIndex(where: {$0.name == self.makeTxt}) ?? 0
                        })
            self.makeView?.txtField.setupPickerField(withDataSource: self.makesDataSource!)
        }
        makeView.setData(text: makeTxt)
        stackView.addArrangedSubview(makeView)
        
        
        modelView = PickerFieldView(title: "Model", placeholder: "Select Model", icon: "down") {
            self.modelsDataSource = GenericPickerDataSource<Models>(
                withItems: self.models ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedModelItem,  didSelect: { (data) in
                            self.modelView?.txtField.text = data.name
                            self.modelTxt = data.name ?? ""
                            self.selectedModelItem = self.makes?.firstIndex(where: {$0.name == self.makeTxt}) ?? 0
                        })
            self.modelView?.txtField.setupPickerField(withDataSource: self.modelsDataSource!)
        }
        modelView.setData(text: modelTxt)
        stackView.addArrangedSubview(modelView)
        
        
        engineView = PickerFieldView(title: "Engine", placeholder: "Select Engine", icon: "down") {
            self.engineDataSource = GenericPickerDataSource<Engines>(
                withItems: self.engines ?? [],
                        withRowTitle: { (data) -> String in
                            return data.name ?? ""
                        }, row: self.selectedEngineItem,  didSelect: { (data) in
                            self.engineView?.txtField.text = data.name
                            self.engineTx = data.name ?? ""
                            self.selectedEngineItem = self.makes?.firstIndex(where: {$0.name == self.makeTxt}) ?? 0
                        })
            self.engineView?.txtField.setupPickerField(withDataSource: self.engineDataSource!)
        }
        engineView.setData(text: engineTx)
        stackView.addArrangedSubview(engineView)
        
        titleView = EnquireTextFieldView(title: "Title", placeholder: "Title") { text in
        }
        stackView.addArrangedSubview(titleView)
        descView = EnquireTextFieldView(title: "Description", placeholder: "Description") { text in
        }
        stackView.addArrangedSubview(descView)
        uplaodImgView = UploadView(placeholder: "Upload Image View", isPasswordEnable: false, icon: "user") {
            self.uploadSheet()
        }
        
        stackView.addArrangedSubview(uplaodImgView)
        platNumberView = EnquireTextFieldView(title: "Plat Number", placeholder: "Plat number") { text in
        }
        stackView.addArrangedSubview(platNumberView)
        
        colorView = EnquireTextFieldView(title: "Color", placeholder: "Colr") { text in
        }
        stackView.addArrangedSubview(colorView)
        
        VINView = EnquireTextFieldView(title: "By Choosing the following", placeholder: "VIN Number") { text in
        }
        stackView.addArrangedSubview(VINView)
        
        
        let btnView = CenterButtonView.init(title: "Save") { [weak self] (clicked) in
            guard let self = self else {return}
            if self.yearTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.makeTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.modelTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.engineTx == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.titleTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.descTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.platNoTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            if self.colorTxt == "" {
                self.showAlert(withTitle: "Alert", message: "Enter first name")
                return
            }
            let request = GarageRequestModel.AddGarageRequest(year: self.yearTxt, make: self.makeTxt, model: self.modelTxt, engine: self.engineTx, plate_number: self.platNoTxt, color: self.colorTxt, title: self.titleTxt, desc: self.descTxt, vin_number: self.VinTxt, image: self.base64String)
            ServiceManager.shared.sendRequest(request: request, model: CityModel.self) { result in
                switch result {
                case .success(let response):
                    if response.success ?? false {
                        DispatchQueue.main.async {
                            
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
extension AddGarageVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let jpegCompressionQuality: CGFloat = 0.5 // Set this to whatever suits your purpose
        
        let imgData = NSData(data: image.jpegData(compressionQuality: jpegCompressionQuality)!)
        var imageSize: Int = imgData.count
        print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
        if let string = image.jpegData(compressionQuality: jpegCompressionQuality)?.base64EncodedString() {
            base64String = string
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
