//
//  LeftMenuController.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit

class LeftMenuController: UIViewController {
    
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Menu"
        lbl.font = UIFont(name: AppFontName.bold, size: 21)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#49B7B1")
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var itemArray = ["Car Parts", "Car fluids", "Car maintenance", "Accessories", "Services", "Request Parts", "Login", "Signup", "My Account", "About", "Blog"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        edgesForExtendedLayout = []
        if !lblName.isDescendant(of: view) {
            view.addSubview(lblName)
        }
        lblName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(55)
            make.leading.equalTo(self.view).offset(24)
        
        }
        if !tableView.isDescendant(of: view) {
            view.addSubview(tableView)
        }
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lblName.snp.top).offset(24)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
}

extension LeftMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MenuCell
        cell.lblName.text = itemArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //dismissAnimate()
        if indexPath.row == 1 {
            let vc = AddCarVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = GarageVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = AddAddressVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = PaymentMethodVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            let vc = FavouriteVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 6 {
            let vc = BlogVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            let vc = OrdersVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
