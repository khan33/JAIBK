//
//  CategoryDescriptionCell.swift
//  JAIBK
//
//  Created by Atta khan on 23/03/2022.
//

import UIKit

class CategoryDescriptionCell: UICollectionViewCell {
    private (set) lazy var containerView: UIView = { [unowned self] in
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private (set) lazy var lblName: UILabel = {[unowned self] in
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = "Once your car reaches this milestone, there are several systems you will want to have inspected, in addition to the ones listed above, including:"
        lbl.font = UIFont(name: AppFontName.medium, size: 14)

        return lbl
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        if !lblName.isDescendant(of: containerView){
            containerView.addSubview(lblName)
        }
        lblName.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(containerView)
        }
    }
}
