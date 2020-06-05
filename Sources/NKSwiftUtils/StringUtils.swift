//
//  StringUtils.swift
//
//  Created by Khiem on 2020-04-23.
//  Copyright © 2020 KhiemNV. All rights reserved.
//

import UIKit
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
	
	var isEmptyStringOrIncludeAllWhitespace: Bool {
        var check:Bool? = false
		if ((self.isKind(of: NSNull.classForCoder())) || self.count == 0)
        {
            check = true
        }
        if (self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).count) <= 0 {
            check = true
        }
        return check!
    }
}
