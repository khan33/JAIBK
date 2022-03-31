//
//  SubCategoryVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class SubCategoryVC: UIViewController {
    private (set) lazy var collectionViewHome:UICollectionView = { [unowned self] in
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
       
        collectionView.register(SubCategoryCell.self, forCellWithReuseIdentifier: "SubCategoryCell")
        return collectionView;
    }()
    private var subCategory_data: [CategoryData]?
    
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
        print(parent_id)
        getSubCategories()
    }
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        
        let vc = LeftMenuController()
        vc.modalPresentationStyle = .fullScreen
        presentAnimate(vc)
        
    }
    
    private func getSubCategories() {
        ServiceManager.shared.sendRequest(request: SubCategoryRequest(id: parent_id), model: CategoryModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.subCategory_data = response.data
                        self.collectionViewHome.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension SubCategoryVC {
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
        
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        

        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton]
        
     }
    
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        
        if !collectionViewHome.isDescendant(of: view) {
            view.addSubview(collectionViewHome)
        }
        collectionViewHome.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(24)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}
extension SubCategoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategory_data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SubCategoryCell.self, for: indexPath)
        cell.category = subCategory_data?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = subCategory_data?[indexPath.row].id {
            let vc = CategoryDetailVC(id: id)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
class SubCategoryRequest : RequestModel {
    
    private var id: String
   
    init(id: String) {
        self.id = id
        
    }
    override var path: String {
        return Constant.ServiceConstant.SUB_CATEGORIES
    }
    override var headers: [String : String] {
        return [
            "Content-Type" : "application/json",
            "language_id": "1"
        ]
    }
    override var parameters: [String: Any?] {
        return ["parent_id": id]
    }
}
