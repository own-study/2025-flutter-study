# Slpash Screen
## 이미지 리소스 등록

> 💡 요약
> 
> 프로젝트 폴더 (루트가 아니여도 됨) 안에 아무폴더를 만들어서 이미지 리소스를 집어 넣는다.
>
> [링크](https://docs.flutter.dev/ui/assets/assets-and-images#specifying-assets)를 참고하여 pubspec.yaml 파일 수정하여 이미지가 있는 폴더 등록 후 상단에 Pub get 클릭
>
> 클릭 후 Process finished with exit code 0 뜨면 정상 그 외 숫자가 뜨면 비정상


### 1. 프로젝트 이름에 마우스 오른쪽 클릭 → New → Directory (or Folder)
![image](https://github.com/user-attachments/assets/74bb9c1b-b312-4223-8a34-5c65ab37b71d)
### 2. 원하는 이름의 폴더 생성
![image](https://github.com/user-attachments/assets/a0936e0a-7ad4-4db2-9863-45e7eb41e231)  
작성자는 `res` 폴더 생성후 그 안에 `imgs` 폴더를 생성하여 `res/imgs` 경로를 만듦<br/><br/>
![image](https://github.com/user-attachments/assets/85a02ee1-5471-4e01-be23-8260423bb5ae)
### 3. 생성한 폴더 안에 이미지 넣기
![image](https://github.com/user-attachments/assets/c0c09271-55f4-42b9-b526-1dcc5e102e32) [이미지 리소스](https://github.com/codefactory-co/flutter-lv1-inflearn-v2/blob/main/section_6_splash_screen/splash_screen/asset/img/logo.png)
### 4. `pubspec.yaml` 파일 아래와 같은 코드 추가
```yaml
# 참고자료: https://docs.flutter.dev/ui/assets/assets-and-images#specifying-assets

flutter:
  assets:
    - res/imgs/
```
yaml key `flutter` → `assets` 에 문자열 배열 값 추가<br/><br/>
**실제 코드 예시**<br/>
![image](https://github.com/user-attachments/assets/58863003-d5a3-4d5e-91cd-30da3457cd36)  

### 5. 파일 수정 화면상 상단에 `Pub get` 버튼 클릭
![image](https://github.com/user-attachments/assets/4396ec79-dea9-43b1-bcda-96ea2b52880e)

## Widget 활용
### Image
```dart
// 등록된 에셋상의 이미지 리소스 사용시 경로를 정확하게 입력하여 사용
Image.asset('res/imgs/logo.png')

// 실사용 ---------------------------------------
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
**그 외 참고**
- [Image.new](https://api.flutter.dev/flutter/widgets/Image/Image.html), for obtaining an image from an [ImageProvider](https://api.flutter.dev/flutter/painting/ImageProvider-class.html).
- [Image.asset](https://api.flutter.dev/flutter/widgets/Image/Image.asset.html), for obtaining an image from an [AssetBundle](https://api.flutter.dev/flutter/services/AssetBundle-class.html) using a key.
- [Image.network](https://api.flutter.dev/flutter/widgets/Image/Image.network.html), for obtaining an image from a URL.
- [Image.file](https://api.flutter.dev/flutter/widgets/Image/Image.file.html), for obtaining an image from a [File](https://api.flutter.dev/flutter/dart-io/File-class.html).
- [Image.memory](https://api.flutter.dev/flutter/widgets/Image/Image.memory.html), for obtaining an image from a [Uint8List](https://api.flutter.dev/flutter/dart-typed_data/Uint8List-class.html).

**Reference**  
[Image class - widgets library - Dart API](https://api.flutter.dev/flutter/widgets/Image-class.html)

### StatelessWidget
> 💡 React로 비유하면 해당 컴포넌트 내에서는 상태변화가 없는 즉 useState 를 쓰지 않는 컴포넌트
> 
> 단. 하위 컴포넌트가 상태 변경으로 인한 리렌더링이 들어가는 경우는 알수 없음 당장의 해당 컴포넌트를 상속 받은 컴포넌트만 상태 변경이 없다고 보면 됨.


해당 위젯을 상속받아 사용시 `Widget build(BuildContext context)` 라는 메소드를 무조건 구현 해야함.  
**예시**  
![image](https://github.com/user-attachments/assets/0d3c5005-c44a-4e9a-aac9-a0302e036531)
![image](https://github.com/user-attachments/assets/486253ed-62b1-4224-b011-aed557f37738)
> Create 1 missing override 클릭 하여 자동완성도 가능

![image](https://github.com/user-attachments/assets/70dcc505-4ed8-421f-b067-5c41f925ceb5)

`Widget`을 Return(반환) 하는 형태이니 `MaterialApp` → `home:` 에 작성된 `Scaffold(...)` 이하 코드를 잘라내어 붙여 넣기
```dart
// 클래스명도 Foo 에서 의미가 있는 이름으로 변경
// Foo -> HomeScreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Image.asset('res/imgs/logo.png'),
    );
  }
}


// 실사용 ---------------------------------------
// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen ... (이하 생략)
```

코드 스니펫으로 간단하고 빠르게 구현

`stless` 라는 코드 작성시 스니펫창이 뜨면서 목록에 해당하는 것을 포커스 후 엔터
![image](https://github.com/user-attachments/assets/24671eba-775d-4b7a-84b0-9a4ba0455302)  
![image](https://github.com/user-attachments/assets/6e618085-a8e6-413a-91f6-9c1728c65171)  
![image](https://github.com/user-attachments/assets/0e239b4a-8b2e-48d3-b8c0-78bc5443e643)  
입력 커서가 클래스명을 작성 바로 작성 할 수 있게 안내  

별도의 컴포넌트(위젯)으로 묶어서 활용시 장점들

- 반복되는 코드들을 하나의 클래스 위젯으로 묶을 수 있다.
- 기존에 `main` 을 변경하여 UI 변경시 `Flutter Hot Restart` 대신 `Flutter Hot Reload` 사용 가능

`Flutter Hot Restart` 와 `Flutter Hot Reload` 차이점  
`Flutter Hot Restart` 는 main 부터 다시 실행되는 것으로 보여짐  
`Flutter Hot Reload` 는 `runApp` 함수로 실행된 이하 컴포넌트들의 `Widget build(BuildContext context)` 의 호출만 다시 되는것으로 보임

속도적으로 `main` 처음 부터 시작하는거 보다 `Widget build(BuildContext context)` 의 호출만 되는 것이 이득

**이유.** 해당 컴포넌트들이 재생성되는 것이 아니라 해당 `build` 메서드 및 그 외 관련된 것들을 프레임워크가 호출하는 것으로 보여짐 (추가적인 정보 필요)

## 그 외 Widget
### Padding
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
	      // padding 필드 필수
        padding: EdgeInsets.symmetric(horizontal: 48.0),
        child: Image.asset('res/imgs/logo.png'),
      ),
    );
  }
}
```
**Reference**  
[Padding class - widgets library - Dart API](https://api.flutter.dev/flutter/widgets/Padding-class.html)

**EdgeInsets Reference**  
[EdgeInsets class - painting library - Dart API](https://api.flutter.dev/flutter/painting/EdgeInsets-class.html)

### Column
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
	      // EdgeInsets 같이 범용적으로 사용하는 특수한 것이 아닌 경우
	      // 대부분 필드명 맨앞 글자 대문자로 바꾸면 enum 으로 정의된 값들이 존재
        mainAxisAlignment: MainAxisAlignment.center, // 세로(메인축) 중앙정렬
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
**Reference**  
[Column class - widgets library - Dart API](https://api.flutter.dev/flutter/widgets/Column-class.html)

### SizedBox
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(...),
          SizedBox(height: 32.0),
          SizedBox.square(dimension: 64.0, child: ColoredBox(color: Colors.black))
        ],
      ),
    );
  }
}
```
어떤 이유인지 `Padding`을 쓰는 거보다 영역을 차지 하는 게 좀 더 효율적이라고 강의 내용에서 소개  
관련된 내용은 `const` 와 연관이 있다고 언급

**Reference**  
[SizedBox class - widgets library - Dart API](https://api.flutter.dev/flutter/widgets/SizedBox-class.html)

### CircularProgressIndicator
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(...),
          SizedBox(height: 32.0),
          CircularProgressIndicator(color: Colors.white), // 로딩 UI
        ],
      ),
    );
  }
}
```
**Reference**  
[CircularProgressIndicator class - material library - Dart API](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html)

## [편의성] Show Context Actions 기능
> 아무 기본 제공 Widget(사진 예시는 `Padding`)들 중에
>
> 마우스 오른쪽 클릭 → `Show Context Actions` 선택
>
> 또는 단축키 활용

![image](https://github.com/user-attachments/assets/03ac81a3-838e-4f54-8f2c-65631d360e22)
> 디자이너의 요구로 인해 `Padding` 을 제거 해야한다.
>
> `Remove this widget` 선택

![image](https://github.com/user-attachments/assets/ded3022f-d68e-4844-a094-0dca9a5f1fb5)

### 미작동시
`Settings` → `Editor` → `Intentions` 에서 사진과 같이 체크 표시 후 `OK` 또는 `Apply`
![image](https://github.com/user-attachments/assets/8d5c01f2-c8f5-408b-820a-cdaa678d6572)
