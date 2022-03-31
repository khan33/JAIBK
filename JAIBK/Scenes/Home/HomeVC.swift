//
//  ViewController.swift
//  JAIBK
//
//  Created by Atta khan on 11/02/2022.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift

class HomeVC: UIViewController {
    
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
        
        collectionView.register(SearchButtonCell.self, forCellWithReuseIdentifier: "SearchButtonCell")
        collectionView.register(ProductSlider.self, forCellWithReuseIdentifier: "ProductSlider")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(ViewAllCell.self, forCellWithReuseIdentifier: "ViewAllCell")
        collectionView.register(EnquireNowCell.self, forCellWithReuseIdentifier: "EnquireNowCell")
        collectionView.register(LatestMediaCell.self, forCellWithReuseIdentifier: "LatestMediaCell")
        return collectionView;
    }()
    
    private var home_data: HomeModel?
    private var products: [Products]?
    private var media: [Media]?
    private var preference: Preferences?
    private var categories: [Categories]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = ""
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let menuImage = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysOriginal)

        
        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton]

        let menuButton = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(didTapMenuButton(sender:)))
        navigationItem.leftBarButtonItem = menuButton
        setupViews()
        getHomeProducts()
    }
    
    
    private func configCollectionView() {
        collectionViewHome.reloadData()
    }
    
    private func getHomeProducts() {
        ServiceManager.shared.sendRequest(request: HomeRequest(), model: HomeModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.home_data = response
                        print(self.home_data?.products?.count)
                        self.products = self.home_data?.products
                        self.categories = self.home_data?.categories
                        self.media = self.home_data?.media
                        self.preference = self.home_data?.preferences
                        self.configCollectionView()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
    
    @objc func didTapMenuButton(sender: AnyObject){
        
        let vc = LeftMenuController()
        self.navigationController?.pushViewController(vc, animated: false)
        //presentAnimate(vc)
        
    }
    
    @objc func didTapOnAllViewBtn(_ sender: UIButton) {
        if let product = products {
            let vc = ProductsVC(products: product)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension HomeVC {
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
    
    @objc func didTapOnCarSearchBtn(_ sender: UIButton) {
        let vc = SearchByCarVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didTapOnVINSearchBtn(_ sender: UIButton) {
        let vc = SearchByVIN()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3 {
            var count = 0
            count = products?.count ?? 0 > 3 ? 4 : products?.count ?? 0
            return count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(with: SearchButtonCell.self, for: indexPath)
            cell.searchByCarBtn.addTarget(self, action: #selector(didTapOnCarSearchBtn), for: .touchUpInside)
            cell.searchByVIN.addTarget(self, action: #selector(didTapOnVINSearchBtn), for: .touchUpInside)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(with: ProductSlider.self, for: indexPath)
            cell.categories = categories
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(with: ViewAllCell.self, for: indexPath)
            cell.lblName.text = "Most Popular"
            cell.AllViewBtn.addTarget(self, action: #selector(didTapOnAllViewBtn), for: .touchUpInside)
            return cell
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
            cell.product = products?[indexPath.row]
            return cell
        } else if indexPath.section == 5 {
            let cell = collectionView.dequeueReusableCell(with: ViewAllCell.self, for: indexPath)
            cell.lblName.text = "Latest Media"
            return cell
        }
        else if indexPath.section == 6 {
            let cell = collectionView.dequeueReusableCell(with: LatestMediaCell.self, for: indexPath)
            cell.media = self.media
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(with: EnquireNowCell.self, for: indexPath)
            cell.lblName.text = self.preference?.enquire_title
            cell.lblAllView.text = self.preference?.enquire_b_text
            if let img = preference?.home_page_enquire_pic
            {
                let urlString = Constant.baseURL + "images/home/" + img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                cell.imageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "item"))
                cell.imageView.layer.cornerRadius = 15
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 20 , height: 88)
        }
        else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width - 20 , height: 99)
        }
        else if indexPath.section == 2 || indexPath.section == 5 {
            return CGSize(width: collectionView.frame.width - 20 , height: 44)
        }
        else if indexPath.section == 3 {
            return CGSize(width: collectionView.frame.width / 2, height: 280)
        }
        else if indexPath.section == 6 {
            return CGSize(width: collectionView.frame.width, height: 220)
        }
        else {
            return CGSize(width: collectionView.frame.width - 20, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let vc = ProductDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
