//
//  Ex+Date.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import Foundation

extension Date {
	func isBetween(_ startDate: Date, and endDate: Date) -> Bool {
		return startDate <= self && self < endDate
	}
}
