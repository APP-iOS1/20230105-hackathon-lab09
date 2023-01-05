//
//  User.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import Foundation

struct User: Codable, Identifiable {
	let id: String			// 문서 id
	let bucketId: [String]	// bucket id
	let detailId: [String]	// depth1, bucketdetail들의 id
	var name: String		// 닉네임
	var email: String		// 이메일
	var isPremium: Bool		// 프리미엄 여부
	var updatedAt: Date		// 수정일
	let createdAt: Date		// 생성일
}
