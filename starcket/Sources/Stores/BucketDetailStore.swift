//
//  BucketDetailStore.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import Foundation
import Combine
import FirebaseFirestore

class BucketDetailStore: ObservableObject {
	@Published var bucketDetail: [BucketDetail] = []
	@Published var user: [User] = []

	let database = Firestore.firestore()
	
	// Bucket Detail Data 가져오기
	func fetchBucketDetail(_ detailIdList: [String]) async throws -> [BucketDetail] {
		var data = [BucketDetail]()
		
		for detailId in detailIdList {
			let docRef = try await database.collection("Bucket").document(detailId).getDocument()
			
			let docData = docRef.data()!
			
			let id: String = docData["id"] as? String ?? ""
			let userId: String = docData["userId"] as? String ?? ""
			let bucketId: String = docData["detailId"] as? String ?? ""
			let title: String = docData["title"] as? String ?? ""
			let content: String = docData["title"] as? String ?? ""
			let image: String = docData["title"] as? String ?? ""
			let rating: Int = docData["shape"] as? Int ?? 0
			let updatedAt: Timestamp = docData["updatedAt"] as! Timestamp
			let createdAt: Timestamp = docData["createdAt"] as! Timestamp
			
			data.append(BucketDetail(id: id, userId: userId, bucketId: bucketId, title: title, content: content, image: image, rating: rating, updatedAt: updatedAt.dateValue(), createdAt: createdAt.dateValue()))
		}
		
		return data
	}
	
	// User Data 가져오기
	func fetchUser() async throws -> [User] {
		guard let userId = UserDefaults.standard.string(forKey: "userIdToken") else { return [] }
		
		var data = [User]()
		let docRef = try await database.collection("User").document(userId).getDocument()
		let docData = docRef.data()!
		
		let id: String = docData["id"] as? String ?? ""
		let bucketId: [String] = docData["bucketId"] as? [String] ?? []
		let detailId: [String] = docData["detailId"] as? [String] ?? []
		let name: String = docData["name"] as? String ?? ""
		let email: String = docData["email"] as? String ?? ""
		let isPremium: Bool = docData["isPremium"] as? Bool ?? false
		let updatedAt: Timestamp = docData["updatedAt"] as! Timestamp
		let createdAt: Timestamp = docData["createdAt"] as! Timestamp
		
		data.append(User(id: id, bucketId: bucketId, detailId: detailId, name: name, email: email, isPremium: isPremium, updatedAt: updatedAt.dateValue(), createdAt: createdAt.dateValue()))
		
		return data
	}
	
	// Bucket Detail Data 생성
	func createBucketDetail(_ bucketDetatil: BucketDetail) {
		guard let userId = UserDefaults.standard.string(forKey: "userIdToken") else { return }

		database.collection("BucketDetail").document(bucketDetatil.id).setData([
			"id": bucketDetatil.id,
			"userId": bucketDetatil.userId,
			"bucketId": bucketDetatil.bucketId,
			"title": bucketDetatil.title,
			"content": bucketDetatil.content,
			"image": bucketDetatil.image,
			"rating": bucketDetatil.rating,
			"updatedAt": bucketDetatil.updatedAt,
			"createdAt": bucketDetatil.createdAt
		], completion: { error in
			if let error {
				print(error.localizedDescription)
			}
		})
		
		// 유저의 BucketId 필드에도 저장
		updateUserByBucketDetailId(userId, bucketDetatil.id)
	}
	
	// Bucket Detail Data 수정
	func updateBucketDetail(_ bucketDetatil: BucketDetail) {
		database.collection("BucketDetail").document(bucketDetatil.id).updateData([
			"id": bucketDetatil.id,
			"userId": bucketDetatil.userId,
			"bucketId": bucketDetatil.bucketId,
			"title": bucketDetatil.title,
			"content": bucketDetatil.content,
			"image": bucketDetatil.image,
			"rating": bucketDetatil.rating,
			"updatedAt": bucketDetatil.updatedAt,
			"createdAt": bucketDetatil.createdAt
		], completion: { error in
			if let error {
				print(error.localizedDescription)
			}
		})
	}
	
	// Bucket Detail 삭제
	func removeBucketDetail(_ bucketDetatil: BucketDetail) {
		guard let userId = UserDefaults.standard.string(forKey: "userIdToken") else { return }

		database.collection("BucketDetail").document(bucketDetatil.id).delete()
		let index = bucketDetail.firstIndex { _bucketDetail in
			return _bucketDetail.id == bucketDetatil.id
		}
		bucketDetail.remove(at: index!)
		
		// 유저의 BucketId 필드에도 삭제 반영
		updateUser(userId, bucketDetatil.id)
	}
	
	func updateUser(_ userId: String, _ bucketDetailId: String) {
		let index = user[0].detailId.firstIndex { $0 == bucketDetailId }
		user[0].detailId.remove(at: index!)
		
		database.collection("User").document(userId).updateData([
			"detailId": user.first!.detailId
		], completion: { error in
			if let error {
				print(error.localizedDescription)
			}
		})
	}
	
	// 유저의 BucketId 필드에도 저장
	func updateUserByBucketDetailId(_ userId: String, _ bucketDetailId: String) {
		user[0].detailId.append(bucketDetailId)
		
		database.collection("User").document(userId).updateData([
			"detailId": user.first!.detailId
		], completion: { error in
			if let error {
				print(error.localizedDescription)
			}
		})
	}
}
