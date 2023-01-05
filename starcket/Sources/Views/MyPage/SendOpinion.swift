//
//  SendOpinion.swift
//  starcket
//
//  Created by Sue on 2023/01/05.
//

import SwiftUI

struct SendOpinion: View {
    @Binding var showToggle: Bool
    @State var opinion: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("의견 보내기")
                    .font(.body)
                    .bold()
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            TextField("입력하세요.", text: $opinion, axis: .vertical)
                .padding(.horizontal, 20)
                .lineLimit(20, reservesSpace: true)
                .textFieldStyle(.roundedBorder)

            Spacer()
            Button {
                showToggle.toggle()
            } label: {
                Text("보내기")
                    .modifier(MaxWidthColoredButtonModifier(cornerRadius: 15))
            }

        }
    }
}

struct SendOpinion_Previews: PreviewProvider {
    static var previews: some View {
        SendOpinion(showToggle: .constant(true))
    }
}
