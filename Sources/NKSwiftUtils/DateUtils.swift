//
//  DateUtils.swift
//
//  Created by Khiem on 2020-04-23.
//  Copyright © 2020 KhiemNV. All rights reserved.
//

import Foundation
public extension Date {
	
	/// convert Date to Sring
	/// - Parameters:
	///   - format: format to display
	///   - timezone:
    public func toDateString(format: String = "yyyy-MM-dd",
                             timezone: TimeZone? = TimeZone(identifier: "UTC")) -> String {
        
        let timezone =  TimeZone(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timezone
        let str = formatter.string(from: self as Date)
        return str
    }
	
	/// init from Sring
	/// - Parameters:
	///   - formatDate: format String input (default : "dd/MM/yyyy" )
	///   - stringDate: data string
    public init?(formatDate: String?, stringDate: String?, locale: Locale? = nil) {
        self.init()
        let dateFormatter: DateFormatter =  DateFormatter()

        if formatDate?.isEmpty ?? true {
            dateFormatter.dateFormat = "dd/MM/yyyy"
        } else {
            dateFormatter.dateFormat = formatDate
        }
        if locale != nil {
            dateFormatter.locale = locale
        }

        if let date = dateFormatter.date(from: stringDate ?? "") {
            self = date
        } else {
            return nil
        }
    }
    private func getDay () {
        
    }
}

