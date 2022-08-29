//
//  CheckboxView.swift
//  JAIBK
//
//  Created by Atta khan on 17/02/2022.
//

import UIKit

class CheckboxView: UIView {
    private (set) lazy var containerView: UIView = {[unowned self] in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private (set) lazy var lblHeading: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor =  .hexStringToUIColor(hex: "#49B7B1")
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        return lbl
    }()
    
    
    private (set) lazy var btnIcon: UIButton = { [unowned self] in
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.clipsToBounds = true
        btn.setImage(UIImage(named: "unchecked"), for: .normal)
        btn.setImage(UIImage(named : "checked"), for: .selected)
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        return btn
    }()
    
    
    private var isSelectedCloser: ((_ isSelected: Bool) -> Void)!
    
    init(heading: String, image: String , isSelectedCloser: @escaping (_ select: Bool) -> Void) {
        super.init(frame: CGRect.zero)
        self.isSelectedCloser = isSelectedCloser
        setUpContainerView()
        lblHeading.text = heading
        btnIcon.setImage(UIImage(named: image), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpContainerView() {
        if !containerView.isDescendant(of: self) {
            self.addSubview(containerView)
        }
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        //containerView.backgroundColor = .red
        
        if !btnIcon.isDescendant(of: containerView) {
            containerView.addSubview(btnIcon)
        }
        btnIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        btnIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        btnIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btnIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        if !lblHeading.isDescendant(of: containerView) {
            containerView.addSubview(lblHeading)
        }

        lblHeading.leadingAnchor.constraint(equalTo: btnIcon.trailingAnchor, constant: 8).isActive = true
        lblHeading.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        lblHeading.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        lblHeading.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc private
    func btnPressed() {
        btnIcon.isSelected = !btnIcon.isSelected
        let isSelected = btnIcon.isSelected
        
        self.isSelectedCloser(isSelected)
    }

}
