//
//  ProductMoreInfoCell.swift
//  JAIBK
//
//  Created by Atta khan on 19/04/2022.
//

import UIKit

class ProductMoreInfoCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        return view
    }()
        
        
    private (set) lazy var lblMoreInfo: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.font = UIFont(name: AppFontName.bold, size: 16)
        lbl.text = "More Information"
        lbl.textColor = UIColor.hexStringToUIColor(hex: "#000000")
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private (set) lazy var stackView: UIStackView = { [unowned self] in
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 24
        view.clipsToBounds = true
        return view
    }()
    
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("count in = ", info.count)
        loadUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    var info: [PreviewInfo] = [PreviewInfo]()

    var product: Products? {
        willSet {
            stackView.removeAllArrangedSubviews()
            info.removeAll()
        }
        didSet {
            
            guard let item = product else { return }
            
            info.append (
                contentsOf: [
                    PreviewInfo(key: "SKU:", value:  item.sku ?? ""),
                    PreviewInfo(key: "Part Number (MPN):", value: item.part_number ?? ""),
                    PreviewInfo(key: "Weight", value: item.weight ?? ""),
                    PreviewInfo(key: "Width:", value:  item.width ?? ""),
                    PreviewInfo(key: "Height:", value: item.height ?? ""),
                    PreviewInfo(key: "Depth", value: item.depth ?? ""),
                    PreviewInfo(key: "MPN", value: "22048")
                ]
            )
            for i in 0..<info.count {
                let view = PreviewView(heading: info[i].key, value: info[i].value)
                stackView.addArrangedSubview(view)
            }
        }
    }
    
    
    
    private func loadUIView()  {
        
        
        
        if !containerView.isDescendant(of: contentView) {
            contentView.addSubview(containerView)
        }
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        
        if !lblMoreInfo.isDescendant(of: containerView) {
            containerView.addSubview(lblMoreInfo)
        }
        lblMoreInfo.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        
        if !stackView.isDescendant(of: containerView) {
            containerView.addSubview(stackView)
        }
        stackView.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(lblMoreInfo).offset(8)
            make.bottom.equalToSuperview()
            make.top.equalTo(lblMoreInfo.snp.bottom).offset(8)
        }
    }
    
}

