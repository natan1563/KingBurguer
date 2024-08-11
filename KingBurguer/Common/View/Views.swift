//
//  Views.swift
//  KingBurguer
//
//  Created by Natã Romão on 22/06/23.
//

import UIKit

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}
