//
//  LeftMenuController.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit
import SVProgressHUD

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
    
    var itemArray = ["Car maintenance", "Accessories", "Services", "Blog", "About", "Contact us", "Login", "Signup"]
    
    var item2Array = ["Car maintenance", "Accessories", "Services", "Blog", "Request Parts", "Request Part Enquires", "My Account", "About", "Contact us", "Logout"]
    
    var menuArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        menuArray.removeAll()
        menuArray = itemArray
        
        if let token = UserDefaults.standard.string(forKey: "token"), token != "" {
            self.menuArray = self.item2Array
        } else {
            self.menuArray = self.itemArray
        }
        
        setupViews()
        tableView.reloadData()
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
    
    private func logout() {
        SVProgressHUD.show()
        ServiceManager.shared.sendRequest(request: LogoutRequest(), model: UserModel.self) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
}

extension LeftMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MenuCell
        cell.lblName.text = menuArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //dismissAnimate()
        
        if indexPath.row == 0 {
            let vc = CarMaintanceVC(parent_id: "0")
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = ShopVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = ContactusViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = BlogVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = PageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            let vc = PageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 6 {
            let vc = LoginVC() 
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            let vc = SignupVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 8 {
            let vc = OrdersVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 9 {
            UserDefaults.standard.removeObject(forKey: "token")
            logout()
            let viewController = TabBar()
            UIApplication.shared.windows.first?.rootViewController = viewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
    }
}
