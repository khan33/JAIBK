//
//  GarageVC.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class GarageVC: UIViewController {
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
        collectionView.register(GarageViewCell.self, forCellWithReuseIdentifier: "GarageViewCell")
        return collectionView
    }()
    

    var garageData : [GarageData]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNav()
        setupViews()
        GetGarage()
    }
    
    
    private func GetGarage() {
        ServiceManager.shared.sendRequest(request: GarageRequestModel.GarageRequest(), model: GarageModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.garageData = response.data
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func addGarge() {
        let vc = AddGarageVC(data: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func configNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "GothamNarrow-Medium", size: 20)!
        ]
        navigationItem.title = "Garage"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGarge))
        self.navigationItem.rightBarButtonItem = addBarButton

    }
}
extension GarageVC {
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
    @objc func didTapEditBtn(_ sender: UIButton) {
        let tag = sender.tag
        let data = garageData?[tag]
        let vc = AddGarageVC(data: data)
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @objc func didTapRemoveBtn(_ sender: UIButton) {
        let tag = sender.tag
        let id = garageData?[tag].id ?? "0"
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this item", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.deleteGarage(id: id, index: tag)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(alert, animated: true, completion: nil)
    }
    private func deleteGarage(id: String, index: Int) {
        ServiceManager.shared.sendRequest(request: GarageRequestModel.DeleteGarageRequest(id: id), model: GarageModel.self) { result in
            switch result {
            case .success(let response):
                if response.success ?? false {
                    DispatchQueue.main.async {
                        self.garageData?.remove(at: index)
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension GarageVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if garageData?.count ?? 0 == 0 {
            collectionView.setEmptyView(title: "No Record Found", message: "")
        } else {
            collectionView.restore()
        }
        return garageData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: GarageViewCell.self, for: indexPath)
        cell.garage = garageData?[indexPath.row]
        cell.editBtn.tag = indexPath.row
        cell.removeBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(didTapEditBtn), for: .touchUpInside)
        cell.removeBtn.addTarget(self, action: #selector(didTapRemoveBtn), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 20 , height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
