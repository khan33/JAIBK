//
//  UIViewController+.swift
//  JAIBK
//
//  Created by Atta khan on 21/03/2022.
//

import UIKit
import Foundation
extension UIViewController {
    
    func presentAnimate(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.75
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }

    func dismissAnimate() {
        let transition = CATransition()
        transition.duration = 0.75
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
}
struct AppFontName {
    static let bold = "GothamNarrow-Bold"
    static let book = "GothamNarrow-Book"
    static let medium = "GothamNarrow-Medium"
}
