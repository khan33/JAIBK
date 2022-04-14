//
//  CarMaintanceVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class CarMaintanceVC: UIViewController {
    
    private (set) lazy var collectionView:UICollectionView = { [unowned self] in
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.estimatedItemSize = CGSize.zero
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator  = false
        collectionView.register(CategoryDescriptionCell.self, forCellWithReuseIdentifier: "CategoryDescriptionCell")
        collectionView.register(ViewAllCell.self, forCellWithReuseIdentifier: "ViewAllCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView;
    }()
    
    
    var carMaintanceData: [CarMaintanenceData]?
    var carMaintanceDetail: [CarMaintanenceData]?
    var products: [Products]?
    var dataSource: GenericPickerDataSource<CarMaintanenceData>?
    var mileageView: PickerFieldView!
    private var mileageTxt: String = ""
    private var mileageId: String = "0"
    private var selectedMileageItem: Int = 0
    
    private var parent_id: String
    init(parent_id: String) {
        self.parent_id = parent_id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupViews()
        getCarMaintance()
    }
    
    
    private func getCarMaintance() {
        ServiceManager.shared.sendRequest(request: CarMaintanenceRequest(), model: CarMaintanenceModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.carMaintanceData = response.data
                        self.mileageView.txtField.isUserInteractionEnabled = true
                        if self.carMaintanceData?.count ?? 0 > 0 {
                            self.mileageView.setData(text: self.carMaintanceData?[0].mileage)
                            self.getCarMaintanceDetails(id: self.carMaintanceData?[0].id ?? "0")
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func getCarMaintanceDetails(id: String) {
        ServiceManager.shared.sendRequest(request: CarMaintanenceDetailRequest(id: id), model: CarMaintanenceModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.carMaintanceDetail = response.data
                        self.products = response.products
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func updateDescription(_ data: CarMaintanenceData?) {

    }
}
extension CarMaintanceVC {
    fileprivate func configNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "Car fluids"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
     }
    
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        selectedMileageItem = carMaintanceData?.firstIndex(where: {$0.mileage == mileageTxt}) ?? 0

        mileageView = PickerFieldView(title: "Select your vehicle mileage", placeholder: "500 KM", icon: "down") {
            self.dataSource = GenericPickerDataSource<CarMaintanenceData>(
                withItems: self.carMaintanceData ?? [],
                        withRowTitle: { (data) -> String in
                            return data.mileage ?? ""
                        }, row: self.selectedMileageItem,  didSelect: { (data) in
                            self.mileageView?.txtField.text = data.mileage

                            self.mileageTxt = data.mileage ?? ""
                            self.selectedMileageItem = self.carMaintanceData?.firstIndex(where: {$0.mileage == self.mileageTxt}) ?? 0
                            self.getCarMaintanceDetails(id: data.id ?? "0")
                        })
            self.mileageView?.txtField.setupPickerField(withDataSource: self.dataSource!)
        }
        mileageView.setData(text: mileageTxt)
        mileageView.lblStar.isHidden = true
        mileageView.txtField.isUserInteractionEnabled = false
        view.addSubview(mileageView)
        mileageView.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(90)
            make.top.equalTo(self.view.snp.top).offset(24)
            make.leading.trailing.equalTo(view).inset(16)
        }
        
        
        if !collectionView.isDescendant(of: view) {
            view.addSubview(collectionView)
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mileageView.snp.bottom).offset(24)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}
extension CarMaintanceVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return products?.count ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(with: CategoryDescriptionCell.self, for: indexPath)
            cell.lblHeading.attributedText = self.carMaintanceDetail?[indexPath.row].description?.htmlAttributedString()
            cell.lblDesc.attributedText = self.carMaintanceDetail?[indexPath.row].sub_description?.htmlAttributedString()
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(with: ViewAllCell.self, for: indexPath)
            cell.lblName.text = "Our Recommendation"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
            cell.product = self.products?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0  {
            return CGSize(width: collectionView.frame.width - 20, height: 280)
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width - 20, height: 55)
        }
        return CGSize(width: collectionView.frame.width / 2, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
class CarMaintanenceRequest : RequestModel {
    
    override var path: String {
        return Constant.ServiceConstant.CAR_MAINTANCE
    }
    override var headers: [String : String] {
        return [
            "Content-Type" : "application/json",
            "language_id": "1"
        ]
    }
    
}

class CarMaintanenceDetailRequest : RequestModel {
    private var id: String
    init(id: String) {
        self.id = id
        
    }
    override var path: String {
        return Constant.ServiceConstant.CAR_MAINTANCE_DETAIL + "/" + id
    }
    override var headers: [String : String] {
        return [
            "Content-Type" : "application/json",
            "language_id": "1"
        ]
    }
    
}
