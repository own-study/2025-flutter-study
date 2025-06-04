# StatefulWidget

## 📋 개요

Flutter에서 UI를 구성하는 두 가지 기본 위젯인 `StatelessWidget`과 `StatefulWidget`의 차이점

## 🔍 기본 개념 비교

### Widget
- **불변(Immutable)**

### StatelessWidget
- 한 번 생성되면 상태가 변경되지 않음
- `build()` 메서드가 한 번만 호출됨
- React의 **Pure Component**와 유사

### StatefulWidget
- 내부 상태가 변경될 수 있음
- `setState()` 호출 시 `build()` 메서드가 재호출됨
- React의 **useState Hook을 사용하는 Component**와 유사

## ⚛️ React와의 비교

```javascript
// React Pure Component (StatelessWidget과 유사)
const PureComponent = ({ color }) => {
  return <div style={{ backgroundColor: color }}>Static Color</div>;
};

// React useState Component (StatefulWidget과 유사)
const StatefulComponent = () => {
  const [color, setColor] = useState('blue');
  
  const changeColor = () => {
    setColor(color === 'blue' ? 'red' : 'blue'); // 리렌더링 발생
  };
  
  return (
    <div>
      <button onClick={changeColor}>Change Color</button>
      <div style={{ backgroundColor: color }}>Dynamic Color</div>
    </div>
  );
};
```

## 🚫 StatelessWidget의 한계점

### 문제 상황
```dart
class HomeScreen extends StatelessWidget {
  Color color = Colors.blue; // ❌ 변경되어도 UI에 반영되지 않음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  if (color == Colors.blue) {
                    color = Colors.red;
                  } else {
                    color = Colors.blue;
                  }
                  print('Change color: $color'); // 콘솔에는 변경됨
                },
                child: Text('Change color'),
            ),
            SizedBox(height: 32.0),
            Container(
              width: 50.0,
              height: 50.0,
              color: color, // ❌ 화면에는 변경되지 않음
            )
          ],
        ),
      )
    );
  }
}
```

### 🔧 Hot Reload로 확인하기
1. 버튼을 클릭해도 색상이 변경되지 않음
2. **Hot Reload** 버튼(⚡) 클릭 시 변경된 색상이 적용됨
3. 이는 `build()` 메서드가 다시 호출되기 때문

## ✅ StatefulWidget으로 해결

```dart
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color color = Colors.blue; // ✅ 상태로 관리

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  if (color == Colors.blue) {
                    color = Colors.red;
                  } else {
                    color = Colors.blue;
                  }
                  print('Change color: $color');
                  setState(() {}); // ✅ UI 업데이트 트리거
                },
                child: Text('Change color'),
              ),
              SizedBox(height: 32.0),
              Container(
                width: 50.0,
                height: 50.0,
                color: color, // ✅ 즉시 변경됨
              )
            ],
          ),
        )
    );
  }
}
```

## 🔄 setState()의 동작 원리

### setState() 호출 시 발생하는 일
1. **상태 변경** 감지
2. **build() 메서드** 재호출
3. **Widget Tree** 재구성
4. **UI 업데이트** 반영

### 코드 흐름
```dart
setState(() {
  // 상태 변경 로직 (옵션)
}); 
// ↓
// build() 메서드 자동 호출
// ↓  
// UI 리렌더링
```

## 📊 성능 비교

| 구분 | StatelessWidget | StatefulWidget |
|------|-----------------|----------------|
| **메모리 사용량** | 낮음 | 높음 |
| **렌더링 속도** | 빠름 | 상대적으로 느림 |
| **상태 관리** | 불가능 | 가능 |
| **사용 사례** | 정적 UI | 동적 UI |

## 🎯 사용 가이드라인

### StatelessWidget 사용 시기
- 정적인 UI 컴포넌트
- 외부에서 전달받은 데이터만 표시
- 성능이 중요한 단순한 위젯

### StatefulWidget 사용 시기
- 사용자 상호작용이 필요한 경우
- 내부 상태가 변경되어야 하는 경우
- 애니메이션이나 동적 효과가 필요한 경우

## 💡 핵심 포인트

1. **StatelessWidget**은 한 번 그려지면 변경되지 않음
2. **Hot Reload**는 개발 시에만 동작하는 기능
3. **setState()**가 UI 업데이트의 핵심
4. React의 상태 관리 패턴과 매우 유사
5. 적절한 위젯 선택이 성능에 영향을 미침

# 마무리 학습퀴즈 첨부
<details><summary>클릭하여 내용을 확인하세요</summary>
  
### 1. Flutter 위젯 속성이 바뀌면 왜 새 위젯을 만들까요?
1. 불변성 때문
2. 메모리 효율 때문
3. 애니메이션 효과 때문
4. 보안 기능 때문

### 2. 사용자 상호작용 등으로 동적 UI 변화가 필요한 위젯은?
1. Stateless Widget
2. Stateful Widget
3. Immutable Widget
4. Function Widget

### 3. Stateful Widget을 만들 때 일반적으로 정의하는 클래스는 몇 개인가요?
1. 한 개
2. 두 개
3. 세 개
4. 필요한 만큼 자유롭게

### 4. Stateful Widget에서 내부 상태가 변경되어 UI 업데이트가 필요함을 알리는 함수는?
1. `updateState()`
2. `build()`
3. `setState()`
4. `refresh()`

### 5. Stateful Widget의 State 클래스에서 `setState()` 함수를 호출하면 주로 어떤 일이 발생하나요?
1. 위젯이 삭제됨
2. build 함수가 다시 실행
3. 앱이 재시작
4. 메모리가 초기화
</details>
