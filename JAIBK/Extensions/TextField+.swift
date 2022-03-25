//
//  TextField+.swift
//  JAIBK
//
//  Created by Atta khan on 15/02/2022.
//

import UIKit

extension UITextField {
    
    var textUnwarrped: String {
        return text ?? ""
    }
    func left(image: UIImage?, mode: UITextField.ViewMode = .always) {
        if let image = image {
            let imageView = UIImageView(frame: CGRect(x: 10, y: 4, width: 24, height: 24))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            let iconContainerView: UIView = UIView(frame:
                              CGRect(x: 0, y: 0, width: 40, height: 30))
            iconContainerView.addSubview(imageView)
            leftView = iconContainerView
            leftViewMode = mode
            
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }

    func right(image: UIImage?, color: UIColor = .black) {
        if let image = image {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }
    
    public func setPlaceHolderTextColor(_ color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    func placeholder(text value: String, color: UIColor = .red) {
        attributedPlaceholder = NSAttributedString(string: value, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
    func shakeView(colored: Bool) {
        let animation =  CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        let pointX =  CGPoint(x: self.center.x - 10.0, y: self.center.y)
        let pointObjX = NSValue.init(cgPoint: pointX)
        animation.fromValue = pointObjX
        let pointY =  CGPoint(x: self.center.x + 10.0, y: self.center.y)
        let pointObjY = NSValue.init(cgPoint: pointY)
        animation.toValue = pointObjY

        self.layer.add(animation, forKey: "position")
        if colored {
            self.layer.borderColor = UIColor.red.cgColor
        }
    }
}
