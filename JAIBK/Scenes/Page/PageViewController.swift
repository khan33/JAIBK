//
//  PageViewController.swift
//  JAIBK
//
//  Created by Atta khan on 12/08/2022.
//

import UIKit

class PageViewController: UIViewController {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var textView: UITextView = { [unowned self] in
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = false
        view.font = UIFont(name: AppFontName.medium, size: 12)
        view.textAlignment = .justified
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        textView.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
        self.title = "About us"
        
    }

}


extension PageViewController {
    private func setupView() {
        if !containerView.isDescendant(of: self.view) {
            self.view.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        if !textView.isDescendant(of: containerView) {
            containerView.addSubview(textView)
        }
        textView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview().inset(12)
        }
    }
}

enum pageType:Int {
    case deliveryInformation = 6
    case aboutUs = 4
    case beautyTips = 26
    case contactUs = 21
    case privacyPolicy = 3
    case termsCondiction = 5
}
