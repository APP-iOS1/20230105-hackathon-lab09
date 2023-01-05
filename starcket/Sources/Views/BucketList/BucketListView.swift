//
//  BucketListView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI

struct BucketListView: View {
	@StateObject var bucketStore = BucketStore()
	
	var body: some View {
		VStack {
			ScrollView {
				ForEach(bucketStore.bucket) { bucket in
					Text(bucket.id)
					Text(bucket.userId)
					Text(bucket.detailId.first ?? "")
					Text(bucket.icon)
					Text(bucket.title)
					Text(bucket.isCheck ? "true" : "false")
					Text("\(bucket.pos.first!)")
					Text("\(bucket.shape)")
					VStack {
						Text("\(bucket.updatedAt)")
						Text("\(bucket.createdAt)")
						Button {
                            let bucket = Bucket(id: UUID().uuidString, userId: "7BW5aWDlcP8E5NllOu4f", detailId: [], icon: "✈️", title: "제주도 여행가기", isCheck: false, isFloat: false, pos: [0.0, 0.0], shape: 0, updatedAt: Date(), createdAt: Date())
							bucketStore.createBucket(bucket)
						} label: {
							Text("추가")
						}
					}
					
					Button {
						
					} label: {
						Text("dd")
					}
					.modifier(GreyBorderedButtonModifier())

				}
			}
		}
		.padding()
//		.onAppear {
//			Task {
//				UserDefaults.standard.set("7BW5aWDlcP8E5NllOu4f", forKey: "userIdToken")
//				(bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucket()
//			}
//		}
	}

}

struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}
