//
//  PreviewView.swift
//  JAIBK
//
//  Created by Atta khan on 20/04/2022.
//

import UIKit

struct PreviewInfo {
    var key: String
    var value: String
}

class PreviewView: UIView {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private (set) lazy var lblHeading: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.font = UIFont(name: AppFontName.book, size: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        return lbl
    }()
    private (set) lazy var lblValue: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.font = UIFont(name: AppFontName.bold, size: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        return lbl
    }()
    
    
    var height: CGFloat = 20.0
    init(heading: String, value: String) {
        super.init(frame: CGRect.zero)
        lblHeading.text = heading
        lblValue.text = value
        setUpContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpContainerView() {
        if !containerView.isDescendant(of: self) {
            self.addSubview(containerView)
        }
        
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        if !lblHeading.isDescendant(of: containerView) {
            containerView.addSubview(lblHeading)
        }
        lblHeading.snp.remakeConstraints { make in
            make.top.leading.bottom.equalTo(containerView).inset(4)
            make.width.equalTo(containerView).multipliedBy(0.45)
        }

        
        
        if !lblValue.isDescendant(of: containerView) {
            containerView.addSubview(lblValue)
        }
        lblValue.snp.remakeConstraints { make in
            make.top.bottom.equalTo(containerView).inset(4)
            make.leading.equalTo(lblHeading.snp.trailing).offset(8)
            make.trailing.equalTo(containerView).inset(8)
            make.width.equalTo(containerView).multipliedBy(0.45)
        }
    }
}
