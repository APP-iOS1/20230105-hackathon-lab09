//
//  BucketListAddView.swift
//  starcket
//
//  Created by 이지연 on 2023/01/05.
//

import SwiftUI

struct BucketListAddView: View {
    @StateObject var bucketStore = BucketStore()
    @Binding var isClickMarker: Bool
    @State private var title = ""
    @State var emojiText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("별킷리스트 추가")
                .font(.custom("Pretendard-Regular", size: 25))
            
            TextFieldWrapperView(text: self.$emojiText)
            
   
            
            TextField(text: $title) {
                Text("입력해주세요.")
                    .font(.custom("Pretendard-Regular", size: 25))
            }
            Button {
                if let userId = UserDefaults.standard.string(forKey: "userIdToken") {
                    let bucket = Bucket(id: UUID().uuidString, userId: userId, detailId: [], icon: "✈️", title: "제주도 여행가기", isCheck: false, isFloat: false, pos: [0.0, 0.0], shape: 0, updatedAt: Date(), createdAt: Date())
                    bucketStore.createBucket(bucket)
                }
            } label: {
                Text("추가")
            }
        }
    }
}

struct TextFieldWrapperView: UIViewRepresentable {

    @Binding var text: String

    func makeCoordinator() -> TFCoordinator {
        TFCoordinator(self)
    }
}

extension TextFieldWrapperView {


    func makeUIView(context: UIViewRepresentableContext<TextFieldWrapperView>) -> UITextField {
        let textField = EmojiTextField()
        textField.delegate = context.coordinator
        return textField
    }


    func updateUIView(_ uiView: UITextField, context: Context) {

    }
}

class TFCoordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldWrapperView

    init(_ textField: TextFieldWrapperView) {
        self.parent = textField
    }

    //        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //            if let value = textField.text {
    //                parent.text = value
    //                parent.onChange?(value)
    //            }
    //
    //            return true
    //        }
}


class EmojiTextField: UITextField {

    // required for iOS 13
    override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}


struct BucketListAddView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}




