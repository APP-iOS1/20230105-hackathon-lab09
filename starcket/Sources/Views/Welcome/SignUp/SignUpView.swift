//
//  SignUpView.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//
import SwiftUI

struct SignUpView: View {
    //MARK: Property wrapper
    //	@Binding var isLoginSheet: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var isTermsClick: [Bool] = [Bool](repeating: false, count: 4)
    @State private var isNecessaryClick: [Bool] = [Bool](repeating: false, count: 2)
    @Binding var navStack: NavigationPath
    
    //MARK: Property
    let totalTerm = TermType.total
    let terms: [TermType] = [.total, .privacy, .service, .emailAndAd]
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Image(systemName: "globe") // Image는 Modifier Custom을 어떻게 할까..?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                        .foregroundColor(.accentColor)
                        .padding(.bottom, 20)
                    Text("고객님\n환영합니다!")
                        .font(.title)
                        .bold()
                } // VStack - 안내문구 text
                Spacer()
            } // HStack - 안내문구 Vstack
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Spacer()
            Spacer()
            Spacer()
            
            VStack(spacing: 20) {
                ForEach(Array(terms.enumerated()), id: \.offset) { i, term in
                    TermCellView(isTermsClick: $isTermsClick, isNecessaryClick: $isNecessaryClick, isClick: $isTermsClick[i], term: term)
                    
                    if term == .total {
                        Divider().frame(width: UIScreen.main.bounds.width)
                    }
                } // ForEach
            } // VStack
            .padding(.horizontal)
            
            Spacer()
            Divider().frame(width: UIScreen.main.bounds.width)
            
            NavigationLink {
                SignUpStep1View(navStack: $navStack)
            } label: {
                Text("다음")
                    .modifier(MaxWidthColoredButtonModifier(cornerRadius: 15))
            } // NavigationLink - 다음
            .disabled(!(isTermsClick[1] && isTermsClick[2]) ? true : false)
        } // VStack
        .toolbar {
            ToolbarItem(placement: .principal) { // 회원가입 진행 현황 툴바
                CustomProgressView(nowStep: 1)
            } // toolbarItem
        } // toolbar
        .sheet(isPresented: $isNecessaryClick[0], onDismiss: nil) {
            SafariView(url: URL(string:"https://glacier-bucket-5c2.notion.site/8ef1818eade54304a51d0563397d80b9")!)
        }
        .sheet(isPresented: $isNecessaryClick[1], onDismiss: nil) {
            SafariView(url: URL(string:"https://glacier-bucket-5c2.notion.site/b32cbc95de6d41328bfa47a7ba7b3aa8")!)
        }
    } // Body
}

//MARK: - TermCellView
struct TermCellView: View {
    //MARK: Property wrapper
    @Binding var isTermsClick: [Bool]
    @Binding var isNecessaryClick: [Bool]
    @Binding var isClick: Bool
    
    //MARK: Property
    let term: TermType
    
    var body: some View {
        HStack {
            Button {
                isClick.toggle()
                
                if term == .total {
                    isTermsClick = isTermsClick.map{ _ in isClick}
                } else {
                    isTermsClick[0] = !isTermsClick[1...].contains(false) ? true : false
                }
                if term == .privacy && isTermsClick[1] {
                    isNecessaryClick[0] = true
                } else if term == .service && isTermsClick[2] {
                    isNecessaryClick[1] = true
                }
            } label: {
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(
                            Circle()
                                .stroke(isClick ? .clear : Color.secondary, lineWidth: 2)
                                .background(
                                    Circle()
                                        .fill(isClick ? .accentColor : Color.white)
                                )
                        )
                    
                    HStack(spacing: 5) {
                        Text(term.display)
                        Text(term.isNecessary ? term == .total ? "" : "(필수)" : "(옵션)")
                            .foregroundColor(term.isNecessary ? .red : .black)
                        Spacer()
                        if term.isNecessary && term != .total {
                            Image(systemName: "chevron.right")
                        }
                    } // HStack
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .font(.subheadline)
                } // HStack
                .frame(height: 25)
            }
            Spacer()
        }
    }
}

struct CustomProgressView: View {
    let nowStep: Int
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...3, id: \.self) { index in
                Circle()
                    .stroke(index == nowStep ? Color.accentColor : Color.gray, lineWidth: 1)
                    .frame(width: 25)
                    .background(
                        Circle()
                            .fill(index == nowStep ? Color.accentColor : Color.white)
                    )
                    .overlay {
                        Text("\(index)")
                            .font(.footnote)
                            .foregroundColor(index == nowStep ? Color.white : Color.gray)
                    }
                Rectangle()
                    .frame(width: index != 3 ? 15 : 0, height: 1)
                    .foregroundColor(Color.gray)
            }
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView(navStack: .constant(NavigationPath()))
        }
    }
}
