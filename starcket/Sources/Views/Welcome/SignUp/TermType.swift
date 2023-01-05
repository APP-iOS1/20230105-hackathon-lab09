//
//  TermType.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//
import Foundation
import SwiftUI

enum TermType: Hashable {
    case total                    // 전체
    case privacy, service        // 필수(서비스, 개인정보) 이용약관
    case emailAndAd                // 선택(Email & SNS 광고)
    
    // display text
    var display: String {
        switch self {
        case .total: return "약관 전체동의"
        case .privacy: return "개인정보 수집 및 이용동의"
        case .service: return "전자상거래(인터넷사이버몰) 표준약관 동의"
        case .emailAndAd: return "E-mail 및 SMS 광고성 정보 수신동의"
        }
    }
    
    // 설명
    var description: String? {
        switch self {
        case .emailAndAd: return "다양한 프로모션 소식 및 신규 매장 정보를 보내드립니다."
        default: return nil
        }
    }
    
    // 필수, 선택
    var isNecessary: Bool {
        switch self {
        case .total: return true
        case .privacy: return true
        case .service: return true
        case .emailAndAd: return false
        }
    }
}
