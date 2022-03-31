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
        let vehicleMilangeView = PickerFieldView(title: "Select your vehicle mileage", placeholder: "500 KM", icon: "down") {
            
        }
        vehicleMilangeView.lblStar.isHidden = true
        view.addSubview(vehicleMilangeView)
        vehicleMilangeView.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(90)
            make.top.equalTo(self.view.snp.top).offset(24)
            make.leading.trailing.equalTo(view).inset(16)
        }
        
        
        if !collectionView.isDescendant(of: view) {
            view.addSubview(collectionView)
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(vehicleMilangeView.snp.bottom).offset(24)
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
            return 8
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(with: CategoryDescriptionCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(with: ViewAllCell.self, for: indexPath)
            cell.lblName.text = "Our Recommendation"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
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
