# Starcket 🌠
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Swift](https://img.shields.io/badge/SwiftUI-0052CC?style=for-the-badge&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![KakaoTalk](https://img.shields.io/badge/kakaotalk-ffcd00.svg?style=for-the-badge&logo=kakaotalk&logoColor=000000)

## ⚖️ 앱 소개

<p align="center"><img src="https://user-images.githubusercontent.com/48436020/230769200-e694b76d-7078-4066-9554-7a0464ec4e3d.png" width=30%></p>

### 소개

```
해 마다 버킷리스트 작성을 돕고 해마다 버킷리스트를 기록하여 나의 버킷리스트 달성율을 보여주는 서비스
```

### 필요성

```
- 새해가 시작되면서 작년을 되돌아보거나 앞으로의 1년을 계획할 기회가 많지 않다.
- 한 해를 보내면서 연초에 계획한 일들을 하나둘씩 실천하고 있는지에 대한 여부도 확인하기 쉽지 않다.
- 시간은 기다려주지 않으므로 '내가 살아가면서 이뤄가고 싶은 것들을 정리하고 기록'해 나갈 필요가 있다.
```

### 특징
```
- 1년 단위로 버킷리스트를 작성하고 기록한다. (1월 1일에 작성)
- 잘 해내고 있는지 분기마다 푸쉬 알림(로컬)을 보내준다.
- 포근하고 귀여운 디자인
```

### 기대효과
```
- 알찬 1년을 보낼 수 있다.
- 매년 성장해나가는 나를 볼 수 있다.
- 기능이 간단하면서도 귀엽고 포근한 디자인으로 접근성을 높일 수 있다.
```

<br>

## 👨‍👩‍👧‍👦 참여자
<div align="center">
  <table style="font-weight : bold">
      <tr align="center">
          <td colspan="8"> 팀 목표 : 이력서 프로젝트 개발 쓸만한 본인의 개발을 해보자</td>
      </tr>
      <tr>
          <td align="center">
              <a href="https://github.com/GeonHyeongKim">                 
                  <img alt="김건형" src="https://avatars.githubusercontent.com/GeonHyeongKim" width="80" />            
              </a>
          </td>
          <td align="center">
              <a href="https://github.com/suekim999">                 
                  <img alt="김수현" src="https://avatars.githubusercontent.com/suekim999" width="80" />            
              </a>
          </td>
          <td align="center">
              <a href="https://github.com/rirupark">                 
                  <img alt="박민주" src="https://avatars.githubusercontent.com/rirupark" width="80" />            
              </a>
          </td>
          <td align="center">
              <a href="https://github.com/kyungeee">                 
                  <img alt="박희경" src="https://avatars.githubusercontent.com/kyungeee" width="80" />            
              </a>
          </td>
          <td align="center">
              <a href="https://github.com/greenthings">                 
                  <img alt="신현준" src="https://avatars.githubusercontent.com/greenthings" width="80" />            
              </a>
          </td>
          <td align="center">
              <a href="https://github.com/sohee120">                 
                  <img alt="윤소희" src="https://avatars.githubusercontent.com/sohee120" width="80" />            
              </a>
          </td>
          <td align="center">
              <a href="https://github.com/jeoneeee">                 
                  <img alt="이지연" src="https://avatars.githubusercontent.com/jeoneeee" width="80" />            
              </a>
          </td>
          <td align="center">
              <a href="https://github.com/suman0204">                 
                  <img alt="홍수만" src="https://avatars.githubusercontent.com/suman0204" width="80" />            
              </a>
          </td>
      </tr>
      <tr>
          <td align="center">움직이자!</td>
          <td align="center">기획대로</td>
          <td align="center">생일날 대상</td>
          <td align="center">알차고 예쁜</td>
          <td align="center">깔끔한 코드</td>
          <td align="center">데이터 전달</td>
          <td align="center">재미있게</td>
          <td align="center">완성도 있게</td>
      </tr>
      <tr>
          <td align="center">김건형</td>
          <td align="center">김수현</td>
          <td align="center">박민주</td>
          <td align="center">박희경</td>
          <td align="center">신현준</td>
          <td align="center">윤소희</td>
          <td align="center">이지연</td>
          <td align="center">홍수만</td>
      </tr>
  </table>
</div>

<br>

## 📚 실행 가이드 및 설치 방법
### 설치 파일 목록
* ❗️❗️아래 2가지 파일은 필수 파일임으로 파일을 요청해주세요.
```
- Config.xcconfig           // KaKaoSDK 
- GoogleService-Info.plist  // Google, FireBase
```

<br>
<details>
<summary>1. 카카오톡 로그인을 위한 사전작업</summary>
<div markdown="1">

- **config** 파일을 **Starcket** 폴더에 추가한다.
    - config.xcconfig 파일 안에는 KAKAO_NAVTIVE_APP_KEY // 네이티브 앱 키가 들어있다.
    
<br>
    
- **info** 파일에 **Information Property List**에 하단의 내용들이 잘 들어가 있는지 확인
    - LSApplicationQueriesSchemes 에 item 0, item1에 각각 kakaokompassauth, kakaolink 넣기
    - KAKAO_NAVTIVE_APP_KEY에 ${KAKAO_NAVTIVE_APP_KEY}를 넣기
    - App Transport Security Settings에 Allow Arbitrary Loads 가 NO라고 되어있는지 확인
    <img src="https://user-images.githubusercontent.com/105197393/208856526-a1bd28d3-799f-45be-816c-5ac217448187.png">

<br>

- <img src = "https://user-images.githubusercontent.com/105197393/208857521-1d9f5cce-64c6-4903-953e-0da5e36efb5a.png" width="20"> **Starcket**
    - PROJECT의 Info
        - Configurations의 각각 Debug, Release 안에 있는 2개의 파일 모두 Config로 설정
            <img src = "https://user-images.githubusercontent.com/105197393/208858999-fdd802ae-944d-4a31-bb27-fc8e3b422575.png">
        
    - TARGETS의 Info
        - URL Types을 펼쳐 URL Schemes에 kakao{KAKAO_NAVTIVE_APP_KEY} 가 들어있는지 확인
        <img src = "https://user-images.githubusercontent.com/105197393/208859404-ce950c84-3293-487f-a64d-8bdca02be8bc.png">
<br> 

</div>
</details>

<details>
<summary>2. 구글 로그인을 위한 사전 작업</summary>
<div markdown="1">

- **GoogleService-Info.plist**를 프로젝트에 추가
    <img src = "https://user-images.githubusercontent.com/105197393/208861493-7931c43a-da9e-4410-83db-78eb3c3d24dd.png">
    - plist 추가 후 REVERSED_CLIENT_ID의 값을 복사
<br>

- <img src = "https://user-images.githubusercontent.com/105197393/208857521-1d9f5cce-64c6-4903-953e-0da5e36efb5a.png" width="20"> **Starcket**
    - TARGETS의 Info
        - URL Types를 펼쳐 URL Schemes에 **REVERSED_CLIENT_ID**이 들어 있는지 확인
</div>
</details>

<details>
<summary>⚙️ 개발 환경</summary>
<div markdown="1">

- iOS 16.0 이상
- iPhone 14 Pro에서 최적화됨
- 다크모드지원
- 가로모드 미지원

</div>
</details>

<details>
<summary>⚒️ 활용한 기술</summary>
<div markdown="1">

- FireStore
- FireBaseAuth
- GoogleSignIn
- KakaoOpenSDK
- APNs

</div>
</details>

<br>

## 💻 주요기능
- 달성한 버킷리스트 밤하늘
- 버킷리스트 목록
- 버킷리스트 달성율
- 마이페이지 (계정 관리, 다크모드)
- 위젯 기능

<!--

## 📱 스크린샷
<Blockquote>
실제 앱 구동화면입니다
</Blockquote>

| <img src="./image/splash.gif" width="180"/> |  <img src="./image/signIn.gif" width="180"/>  |  <img src="./image/signUp.gif" width="180"/> | <img src="./image/home.gif" width="180"/> | <img src="./image/mapView.gif" width="180"/> |
| :-: | :-: | :-: | :-: | :-: |
| 달성한 버킷리스트 밤하늘
 | 로그인 | 회원가입 | 추천맛집(홈) | MapView(ver1) |

-->

## 🤝 협업 방법
### 코드 컨벤션
```
- [Feat] 새로운 기능 구현
- [Chore] 코드 수정, 내부 파일 수정, 주석
- [Add] Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시, 에셋 추가
- [Fix] 버그, 오류 해결
- [Del] 쓸모없는 코드 삭제
- [Move] 파일 이름/위치 변경
```

### 깃 브랜치
- feat/큰기능명/세부기능명
```
예시)
feat/tap1/home
feat/tap2/list
feat/etc/faceID
```

### 폴더링 컨벤션
```
📦 starcket
| 
+ 🗂 Configuration
|         
+------🗂 Constants   // 기기의 제약사항: width, height를 struct로 관리
│         
+------🗂 Extensions  // extension 모음
│         
+------🗂 Fonts       // 폰트 모음: 무료 폰트인 Pretendard 사용
|
+------🗂 Modifiers   // modifier 모음
│         
+ 🗂 Sources
|
+------🗂 Models      // Json을 받기 위한 Hashable, Codable, Identifiable 프로토콜을 체택한 struct 관리
│         
+------🗂 Store     // ObservableObject을 체택하여 네트워크 관리
|
+------🗂 Views       // 여러 View를 모음
        |
        +------🗂 Welcome       // SignIn / SignUp
        |
        +------🗂 Splash        // Splash View
        │         
        +------🗂 Home          // Tab 1
        |
        +------🗂 BucketList    // Tab 2
        |
        +------🗂 Analyze       // Tab 3
        │         
        +------🗂 MyPage        // Tab 4
        |
        +------🗂 Notification  // Local 알림
        |
        +------🗂 ETC.          // 여분의 View 등
```

<br>

## 🔥 처음 목표
- 김건형 : 로티 넣기. 애니메이션 사용하기. 생동감 있는 앱을 만들고 싶다. 시간을 줄이기 위해 로티를 사용
- 김수현 : 힐링하러 왔다. 하면 제대로 할 것. 기획대로 완성하기.
- 박민주 : 애니메이션. 수상하기. 엄청 간단한 기능인데 사용자가 우와 할 정도.
- 박희경 : 당장 앱스토어에 내놔도 바로 배포 가능한 수준. “알차고 예쁜” 코드 구조화. 모듈화 잘 하기. **대상**
- 신현준 : 동작하고 깔끔한 코드 작성하기. 대상
- 윤소희 : 어,, 음,, 뷰들 간 데이터 전달 매끄럽게 코드 정리. 수상하다 ~
- 이지연 : **재밌게** 해커톤 끝내기. 포폴에 적을 정도의 수준 (높은 완성도). 디자인 & 컨셉. 앱의 확실한 정체성 설정
- 홍수만 : 짧은 시간이지만 완성도 있는 앱 만들기. 재밌게 하는 게 좋긴 한데 여러분들이 원하신다면 맞추겠습니다.

## 라이센스
starcket is available under the MIT license. See the [LICENSE](https://github.com/APPSCHOOL1-REPO/20230105-hackathon-lab09/blob/main/LICENSE) file for more info.
