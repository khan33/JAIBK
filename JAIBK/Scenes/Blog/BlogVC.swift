//
//  BlogVC.swift
//  JAIBK
//
//  Created by Atta khan on 08/03/2022.
//

import UIKit

class BlogVC: UIViewController {
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
        collectionView.backgroundColor = UIColor.systemGroupedBackground
        //collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(BlogViewCell.self, forCellWithReuseIdentifier: "BlogViewCell")
        return collectionView;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUIView()
        
    }
    private func loadUIView()  {
        edgesForExtendedLayout = []
        
        
        if !collectionView.isDescendant(of: view) {
            view.addSubview(collectionView)
        }
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(8)
            make.bottom.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
        }
    }

}
//MARK: - Collection Delegete
extension BlogVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: BlogViewCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: 200)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
