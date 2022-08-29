//
//  MyAccountVC.swift
//  JAIBK
//
//  Created by Atta khan on 22/03/2022.
//

import UIKit
import SVProgressHUD

class MyAccountVC: UIViewController {
    private (set) lazy var lblUsername: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Mohammad Ali"
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.textAlignment = .center
        return lbl
    }()
    
    private (set) lazy var imgAvatar: UIImageView = {[unowned self] in
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.image = UIImage(named: "userIcon")
        return view
    }()
    
    private (set) lazy var lblAccount: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "My Account"
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
        tableView.register(ConnectUsCell.self, forCellReuseIdentifier: "connectus")
        return tableView
    }()
    
    
    var itemOptions: [MyAccountOptions] = [MyAccountOptions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        itemOptions = [
            MyAccountOptions(title: "Orders", option: nil, indicator: false),
            MyAccountOptions(title: "Enquiries", option: nil, indicator: false),
            MyAccountOptions(title: "Garage", option: nil, indicator: false),
            MyAccountOptions(title: "Payment Method", option: nil, indicator: false),
            MyAccountOptions(title: "Address Book", option: nil, indicator: false),
            MyAccountOptions(title: "Lanuage", option: "English", indicator: true),
            MyAccountOptions(title: "Logout", option: nil, indicator: false)
        ]
        print(itemOptions.count)
    }

}
extension MyAccountVC {
    private func setupViews() {
        edgesForExtendedLayout = []
        if !imgAvatar.isDescendant(of: view) {
            view.addSubview(imgAvatar)
        }
        imgAvatar.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(36)
            make.leading.equalTo(self.view).offset(24)
            make.width.height.equalTo(40)
        
        }
        
        if !lblUsername.isDescendant(of: view) {
            view.addSubview(lblUsername)
        }
        lblUsername.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(imgAvatar.snp.centerY)
            make.leading.equalTo(imgAvatar.snp.trailing).offset(20)
        }
        
        let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        lblUsername.text = userName

        if !lblAccount.isDescendant(of: view) {
            view.addSubview(lblAccount)
        }
        lblAccount.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(imgAvatar.snp.bottom).offset(30)
            make.leading.equalTo(self.view).offset(20)
        }

        if !tableView.isDescendant(of: view) {
            view.addSubview(tableView)
        }
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lblAccount.snp.top).offset(30)
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
extension MyAccountVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return itemOptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MenuCell
            cell.lblName.text = itemOptions[indexPath.row].title
            cell.lblValue.isHidden = true
            cell.imgview.isHidden = false
            if itemOptions[indexPath.row].indicator == true {
                cell.lblValue.isHidden = false
                cell.imgview.isHidden = true
                cell.lblValue.attributedText = NSAttributedString(string: itemOptions[indexPath.row].option ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "connectus", for: indexPath as IndexPath) as! ConnectUsCell
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 200
        }
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = OrdersVC()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = EnquireVC()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let vc = GarageVC()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 3 {
                let vc = PaymentListVC()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 4 {
                let vc = AddressListVC()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 5 {
                
            } else if indexPath.row == 6 {
                UserDefaults.standard.removeObject(forKey: "token")
                logout()
                let viewController = TabBar()
                UIApplication.shared.windows.first?.rootViewController = viewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else if indexPath.row == 7 {
                
            }
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

struct MyAccountOptions {
    let title: String
    let option: String?
    let indicator: Bool
}
