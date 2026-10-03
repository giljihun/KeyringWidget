[English](README.md) · **한국어**

# KeyringWidget

사진 한 장으로 흔들리는 키링 위젯을 만드는 예제입니다. [ClockHandKit](https://github.com/giljihun/ClockHandKit)으로 만들었습니다.

<p align="center">
  <img src="Documentation/keyring-app.png" alt="사진을 고르고 생성하는 화면" height="360">
  <img src="Documentation/keyring-widget.gif" alt="흔들리는 키링 위젯" height="360">
</p>

## 원리

사진을 고르면 키링 프레임 58장(30장 + 거꾸로 28장)에 합성합니다.
위젯은 모든 프레임을 겹쳐 두고 각각을 얇은 호 모양으로 가린 다음, ClockHandKit의 `clockHandRotationEffect`로 그 호를 돌립니다. 그래서 한 번에 한 장씩만 보입니다.

## 실행

`KeyringWidget.xcodeproj`를 열고 Team과 App Group을 본인 것으로 바꾼 다음, iOS 26 이상 아이폰에서 실행하세요.
사진을 고르고 홈 화면에 **Keyring** 위젯을 추가하면 됩니다.
