# Splash Screen

## 📚 학습 목표

이번 실습을 통해 다음 개념들을 익혀보겠습니다:

- **이미지 리소스** 등록 및 관리
- **StatelessWidget** 활용법
- **Flutter 위젯** 조합 기법
- **Hot Reload vs Hot Restart** 차이점
- **Context Actions** 편의 기능

## 🖼️ 이미지 리소스 등록하기

### 💡 핵심 요약
> 프로젝트 폴더에 이미지 폴더를 생성하고, `pubspec.yaml`에 등록한 후 `Pub get`을 실행하면 완료!

### 1️⃣ 이미지 폴더 생성

**프로젝트 루트에서 폴더 생성**
1. 프로젝트명 **우클릭** → **New** → **Directory**

![폴더 생성](https://github.com/user-attachments/assets/74bb9c1b-b312-4223-8a34-5c65ab37b71d)

2. **원하는 폴더명 입력** (예: `res`)

![폴더명 입력](https://github.com/user-attachments/assets/a0936e0a-7ad4-4db2-9863-45e7eb41e231)

3. **하위 폴더 생성** (예: `res/imgs`)

![하위 폴더](https://github.com/user-attachments/assets/85a02ee1-5471-4e01-be23-8260423bb5ae)

### 2️⃣ 이미지 파일 추가

**생성한 폴더에 이미지 파일 복사**

![이미지 추가](https://github.com/user-attachments/assets/c0c09271-55f4-42b9-b526-1dcc5e102e32)

> 📎 [샘플 로고 이미지 다운로드](https://github.com/codefactory-co/flutter-lv1-inflearn-v2/blob/main/section_6_splash_screen/splash_screen/asset/img/logo.png)

### 3️⃣ pubspec.yaml 설정

**`pubspec.yaml` 파일에 assets 경로 추가**

```yaml
# 참고: https://docs.flutter.dev/ui/assets/assets-and-images#specifying-assets

flutter:
  assets:
    - res/imgs/  # 이미지 폴더 경로 추가
```

![pubspec 설정](https://github.com/user-attachments/assets/58863003-d5a3-4d5e-91cd-30da3457cd36)

### 4️⃣ 패키지 업데이트

**상단의 `Pub get` 버튼 클릭**

![Pub get](https://github.com/user-attachments/assets/4396ec79-dea9-43b1-bcda-96ea2b52880e)

#### ✅ 성공 확인
- `Process finished with exit code 0` → **정상**
- 다른 숫자 코드 → **오류 발생**

## 🎨 Image 위젯 활용하기

### 기본 사용법

```dart
// 등록된 에셋 이미지 사용
Image.asset('res/imgs/logo.png')
```

### Image 위젯의 다양한 생성자

| 생성자 | 용도 | 예시 |
|--------|------|------|
| `Image.asset()` | 앱 내 리소스 이미지 | `Image.asset('assets/logo.png')` |
| `Image.network()` | 인터넷 URL 이미지 | `Image.network('https://...')` |
| `Image.file()` | 로컬 파일 이미지 | `Image.file(File('/path/to/image'))` |
| `Image.memory()` | 메모리의 바이트 데이터 | `Image.memory(uint8list)` |

### 실제 사용 예시

```dart
// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.blue,
      body: Image.asset('res/imgs/logo.png'),
    ),
  ));
}
```

## 🏗️ StatelessWidget 이해하기

### 💡 React와의 비교
> **React**: `useState`를 사용하지 않는 컴포넌트  
> **Flutter**: 내부 상태 변화가 없는 위젯

### StatelessWidget 특징
- **불변(Immutable)** 위젯
- `build()` 메서드 **필수 구현**
- 성능상 **Hot Reload** 지원

### 기본 구조

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Image.asset('res/imgs/logo.png'),
    );
  }
}
```

### 🚀 코드 스니펫 활용

**`stless` 입력 후 엔터**

![코드 스니펫1](https://github.com/user-attachments/assets/24671eba-775d-4b7a-84b0-9a4ba0455302)
![코드 스니펫2](https://github.com/user-attachments/assets/6e618085-a8e6-413a-91f6-9c1728c65171)
![코드 스니펫3](https://github.com/user-attachments/assets/0e239b4a-8b2e-48d3-b8c0-78bc5443e643)

### StatelessWidget 사용의 장점

1. **코드 재사용성** 향상
2. **Hot Reload** 지원으로 개발 속도 향상
3. **컴포넌트 단위** 관리 가능

## 🔥 Hot Reload vs Hot Restart

| 구분 | Hot Reload | Hot Restart |
|------|------------|-------------|
| **실행 범위** | `build()` 메서드만 재실행 | `main()` 함수부터 전체 재실행 |
| **속도** | 빠름 ⚡ | 상대적으로 느림 |
| **상태 유지** | 기존 상태 유지 | 모든 상태 초기화 |
| **사용 시기** | UI 변경 시 | 전체 로직 변경 시 |

## 🎯 레이아웃 위젯 활용하기

### 1️⃣ Padding 위젯

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.0), // 좌우 48px 여백
        child: Image.asset('res/imgs/logo.png'),
      ),
    );
  }
}
```

**EdgeInsets 주요 메서드**
- `EdgeInsets.all(16.0)` - 모든 방향 동일한 여백
- `EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0)` - 대칭 여백
- `EdgeInsets.only(top: 10.0, left: 20.0)` - 특정 방향만 여백

### 2️⃣ Column 위젯

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Image.asset('res/imgs/logo.png'),
          ),
        ],
      ),
    );
  }
}
```

**MainAxisAlignment 옵션**
- `MainAxisAlignment.start` - 시작점 정렬
- `MainAxisAlignment.center` - 중앙 정렬
- `MainAxisAlignment.end` - 끝점 정렬
- `MainAxisAlignment.spaceBetween` - 균등 분배

### 3️⃣ SizedBox 위젯

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Image.asset('res/imgs/logo.png'),
          ),
          SizedBox(height: 32.0), // 세로 간격 32px
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
```

**SizedBox 활용법**
- `SizedBox(height: 20.0)` - 세로 간격
- `SizedBox(width: 20.0)` - 가로 간격
- `SizedBox.square(dimension: 50.0)` - 정사각형 영역

> 💡 **성능 팁**: `Padding` 대신 `SizedBox`를 사용하는 것이 `const` 최적화에 더 유리합니다.

### 4️⃣ CircularProgressIndicator 위젯

```dart
CircularProgressIndicator(
  color: Colors.white,        // 색상 변경
  strokeWidth: 4.0,          // 두께 조절
  backgroundColor: Colors.grey, // 배경색 설정
)
```

## 🛠️ Context Actions 편의 기능

### 사용법
1. **위젯 선택** 후 **우클릭**
2. **Show Context Actions** 선택
3. 또는 **단축키** 사용 (Alt + Enter / Option + Enter)

![Context Actions](https://github.com/user-attachments/assets/03ac81a3-838e-4f54-8f2c-65631d360e22)

### 주요 기능들

| 기능 | 설명 |
|------|------|
| **Remove this widget** | 위젯 제거 |
| **Wrap with widget** | 다른 위젯으로 감싸기 |
| **Extract widget** | 별도 위젯으로 분리 |
| **Move up/down** | 위젯 순서 변경 |

![위젯 제거](https://github.com/user-attachments/assets/ded3022f-d68e-4844-a094-0dca9a5f1fb5)

### 🔧 Context Actions 활성화

**만약 작동하지 않는다면:**

1. **Settings** → **Editor** → **Intentions**
2. **Flutter 관련 옵션들 체크**
3. **OK** 또는 **Apply** 클릭

![설정 활성화](https://github.com/user-attachments/assets/8d5c01f2-c8f5-408b-820a-cdaa678d6572)

## 🎨 완성된 Splash Screen 코드

```dart
// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 로고 이미지
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Image.asset('res/imgs/logo.png'),
          ),
          
          // 간격
          SizedBox(height: 32.0),
          
          // 로딩 인디케이터
          CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
```

## 📋 체크리스트

- [ ] 이미지 리소스 폴더 생성
- [ ] `pubspec.yaml`에 assets 경로 추가
- [ ] `Pub get` 실행 및 성공 확인
- [ ] `StatelessWidget` 구조 이해
- [ ] `Image.asset()` 사용법 숙지
- [ ] 레이아웃 위젯들 조합 연습
- [ ] Context Actions 기능 활용
