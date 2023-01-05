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
    @State var emoji = ""
    @FocusState private var isInFocusTitle: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Text("별킷리스트 추가")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Pretendard-Regular", size: 25))
                .padding(.vertical, Screen.maxHeight*0.04)
                .padding(.leading, Screen.maxHeight*0.05)
            
            TextFieldWrapperView(text: self.$emojiText)
                .background(.gray)
                .onChange(of: emojiText) { value in
                    print(value)
                    if emojiText.count > 1 {
                        emojiText.removeLast()
                    }
                }
            
            
            TextField(text: $title) {
                Text("입력해주세요.")
                    .font(.custom("Pretendard-Regular", size: 25))
            }
            .frame(width: Screen.maxWidth*0.8,height: Screen.maxHeight*0.4)
            .background(Color("bgColor"))
            .cornerRadius(20)
            .focused($isInFocusTitle)
            
            Button {
                if let userId = UserDefaults.standard.string(forKey: "userIdToken") {
                    let bucket = Bucket(id: UUID().uuidString, userId: userId, detailId: [], icon: emojiText, title: title, isCheck: false, isFloat: false, pos: [0.0, 0.0], shape: 0, updatedAt: Date(), createdAt: Date())
                    bucketStore.createBucket(bucket)
                }
            } label: {
                Text("추가")
                    .padding(.horizontal, Screen.maxHeight*0.09)
                    .font(.custom("Pretendard-Regular", size: 18))
                    .padding(.vertical, Screen.maxWidth*0.05)
            }
            .background(Color("mainColor"))
            .cornerRadius(40)
            .padding()
        }
        .toolbar(content: {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    isInFocusTitle = false
                }
            }
        })
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let value = textField.text {
            parent.text = value
        }
        if let value = textField.text {
            if value.count > 1 {
                parent.text = String(value.first!)
            }
        }
        return true
    }
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




