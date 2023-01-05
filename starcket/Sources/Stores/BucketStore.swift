//
//  BucketStore.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import Foundation
import Combine
import FirebaseFirestore

class BucketStore: ObservableObject {
    
    @Published var bucket: [Bucket] = []
    @Published var bucketIdList: [String] = []
    @Published var isLoading: Bool = false
    @Published var starPosArr: [CGSize] = []
    
    let database = Firestore.firestore()
    
    // Bucket Data 가져오기
    func fetchBucket() async throws -> (data: [Bucket], bucketIdList: [String], data3:[CGSize]) {
        guard let userId = UserDefaults.standard.string(forKey: "userIdToken") else { return (data: [], bucketIdList: [], data3: []) }
        
        let docRef = try await database.collection("User").document(userId).getDocument()
        
        var data = [Bucket]()
        var data3 = [CGSize]()
        
        let docData = docRef.data()
        
        let bucketIdList: [String] = docData?["bucketId"] as? [String] ?? []
        
        for bucketId in bucketIdList {
            let docRef = try await database.collection("Bucket").document(bucketId).getDocument()
            
            let docData = docRef.data()!
            
            let id: String = docData["id"] as? String ?? ""
            let userId: String = docData["userId"] as? String ?? ""
            let detailId: [String] = docData["detailId"] as? [String] ?? []
            let icon: String = docData["icon"] as? String ?? ""
            let title: String = docData["title"] as? String ?? ""
            let isCheck: Bool = docData["isCheck"] as? Bool ?? false
            let isFloat: Bool = docData["isFloat"] as? Bool ?? false
            let pos: [Double] = docData["pos"] as? [Double] ?? []
            let shape: Int = docData["shape"] as? Int ?? 0
            let updatedAt: Timestamp = docData["updatedAt"] as! Timestamp
            let createdAt: Timestamp = docData["createdAt"] as! Timestamp
            
            data.append(Bucket(id: id, userId: userId, detailId: detailId, icon: icon, title: title, isCheck: isCheck, isFloat: isFloat, pos: pos, shape: shape, updatedAt: updatedAt.dateValue(), createdAt: createdAt.dateValue()))
            
            if isCheck == true && isFloat == true {
                data3.append(CGSize(width: pos[0], height: pos[1]))
            }
        }
        
        return (data, bucketIdList, data3)
    }
    
    // 년도별 Bucket Data 가져오기
    func fetchBucketByDate(_ date: String) async throws -> (data: [Bucket], bucketIdList: [String]) {
        guard let userId = UserDefaults.standard.string(forKey: "userIdToken") else { return (data: [], bucketIdList: []) }
        
        let startDate = "\(date)-01-01".toDate()!
        let endDate = "\(Int(date)! + 1)-01-01".toDate()!
        
        let docRef = try await database.collection("User").document(userId).getDocument()
        
        var data = [Bucket]()
        var data2 = [String]()
        
        let docData = docRef.data()
        
        let bucketIdList: [String] = docData?["bucketId"] as? [String] ?? []
        
        for bucketId in bucketIdList {
            let docRef = try await database.collection("Bucket").document(bucketId).getDocument()
            
            let docData = docRef.data()!
            
            let id: String = docData["id"] as? String ?? ""
            let userId: String = docData["userId"] as? String ?? ""
            let detailId: [String] = docData["detailId"] as? [String] ?? []
            let icon: String = docData["icon"] as? String ?? ""
            let title: String = docData["title"] as? String ?? ""
            let isCheck: Bool = docData["isCheck"] as? Bool ?? false
            let isFloat: Bool = docData["isFloat"] as? Bool ?? false
            let pos: [Double] = docData["pos"] as? [Double] ?? []
            let shape: Int = docData["shape"] as? Int ?? 0
            let updatedAt: Timestamp = docData["updatedAt"] as! Timestamp
            let createdAt: Timestamp = docData["createdAt"] as! Timestamp
            
            if createdAt.dateValue().isBetween(startDate, and: endDate) {
                data.append(Bucket(id: id, userId: userId, detailId: detailId, icon: icon, title: title, isCheck: isCheck, isFloat: isFloat, pos: pos, shape: shape, updatedAt: updatedAt.dateValue(), createdAt: createdAt.dateValue()))
                data2.append(bucketId)
            }
        }
        
        data.sort {
            $0.isCheck != $1.isCheck
        }
        return (data, data2)
    }
    
    
    // Bucket Data 생성
    func createBucket(_ bucket: Bucket) {
        guard let userId = UserDefaults.standard.string(forKey: "userIdToken") else { return }
        
        database.collection("Bucket").document(bucket.id).setData([
            "id": bucket.id,
            "userId": bucket.userId,
            "detailId": bucket.detailId,
            "icon": bucket.icon,
            "title": bucket.title,
            "isCheck": bucket.isCheck,
            "isFloat": bucket.isFloat,
            "pos": bucket.pos,
            "shape": bucket.shape,
            "updatedAt": bucket.updatedAt,
            "createdAt": bucket.createdAt
        ], completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
        
        // 유저의 BucketId 필드에도 저장
        updateUserByBucketId(userId, bucket.id)
    }
    
    // Bucket Data 수정
    func updateBucket(_ bucket: Bucket) {
        database.collection("Bucket").document(bucket.id).updateData([
            "id": bucket.id,
            "userId": bucket.userId,
            "detailId": bucket.detailId,
            "icon": bucket.icon,
            "title": bucket.title,
            "isCheck": bucket.isCheck,
            "isFloat": bucket.isFloat,
            "pos": bucket.pos,
            "shape": bucket.shape,
            "updatedAt": bucket.updatedAt,
            "createdAt": bucket.createdAt
        ], completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    // Bucket 부분 수정 (isCheck)
    func completedBucket(_ bucketId: String, _ isCheck: Bool) {
        database.collection("Bucket").document(bucketId).updateData([
            "isCheck": isCheck
        ], completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    // 스타를 홈화면에 추가한뒤 값을 변경해주는 메서드
    func updateStar(_ id: String, isFloat: Bool, shape: Int) {
        database.collection("Bucket").document(id).updateData( [
            "isFloat": isFloat,
            "shape": shape
        ], completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
    func updateStarPos(_ id: String, _ x:Double, _ y:Double ) {
        database.collection("Bucket").document(id).updateData( [
            "pos": [x,y]], completion: { error in
                if let error {
                    print(error.localizedDescription)
                }
            })
    }
    
    // 유저의 BucketId 필드에도 저장
    func updateUserByBucketId(_ userId: String, _ bucketId: String) {
        bucketIdList.append(bucketId)
        
        database.collection("User").document(userId).updateData([
            "bucketId": bucketIdList
        ], completion: { error in
            if let error {
                print(error.localizedDescription)
            }
        })
    }
    
}
