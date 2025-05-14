# Row & Column

### Row

- 특별한 제한사항이 없다면 가로 축 최대 크기 차지 세로축 최소 크기 차지

### MainAxisAlignment 속성

- start, end, center, spaceBetween, spaceAround, spaceEvenly가 있고 css의 flex justify-[...] 속성과 유사
- spaceAround와 spaceEvenly의 차이는 여백을 어떤 기준으로 만드느냐의 차이

### MainAxisSize 속성

- 해당 Row 또는 Column의 가로 또는 세로의 너비를 결정하는 속성

### CrossAxisAlignment 속성

- start, end, center, stretch, baseline가 있고 css의 flex items-[...] 속성과 유사

### SafeArea 위젯

- 과거 스마트폰 스크린이 모두 정사각형 당시에는 문제 없었으나 스마트폰 베젤이 최소화 되면서 모서리가 둥근 형태가 되어 SystemUI를 피해서 안전영역을 잡는 작업이 필요해짐

### Expanded 위젯

- Row나 Column에서 남은 공간은 모두 차지하고 만약 여러개를 사용하면 남는 공간을 같은 비율로 나눠 갖는다.
- flex라는 파라미터를 갖으며 수만큼 비율을 차지한다(예: 3개의 Expanded에서 첫번째만 flex:2를 넣으면 남는공간을 2배로 차지) - 기본값은 1

### Flexible 위젯

- fit 파라미터를 조절하여 실제 flexible 위젯이 차지하는 크기만큼 내부 위젯이 차지하도록 하는지 여부 결정(fit: FlexFit.loose ot FlexFit.fit)
