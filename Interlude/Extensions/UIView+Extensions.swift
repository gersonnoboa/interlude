//
//  UIView+Extensions.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

extension UIView {
    static func identifier() -> String {
        return String(describing: self)
    }
    
    static func viewNib() -> UINib {
        let name = String(describing: self)
        return UINib(nibName: name, bundle: Bundle(for: self.self))
    }
}
