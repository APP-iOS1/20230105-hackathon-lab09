//
//  Ex+String.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import Foundation

extension String {
	func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
		
		if let date = dateFormatter.date(from: self) {
			return date
		} else {
			return nil
		}
	}
}
