//
//  CategoryDetailVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class CategoryDetailVC: UIViewController {
    private (set) lazy var txtField: UITextField = {[unowned self] in
        let view = UITextField()
        view.autocapitalizationType = .none
        view.textAlignment = .left
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.hexStringToUIColor(hex: "#DBDBDB").cgColor
        view.layer.masksToBounds = true
        view.placeholder = "Searchs"
        return view
    }()
    
    private (set) lazy var filterBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "filter"), for: .normal)
        btn.setTitle("", for: .normal)
        return btn
    }()
    
    
    private (set) lazy var orderBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "orderlisting"), for: .normal)
        btn.setTitle("", for: .normal)
        return btn
    }()
    
    private (set) lazy var changeView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        view.layer.cornerRadius = 4
        return view
    }()
    
    private (set) lazy var lblCar: UILabel = {  [unowned self] in
        let lbl = UILabel()
        lbl.text = "Car: KIA Optima 2016 2.0"
        lbl.font = UIFont(name: AppFontName.medium, size: 12)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .white
        return lbl
    }()
    
    private (set) lazy var changeBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setTitle("CHANGE", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: AppFontName.medium, size: 12)
        return btn
    }()
    
    
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
       
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.left(image: UIImage(named: "search"), mode: .always)
        configNav()
        setupViews()
    }
    @objc func didTapCartButton(sender: AnyObject){
        
    }
    
    @objc func didTapHomeButton(sender: AnyObject){
        
    }
  


}
extension CategoryDetailVC {
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
        
        let cartImage    = UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal)
        let homeImage  = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        

        let cartButton   = UIBarButtonItem(image: cartImage,  style: .plain, target: self, action: #selector(didTapCartButton(sender:)))
        let homeButton = UIBarButtonItem(image: homeImage,  style: .plain, target: self, action: #selector(didTapHomeButton(sender:)))
        navigationItem.rightBarButtonItems = [homeButton, cartButton]
        
     }
    
    fileprivate func setupViews() {
        edgesForExtendedLayout = []
        if !txtField.isDescendant(of: view) {
            view.addSubview(txtField)
        }
        txtField.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(view).multipliedBy(0.7)
            make.top.equalTo(view.snp.top).offset(24)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.height.equalTo(55)
        }
        if !orderBtn.isDescendant(of: view) {
            view.addSubview(orderBtn)
        }
        orderBtn.snp.makeConstraints{ (make) -> Void in
            make.width.height.equalTo(24)
            make.leading.equalTo(txtField.snp.trailing).offset(16)
            make.centerY.equalTo(txtField.snp.centerY)
        }
        if !filterBtn.isDescendant(of: view) {
            view.addSubview(filterBtn)
        }
        filterBtn.snp.makeConstraints{ (make) -> Void in
            make.width.height.equalTo(24)
            make.leading.equalTo(orderBtn.snp.trailing).offset(16)
            make.centerY.equalTo(txtField.snp.centerY)
        }
        
        if !changeView.isDescendant(of: view) {
            view.addSubview(changeView)
        }
        changeView.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(44)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.top.equalTo(txtField.snp.bottom).offset(16)
        }
        
        if !lblCar.isDescendant(of: changeView) {
            changeView.addSubview(lblCar)
        }
        lblCar.snp.makeConstraints{ (make) -> Void in
            make.leading.equalTo(changeView.snp.leading).offset(16)
            make.centerY.equalTo(changeView.snp.centerY)
        }
        
        
        if !changeBtn.isDescendant(of: changeView) {
            changeView.addSubview(changeBtn)
        }
        changeBtn.snp.makeConstraints{ (make) -> Void in
            make.trailing.equalTo(changeView.snp.trailing).offset(-16)
            make.centerY.equalTo(changeView.snp.centerY)
        }
        
        if !collectionView.isDescendant(of: view) {
            view.addSubview(collectionView)
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(changeView.snp.bottom).offset(24)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}
extension CategoryDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
