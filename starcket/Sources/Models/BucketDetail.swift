//
//  BucketDetail.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import Foundation

struct BucketDetail: Codable, Identifiable {
	let id: String			// 문서 id
	let userId: String		// 사용자 id
	let bucketId: String	// 상위 Bucket id
	var title: String		// 제목 ex) 1월 7일 백설공주, 2월 8일 어린왕자
	var content: String		// 내용
	var image: String		// storage Id
	var rating: Int			// 만족도
	var updatedAt: Date		// 수정일
	let createdAt: Date		// 생성일
}
