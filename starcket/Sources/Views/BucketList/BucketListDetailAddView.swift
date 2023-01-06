//
//  BucketListDetailView.swift
//  starcket
//
//  Created by 홍수만 on 2023/01/05.
//

import SwiftUI

struct BucketListDetailAddView: View {
    @StateObject var bucketDetailStore = BucketDetailStore()
//    var bucket: Bucket
    
    @State var date = Date()
    @State var imagePickerVisible: Bool = false
//    @State var onImage: Bool = false
    @State var selectedImage: Image? = Image(systemName: "plus.app")
    
    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        ScrollView{
            VStack{
//                Spacer()
                
                Text("나의 별킷 달성을 기록해주세요.")
                    .font(.custom("KNPSKkomi-Regular", size: 28, relativeTo: .title))
                    .padding(.top, 30)
                
                
                
                HStack{
                    Text("🗓️ 달성한 날짜")
                    //                    .font(.custom("Pretendard-Regular", size: 20))
                        .font(.custom("KNPSKkomi-Regular", size: 20, relativeTo: .title))
                    
                    Spacer()
                    
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                }
                .padding(.horizontal, 45)
                .padding(.vertical, 5)
                
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 330, height: 270)
                    .foregroundColor(Color("cellColor"))
                    .overlay{
                        Button{
                            imagePickerVisible.toggle()
                            
                        }label: {
                            if imagePickerVisible {
                                selectedImage?
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 308, height: 254)
                            } else {
                                selectedImage?
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .foregroundColor(Color("mainColor"))
                                
                            }
                        }
                    }
                    .padding()
                
                
                TextField("제목을 입력해주세요", text: $title)
                    .font(.custom("KNPSKkomi-Regular", size: 20, relativeTo: .title))
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                
                TextField("내용을 입력해주세요", text: $content, axis: .vertical)
                    .font(.custom("KNPSKkomi-Regular", size: 20, relativeTo: .title))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .lineLimit(6, reservesSpace: true)
                    
                
//                Spacer()
                
                Button{
                    //                bucketDetailStore.createBucketDetail(BucketDetail(id: <#T##String#>, userId: <#T##String#>, bucketId: <#T##String#>, title: <#T##String#>, content: <#T##String#>, image: <#T##String#>, rating: <#T##Int#>, updatedAt: <#T##Date#>, createdAt: <#T##Date#>))
                } label: {
                    Text("작성완료")
                        .font(.custom("KNPSKkomi-Regular", size: 20, relativeTo: .title))
                        .foregroundColor(.black)
                }
                .modifier(MaxWidthColoredButtonModifier(cornerRadius: 20))
//                .background{
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(width: 354, height: 50)
//                        .foregroundColor(Color("mainColor"))
//
//                }
                
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
