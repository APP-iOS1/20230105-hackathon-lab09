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
	var bucketId: String	// 상위 Bucket id
	var title: String		// 제목 ex) 1월 7일 백설공주, 2월 8일 어린왕자
	var content: String		// 내용
	var image: String		// storage Id
	var rating: Int			// 만족도
	var updatedAt: Date		// 수정일
	let createdAt: Date		// 생성일
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = createdAt
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}
