//
//  BucketListDetailView.swift
//  starcket
//
//  Created by 홍수만 on 2023/01/05.
//

import SwiftUI

struct BucketDetailView: View {
    var body: some View {
        VStack{
            Text("DetailViewTitle")
            //                .font(.custom("Pretendard-Bold", size: 23))
                            .font(.system(size: 25, weight: .bold))

        }
    }
}

struct BucketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BucketDetailView()
    }
}
