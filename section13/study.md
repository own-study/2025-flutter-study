# Flutter Widget Life Cycle 완전 가이드

## 📚 학습 목표

이번 실습을 통해 다음 개념들을 익혀보겠습니다:

- **Widget Life Cycle** 전체 흐름 이해
- **StatelessWidget vs StatefulWidget** 생명주기 차이점
- **State 객체**의 생성부터 소멸까지 과정
- **setState()** 호출 시 내부 동작 원리
- **부모-자식 위젯** 간 생명주기 상호작용

## 🔄 Widget Life Cycle 개요

### StatelessWidget 생명주기

```
생성자 → build()
```

**특징:**
- 매우 단순한 구조
- 상태 변화 없음
- 성능상 유리

### StatefulWidget 생명주기

```
StatefulWidget: 생성자 → createState()
State<T>: initState() → didChangeDependencies() → dirty → build() → clean → deactivate() → dispose()
```

## 🏗️ StatefulWidget 생명주기 상세 분석

### 1️⃣ 초기 생성 단계

| 순서 | 메서드 | 호출 시점 | 특징 |
|------|--------|-----------|------|
| 1 | **생성자** | 위젯 인스턴스 생성 시 | 한 번만 호출 |
| 2 | **createState()** | State 객체 생성 시 | 한 번만 호출 |
| 3 | **initState()** | State 객체 초기화 시 | 한 번만 호출, context 사용 불가 |
| 4 | **didChangeDependencies()** | 의존성 변경 시 | 여러 번 호출 가능, context 사용 가능 |

### 2️⃣ 렌더링 단계

| 상태 | 설명 | 접근 가능 여부 |
|------|------|----------------|
| **dirty** | build() 실행이 필요한 상태 | ❌ 내부적으로만 관리 |
| **build()** | UI 구성 요소 반환 | ✅ 직접 구현 |
| **clean** | build() 실행 완료 상태 | ❌ 내부적으로만 관리 |

### 3️⃣ 소멸 단계

| 순서 | 메서드 | 호출 시점 |
|------|--------|-----------|
| 6 | **deactivate()** | 위젯 트리에서 제거 직전 |
| 7 | **dispose()** | State 객체 완전 소멸 시 |

## 🔄 setState() 동작 원리

### setState() 호출 시 흐름

```
clean 상태 → setState() 호출 → dirty 상태 → build() 실행 → clean 상태
```

### 부모 위젯 setState() 영향

**중요한 특징:**
- 부모에서 `setState()` 호출 시 자식 위젯의 **생성자**는 다시 호출됨
- 하지만 `createState()`는 **재호출되지 않음**
- 대신 `didUpdateWidget()` 호출 후 dirty 상태로 변경

## 🛠️ 실습 환경 준비

### 기본 셋팅 코드

```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (show) MyWidget(),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  show = !show;
                });
              },
              child: Text('show/hide'),
            )
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: Colors.red,
    );
  }
}
```

## 🧪 실습 1: 기본 생명주기 확인

### 목표
> StatefulWidget의 전체 생명주기 흐름을 콘솔 로그로 확인하기

### 실습 코드

```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = false; // 🔥 false로 변경

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (show) MyWidget(),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  show = !show;
                });
              },
              child: Text('show/hide'),
            )
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  MyWidget({super.key}) {
    print('1) StatefulWidget 생성자 호출'); // 🔥 추가
  }

  @override
  State<MyWidget> createState() {
    print('2) StatefulWidget createState() 호출'); // 🔥 추가
    return _MyWidgetState();
  }
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    print('3) State initState() 호출'); // 🔥 추가
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('4) State didChangeDependencies() 호출'); // 🔥 추가
    super.didChangeDependencies();
  }

  // 5.1) dirty 상태 (내부적으로 관리)

  @override
  Widget build(BuildContext context) {
    print('5) State build() 호출'); // 🔥 추가
    return Container(
      width: 50.0,
      height: 50.0,
      color: Colors.red,
    );
  }

  // 5.2) clean 상태 (내부적으로 관리)

  @override
  void deactivate() {
    print('6) State deactivate() 호출'); // 🔥 추가
    super.deactivate();
  }

  @override
  void dispose() {
    print('7) State dispose() 호출'); // 🔥 추가
    super.dispose();
  }
}
```

### 🔍 실습 1 결과 분석

**show/hide 버튼 첫 번째 클릭 시:**
```
1) StatefulWidget 생성자 호출
2) StatefulWidget createState() 호출
3) State initState() 호출
4) State didChangeDependencies() 호출
5) State build() 호출
```

**show/hide 버튼 두 번째 클릭 시:**
```
6) State deactivate() 호출
7) State dispose() 호출
```

## 🧪 실습 2: setState() 내부 동작 확인

### 목표
> 위젯 내부에서 setState() 호출 시 생명주기 변화 관찰하기

### 실습 코드

```dart
class _MyWidgetState extends State<MyWidget> {
  Color color = Colors.red; // 🔥 추가

  @override
  void initState() {
    print('3) State initState() 호출');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('4) State didChangeDependencies() 호출');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('5) State build() 호출');
    return GestureDetector( // 🔥 추가
      onTap: () {
        setState(() {
          color = color == Colors.red ? Colors.blue : Colors.red;
        });
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: color, // 🔥 변경
      ),
    );
  }

  @override
  void deactivate() {
    print('6) State deactivate() 호출');
    super.deactivate();
  }

  @override
  void dispose() {
    print('7) State dispose() 호출');
    super.dispose();
  }
}
```

### 🔍 실습 2 결과 분석

**빨간 박스 탭 시:**
```
5) State build() 호출
```

**핵심 포인트:**
- `initState()`나 `didChangeDependencies()`는 **재호출되지 않음**
- `setState()` 호출 시 **build()만 다시 실행**
- dirty → build() → clean 사이클 반복

## 🧪 실습 3: 부모-자식 위젯 상호작용

### 목표
> 부모 위젯의 상태 변경이 자식 위젯 생명주기에 미치는 영향 확인하기

### 실습 코드

```dart
class _HomeScreenState extends State<HomeScreen> {
  bool show = false;
  Color color = Colors.red; // 🔥 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (show) GestureDetector( // 🔥 수정
              onTap: () {
                setState(() {
                  color = color == Colors.blue ? Colors.red : Colors.blue;
                });
              },
              child: MyWidget(color: color), // 🔥 수정
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  show = !show;
                });
              },
              child: Text('show/hide'),
            )
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final Color color; // 🔥 추가

  MyWidget({
    super.key,
    required this.color, // 🔥 추가
  }) {
    print('1) StatefulWidget 생성자 호출');
  }

  @override
  State<MyWidget> createState() {
    print('2) StatefulWidget createState() 호출');
    return _MyWidgetState();
  }
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    print('3) State initState() 호출');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('4) State didChangeDependencies() 호출');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MyWidget oldWidget) { // 🔥 추가
    print('📝 State didUpdateWidget() 호출');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('5) State build() 호출');
    return Container(
      width: 50.0,
      height: 50.0,
      color: widget.color, // 🔥 수정
    );
  }

  @override
  void deactivate() {
    print('6) State deactivate() 호출');
    super.deactivate();
  }

  @override
  void dispose() {
    print('7) State dispose() 호출');
    super.dispose();
  }
}
```

### 🔍 실습 3 결과 분석

**첫 번째 show 버튼 클릭:**
```
1) StatefulWidget 생성자 호출
2) StatefulWidget createState() 호출
3) State initState() 호출
4) State didChangeDependencies() 호출
5) State build() 호출
```

**박스 탭 시 (색상 변경):**
```
1) StatefulWidget 생성자 호출
📝 State didUpdateWidget() 호출
5) State build() 호출
```

**핵심 발견:**
- 부모에서 `setState()` 호출 시 자식의 **생성자는 재호출**됨
- 하지만 `createState()`는 **호출되지 않음**
- 대신 `didUpdateWidget()` 호출 후 `build()` 실행

## 🔧 Context Actions로 위젯 변환하기

### StatelessWidget ↔ StatefulWidget 변환

1. **위젯 클래스명에 커서** 위치
2. **우클릭** → **Show Context Actions**
3. **Convert to StatefulWidget** 또는 **Convert to StatelessWidget** 선택

![Context Actions](https://github.com/user-attachments/assets/03ac81a3-838e-4f54-8f2c-65631d360e22)

### 변환 시 자동 생성되는 코드

**StatelessWidget → StatefulWidget:**
```dart
// 변환 전
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// 변환 후
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

## 📊 생명주기 메서드 비교표

| 메서드 | 호출 횟수 | Context 사용 | 주요 용도 |
|--------|-----------|--------------|-----------|
| **생성자** | 1회 | ❌ | 초기 설정 |
| **createState()** | 1회 | ❌ | State 객체 생성 |
| **initState()** | 1회 | ❌ | 초기화 로직 |
| **didChangeDependencies()** | 다수 | ✅ | 의존성 변경 처리 |
| **build()** | 다수 | ✅ | UI 구성 |
| **didUpdateWidget()** | 다수 | ✅ | 위젯 업데이트 처리 |
| **deactivate()** | 1회 | ✅ | 정리 작업 준비 |
| **dispose()** | 1회 | ❌ | 리소스 해제 |

## 🎯 핵심 포인트 정리

### 1️⃣ 생명주기 이해의 중요성
- **메모리 관리**: dispose()에서 리소스 해제
- **성능 최적화**: 불필요한 rebuild 방지
- **상태 관리**: 적절한 시점에 상태 업데이트

### 2️⃣ setState() 최적화
```dart
// ❌ 비효율적
setState(() {
  // 복잡한 계산
  heavyCalculation();
});

// ✅ 효율적
final result = heavyCalculation();
setState(() {
  // 단순한 상태 업데이트만
  value = result;
});
```

### 3️⃣ 부모-자식 관계 주의사항
- 부모의 `setState()`는 자식의 생성자를 재호출
- 불필요한 재생성을 방지하려면 `const` 생성자 활용
- `Key`를 활용한 위젯 식별 최적화

## 🚀 실무 활용 팁

### 1️⃣ 리소스 관리
```dart
class _MyWidgetState extends State<MyWidget> {
  late Timer timer;
  
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 주기적 작업
    });
  }
  
  @override
  void dispose() {
    timer.cancel(); // 🔥 반드시 정리
    super.dispose();
  }
}
```

### 2️⃣ 성능 최적화
```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key}); // 🔥 const 생성자
  
  @override
  State<MyWidget> createState() => _MyWidgetState();
}
```

### 3️⃣ 디버깅 활용
```dart
@override
void didUpdateWidget(MyWidget oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.data != widget.data) {
    print('데이터가 변경되었습니다: ${widget.data}');
  }
}
```

# 마무리 학습퀴즈 첨부
<details><summary>클릭하여 내용을 확인하세요</summary>
  
### 1. StatelessWidget이 화면에 표시될 때 일반적인 초기 함수 실행 순서는 무엇일까요?
1. Build -> Constructor
2. Constructor -> Build
3. initState -> Build
4. Constructor만 실행

### 2. StatefulWidget이 처음 생성되어 화면에 표시될 때, State 객체의 초기화 및 빌드까지의 올바른 함수 실행 순서는 무엇일까요?
1. createState -> initState -> build
2. initState -> didChangeDependencies -> build
3. Constructor -> createState -> initState -> didChangeDependencies -> build
4. createState -> didChangeDependencies -> build

### 3. StatefulWidget의 State 내에서 `setState()` 함수를 호출하는 주된 목적은 무엇일까요?
1. 새로운 State 객체를 생성합니다.
2. 해당 State를 'dirty' 상태로 만들고 Build 메소드 재실행을 유도합니다.
3. didUpdateWidget 함수를 호출합니다.
4. dispose 함수를 즉시 호출합니다.

### 4. 부모 위젯으로부터 새로운 데이터를 받아 StatefulWidget이 재빌드될 때, 기존 State 객체가 유지된다면 Constructor 실행 후에 어떤 함수가 호출될까요?
1. createState
2. initState
3. didUpdateWidget
4. build

### 5. StatefulWidget의 State가 위젯 트리에서 제거될 때 호출되는 함수 순서는 일반적으로 무엇일까요?
1. deactivate -> dispose
2. dispose만 실행
3. deactivate만 실행
4. initState, dispose
</details>
