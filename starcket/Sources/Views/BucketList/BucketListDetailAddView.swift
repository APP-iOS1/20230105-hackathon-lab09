//
//  BucketListDetailView.swift
//  starcket
//
//  Created by 홍수만 on 2023/01/05.
//

import SwiftUI

struct BucketListDetailAddView: View {
    @StateObject var bucketDetailStore = BucketDetailStore()
//    var bucketId: String

    @State var date = Date()
    @State var imagePickerVisible: Bool = false
    @State var selectedImage: Image? = Image(systemName: "plus.app")
    
    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        ScrollView{
            VStack{
//                Spacer()
                
                Text("나의 별킷 달성을 기록해주세요.")
                //                .font(.custom("Pretendard-Bold", size: 23))
                    .font(.system(size: 25, weight: .bold))
                    .bold()
                    .padding(.top, 30)
                
                
                
                HStack{
                    Text("🗓️ 달성한 날짜")
                    //                    .font(.custom("Pretendard-Regular", size: 20))
                        .font(.system(size: 20, weight: .regular))
                        .bold()
                    
                    Spacer()
                    
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                }
                .padding(.horizontal, 45)
                .padding(.vertical, 5)
                
                
                Button{
                    imagePickerVisible.toggle()
                }label: {
                    if imagePickerVisible {
                        selectedImage?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 308, height: 254)
                            .foregroundColor(Color("mainColor"))
                    } else {
                        selectedImage?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .foregroundColor(Color("mainColor"))
                        
                    }
                    
                }
                .padding()
                
                TextField("제목을 입력해주세요", text: $title)
                    .padding()
                    .padding(.horizontal)
                
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                
                TextField("내용을 입력해주세요", text: $content, axis: .vertical)
                    .lineLimit(6, reservesSpace: true)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                
//                Spacer()
                
                Button{
                    //                bucketDetailStore.createBucketDetail(BucketDetail(id: <#T##String#>, userId: <#T##String#>, bucketId: <#T##String#>, title: <#T##String#>, content: <#T##String#>, image: <#T##String#>, rating: <#T##Int#>, updatedAt: <#T##Date#>, createdAt: <#T##Date#>))
                } label: {
                    Text("작성완료")
                        .font(.system(size: 20, weight: .bold))
                        .bold()
                }
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 354, height: 50)
                        .foregroundColor(Color("mainColor"))
                    
                }
                
                Spacer()
                
            }
        }
        .background{
            Color("tempBgColor")
                .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $imagePickerVisible) {
            MyImagePicker(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
        }
    }
}

struct BucketListDetailAddView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListDetailAddView()
    }
}
