# Flutter WebView 블로그 앱 개발 가이드

## 📚 학습 목표

이번 실습을 통해 다음 개념들을 익혀보겠습니다:

- **WebView Controller** 개념과 활용
- **외부 패키지** 의존성 설치 방법
- **[Pub.dev](https://pub.dev)** Flutter 라이브러리 검색 사이트 활용
- **Semantic Versioning** 개념 이해
- **Callback 함수** 구현

## 🔢 Semantic Versioning 이해하기

### 버전 구성 형태
```
{major}.{minor}.{patch}
```

| 버전 타입 | 설명 | 예시 |
|-----------|------|------|
| **Major** | 하위 호환성이 깨지는 중대한 변경 | `1.0.0` → `2.0.0` |
| **Minor** | 하위 호환성을 유지하며 기능 추가 | `1.0.0` → `1.1.0` |
| **Patch** | 버그 수정 및 소규모 개선 | `1.0.0` → `1.0.1` |

### 패키지 버전 업데이트 규칙

`^4.3.2`로 표기된 경우:
- ✅ `4.3.3` → 자동 업데이트 (Patch)
- ✅ `4.4.0` → 자동 업데이트 (Minor)  
- ❌ `5.0.0` → 업데이트 안함 (Major)

> **Major 버전만 고정**하고 최신 버전을 자동으로 따라가는 방식

## 🌐 Pub.dev 패키지 저장소

[Pub.dev](https://pub.dev)는 Flutter/Dart의 공식 패키지 저장소입니다.
- JavaScript의 [npm](https://www.npmjs.com/)과 유사한 역할
- 검증된 패키지들을 쉽게 찾고 설치 가능

## 🛠️ 블로그 웹 앱 실습

### 1️⃣ WebView 패키지 설치

#### 패키지 검색 및 선택
1. **[Pub.dev](https://pub.dev) 접속**
2. **검색창에 `webview` 입력**

![WebView 검색](https://github.com/user-attachments/assets/ed232313-9e17-48de-8af0-da2a6ec7d220)

3. **`webview_flutter` 패키지 선택**
   - 개발자: `flutter.dev` (공식)
   - 인증 마크 확인 ✅

![패키지 선택](https://github.com/user-attachments/assets/6999cf08-20a1-4c04-b208-fbfeae093be3)

#### 패키지 설치
1. **클립보드 아이콘** 클릭하여 패키지 정보 복사

![패키지 복사](https://github.com/user-attachments/assets/2a66a7ca-d2e9-4761-a877-f627ceae30d4)

2. **`pubspec.yaml` 파일 열기**
3. **`dependencies` 섹션에 패키지 추가**
4. **`Pub get` 버튼 클릭**

![패키지 설치](https://github.com/user-attachments/assets/990c5094-d57c-4f50-96e4-dc0d4cdbe971)

```yaml
dependencies:
  flutter:
    sdk: flutter
  webview_flutter: ^4.4.2  # 추가된 패키지
```

### 2️⃣ 프로젝트 구조 설정

#### 파일 분리 및 기본 구조 생성

```dart
// file: lib/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

```dart
// file: lib/main.dart
import 'package:flutter/material.dart';
import 'package:your_app_package_name/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```

### 3️⃣ AppBar UI 구성

```dart
// file: lib/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("코드팩토리 블로그"),
        centerTitle: true,
      ),
    );
  }
}
```

### 4️⃣ WebView 기본 설정

#### Flutter 프레임워크 초기화 추가

```dart
// file: lib/main.dart
import 'package:flutter/material.dart';
import 'package:your_app_package_name/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 🔥 추가
  
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```

#### WebView Controller 설정

```dart
// file: lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController(); // 🔥 추가

  HomeScreen({super.key}); // const 제거

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("코드팩토리 블로그"),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller), // 🔥 추가
    );
  }
}
```

### 5️⃣ 웹 페이지 로드

```dart
// file: lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://blog.codefactory.ai'); // 🔥 추가

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..loadRequest(homeUrl); // 🔥 추가

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("코드팩토리 블로그"),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
```

### 6️⃣ 홈 버튼 기능 추가

```dart
// file: lib/home_screen.dart
// ... 기존 코드

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.orange,
      title: Text("코드팩토리 블로그"),
      centerTitle: true,
      actions: [ // 🔥 추가
        IconButton(
          onPressed: () {
            controller.loadRequest(homeUrl); // 홈으로 이동
          },
          icon: Icon(Icons.home),
        ),
      ],
    ),
    body: WebViewWidget(controller: controller),
  );
}
```

### 7️⃣ JavaScript 모드 설정

#### 문제 상황
- **Android**: 기본적으로 JavaScript `disabled`
- **iOS**: 기본적으로 JavaScript `unrestricted`
- 블로그의 YouTube 영상이 Android에서 재생되지 않는 문제

#### 해결 방법

```dart
// file: lib/home_screen.dart
class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted) // 🔥 추가
    ..loadRequest(homeUrl);

  HomeScreen({super.key});
  
  // ... 나머지 코드
}
```

## 🔧 WebView Controller 주요 메서드

| 메서드 | 기능 | 사용 예시 |
|--------|------|-----------|
| `loadRequest()` | 특정 URL 로드 | `controller.loadRequest(Uri.parse('https://...'))` |
| `goBack()` | 이전 페이지로 이동 | `controller.goBack()` |
| `goForward()` | 다음 페이지로 이동 | `controller.goForward()` |
| `reload()` | 현재 페이지 새로고침 | `controller.reload()` |
| `setJavaScriptMode()` | JavaScript 모드 설정 | `controller.setJavaScriptMode(JavaScriptMode.unrestricted)` |

## 🎯 핵심 포인트

### Cascade Notation (`..`)
```dart
WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(homeUrl);
```
- `..`는 메서드 체이닝을 위한 Dart 문법
- 각 메서드의 반환값이 아닌 **원본 객체**를 반환
- 위 예제에서는 `WebViewController()` 인스턴스를 반환

### Callback 함수
```dart
IconButton(
  onPressed: () { // 이것이 Callback 함수
    controller.loadRequest(homeUrl);
  },
  icon: Icon(Icons.home),
)
```
- 특정 이벤트 발생 시 호출되는 함수
- 사용자 상호작용에 반응하는 핵심 메커니즘

## 🚀 완성된 코드

```dart
// file: lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://blog.codefactory.ai');

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(homeUrl);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("코드팩토리 블로그"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(homeUrl);
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
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

