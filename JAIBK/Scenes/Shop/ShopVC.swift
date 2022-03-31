//
//  ShopVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class ShopVC: UIViewController {
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
       
        collectionView.register(ShopViewCell.self, forCellWithReuseIdentifier: "ShopViewCell")
        return collectionView;
    }()
    
    private var category_data: [CategoryData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Browse by"
    
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal)

        
        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton]

        let menuButton = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(didTapMenuButton(sender:)))
        navigationItem.leftBarButtonItem = menuButton
        
        
        setupViews()
        getCategories()
    }
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        
        let vc = LeftMenuController()
        vc.modalPresentationStyle = .fullScreen
        presentAnimate(vc)
        
    }
    private func getCategories() {
        ServiceManager.shared.sendRequest(request: CategoryRequest(), model: CategoryModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.category_data = response.data
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension ShopVC {
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        
        if !collectionView.isDescendant(of: view) {
            view.addSubview(collectionView)
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(24)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}
extension ShopVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category_data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ShopViewCell.self, for: indexPath)
        cell.category = category_data?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let id = category_data?[indexPath.row].id {
                let vc = CarMaintanceVC(parent_id: id)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } else {
            if let id = category_data?[indexPath.row].id {
                let vc = SubCategoryVC(parent_id: id)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
}

class CategoryRequest : RequestModel {
    
    
    override var path: String {
        return Constant.ServiceConstant.CATEGORIES
    }
    override var headers: [String : String] {
        return [
            "Content-Type" : "application/json",
            "language_id": "1"
        ]
    }
}
