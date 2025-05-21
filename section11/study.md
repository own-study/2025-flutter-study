# 블로그 웹 앱
## 학습 포인트
- WebView Controller 개념
- 외부 패키지 의존성 설치
- [Pub.dev](https://pub.dev) 플러터 라이브러리 검색 사이트
- Semantic Versioning 이란? [참고](https://semver.org/)
- Callback 함수

## Semantic Version
버전 구성 형태 `{major}.{minor}.{patch}`

- Major 버전
  - 하위 호환성 깨짐
  - 기존 API 변경 및 큰 변경사항
  - 중요 변경 사항
- Minor 버전
  - 하위 호환성 유지
  - 주로 기능 추가
  - 기존 코드에 영향을 주지 않는 경우
- Patch 버전
  - 하위 호환성 유지
  - 기존 기능 버그 수정

### 패키지 버저닝 업데이트 케이스
> `^4.3.2` 로 표기된 버전
- `4.3.3` 버전 출시될 경우 자동 업뎃
- `4.4.0` 버전 출시될 경우 자동 업뎃
- `5.0.0` 버전 출시될 경우 업뎃 하지 않음
- Major 버전만 고정된 상태에서 최신버전을 따름

## [Pub.dev](https://pub.dev)
> [npm](https://www.npmjs.com/) 같은 곳

## 블로그 웹 앱 실습
### 1. WebView 패키지 추가

**[Pub.dev](https://pub.dev) 에 검색창에 `'webview'` 검색**<br/><br/>
![image](https://github.com/user-attachments/assets/ed232313-9e17-48de-8af0-da2a6ec7d220)

----

**패키지 명이 `'webview_flutter'` 이면서 패키지 개발자(제공자)명이 `'flutter.dev'`이면서 인증마크가 달린 목록 아이템을 선택**<br/><br/>
![image](https://github.com/user-attachments/assets/6999cf08-20a1-4c04-b208-fbfeae093be3)

----

**클립보드 아이콘 버튼을 클릭하여 패키지명 패키지버전 텍스트 클립보드로 복사**<br/><br/>
![image](https://github.com/user-attachments/assets/2a66a7ca-d2e9-4761-a877-f627ceae30d4)

----

**Android Studio, Flutter Project로 돌아와서, 프로젝트 루트에 `pubspec.yaml` 파일 열기**  
**`pubspec.yaml`의 `dependencies` 값이 있는 곳으로 화면 이동**  
**해당 `dependencies` 아래에 들여쓰기 하여 클립보드 내용을 붙여넣기**  
**오른쪽 상단 `Pub get` 버튼을 누르기**<br/><br/>
![image](https://github.com/user-attachments/assets/990c5094-d57c-4f50-96e4-dc0d4cdbe971)

### 2. 기존 페이지 코드 분리 및 작성
> `lib` 폴더 안에 `home_screen.dart` 등 원하는 파일명(확장자는 유지) 생성
> 해당 파일에 `StatelessWidget` 위젯 상속받아 `HomeScreen` class 작성, 코드스니펫 `stless`도 사용 가능

```dart
// file:home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// file:main.dart
import 'package:flutter/material.dart';
import 'package:your_app_package_name/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),  // MaterialApp
  );
}
```

### 3. 페이지 `appBar` UI 구성
> `Scaffold` 위젯 사용하여, `appBar`등 구성요소 추가  
> `appBar` named Parameter에 `AppBar` 위젯 구성

```dart
// file:home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("My Home Screen Title"),
        centerTitle: true,
      ),  // AppBar
    );  // Scaffold
  }
}
```

### 4. 페이지 WebView 구성
> 페이지 `body` named Parameter에 `WebViewWidget` 위젯 생성 및 추가
> `WebViewWidget` 위젯 생성시 named Parameter에 필수 값인 `controller` 추가
>
> `main.dart` 에서 `WidgetsFlutterBinding.ensureInitialized()` 코드를 추가하여 플러터 프레임워크 실행될때 까지 대기

```dart
// file:home_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController();  // added

  HomeScreen({super.key}); // modified

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(...),
      body: WebViewWidget(controller: controller) // added
    );
  }
}

// file:main.dart
import 'package:flutter/material.dart';
import 'package:your_app_package_name/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // added

  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),  // MaterialApp
  );
}
```

### 5. WebView Controller, Web Page 이동
> `WebViewController` 컨트롤러 메소드에 `loadRequest` 를 호출  
> `loadRequest` 호출시 이동하고자 하는 Web Page `Uri` 값 입력  
>
> `..` 같은 경우 리턴값이 메소드의 리턴값이 아닌 메소드 호출 대상을 리턴, 아래와 같은 예제는 `WebViewController()`를 리턴

```dart
// file:home_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://blog.codefactory.ai'); // added

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
  ..loadRequest(homeUrl); // added

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(...),
      body: WebViewWidget(controller: controller)
    );
  }
}
```

### 6. 기타 controller를 이용한 WebView 제어
> `AppBar` 위젯상 `actions` named Parameter에 `IconButton` 위젯 이용 `onPressed`, `icon`등 named Parameter 구성
> 
> `onPressed` 콜백 이벤트에 `controller`를 이용한 WebView 제어
>
> `homeUrl`로 다시 이동 하는 로직을 만들기


```dart
// file:home_screen.dart
...
      appBar: AppBar(
        ...
        actions: [ // added
          IconButton(
              onPressed: (){
                controller.loadRequest(homeUrl);
              },
              icon: Icon(
                Icons.home,
              ),  // Icon
          )
        ],
      ),
...
```

### 7. JavascriptMode 이해
> 아무런 정의 하지 않는 경우  
> Android는 JavascriptMode가 `disabled` 상태  
> iOS는 JavascriptMode가 `unrestricted` 상태
>
> 예제 코드상 블로그의 게시글 상세 페이지에 유튜브 영상이 작동하지 않는 문제를 해결하는 방법  
> JavascriptMode를  `unrestricted` 상태로 적용하기

```dart
// file:home_screen.dart
...

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted) // added
  ..loadRequest(homeUrl);

  
  ...
}
```

## 마무리 학습퀴즈 첨부
<details><summary>클릭하여 내용을 확인하세요</summary>
  
### 1. 앱 내에서 웹사이트를 보여주기 위해 사용되는 위젯은 무엇일까요?
1. Scaffold
2. AppBar
3. WebView
4. IconButton

### 2. 소프트웨어 버전 관리 표준인 Semantic Versioning의 세 가지 구성 요소가 아닌 것은 무엇일까요?
1. Major
2. Build
3. Minor
4. Patch

### 3. pubspec.yaml 파일에서 패키지 버전 앞에 붙는 '^' 기호의 역할은 무엇일까요?
1. Major 버전 업데이트만 허용
2. Minor 및 Patch 버전의 최신 업데이트 허용 (Major 버전 변경은 제외)
3. 가장 최신 버전으로 무조건 업데이트
4. 어떤 버전 업데이트도 불허, 명시된 버전만 사용

### 4. Flutter 프로젝트에서 외부 패키지를 검색하고 추가하기 위해 주로 이용하는 공식 사이트는 어디일까요?
1. Stack Overflow
2. GitHub
3. Pub.dev
4. Flutter.dev

### 5. Flutter 앱 화면의 기본적인 뼈대와 구조(AppBar, body 등)를 구성하는 데 사용되는 위젯은 무엇일까요?
1. Container
2. MaterialApp
3. Scaffold
4. StatelessWidget

### 6. WebView 위젯의 특정 기능(예: 페이지 이동, 설정 변경)을 제어하기 위해 함께 사용되는 객체는 무엇일까요?
1. State
2. Context
3. Controller
4. Provider

### 7. WebViewController의 loadRequest 함수에 웹 주소 문자열을 전달할 때, 어떤 데이터 타입으로 변환해야 할까요?
1. String
2. URL
3. Uri
4. Address

### 8. 버튼 클릭과 같이 특정 이벤트 발생 시 나중에 실행되도록 미리 정의하여 전달하는 함수를 무엇이라고 부를까요?
1. 비동기 함수 (Async Function)
2. 콜백 함수 (Callback Function)
3. Future 함수 (Future Function)
4. 메인 함수 (Main Function)

### 9. 안드로이드 WebView에서 JavaScript가 포함된 웹사이트(예: YouTube)를 정상적으로 표시하기 위해 WebViewController에 설정해야 하는 속성은 무엇일까요?
1. navigationDelegate
2. javascriptMode
3. userAgent
4. initialUrl

### 10. 코드 가독성과 관리를 위해 여러 파일로 나누어 작성한 코드를 다른 파일에서 사용하려면 어떤 키워드를 이용해야 할까요?
1. export
2. require
3. include
4. import
</details>

