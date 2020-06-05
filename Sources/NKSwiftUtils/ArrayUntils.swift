//
//  ArrayUntils.swift
//
//  Created by Khiem on 2020-04-23.
//  Copyright © 2020 KhiemNV. All rights reserved.
//

import Foundation
extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) -> Element? {
        guard let idx = index(of: element) else {
            return nil
        }
        return self.remove(at: idx)
    }
}
