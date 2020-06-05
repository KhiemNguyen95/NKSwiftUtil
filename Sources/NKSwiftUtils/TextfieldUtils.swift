//
//  TextfieldUtils.swift
//
//  Created by Khiem on 2020-04-23.
//  Copyright © 2020 KhiemNV. All rights reserved.
//

import UIKit
public extension UITextField {
    public func setPlaceholder(text: String?, color: UIColor = UIColor(white: 0.7, alpha: 1.0)) {
        self.attributedPlaceholder = NSAttributedString(string: text ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
