# 🎯Project Convention

### 목차
1. [📢 공지사항](#공지사항)
2. [🎫 Issue 사용법](#issue-사용법)
3. [🌿 Branch 사용법](#branch-사용법)
4. [📝 커밋 규칙](#커밋-규칙)
5. [🔄 풀 리퀘스트(PR) 가이드라인](#풀-리퀘스트pr-가이드라인)
6. [⌨️ 코딩 규칙](#코딩-규칙)
7. [🏷️ 네이밍 규칙](#네이밍-규칙)
8. [🗂️ 디렉토리 구조 규칙](#디렉토리-구조-규칙)
9. [💻 Git Workflow](#Git-Workflow)
10. [👥 Git Project](#Git-Project)
- [Credit The Light and Salt, "Celan"](https://github.com/ValseLee)

## 공지사항

1. Github webhook이 연동되었습니다.
    - 여러분의 Push, Pull Request, Issue 등의 작업 내용이 github에 접수되면 곧바로 discord의 깃허브 채널에서 확인할 수 있습니다.
2. 작업을 위한 뼈대 파일이 main 브랜치에 추가되었습니다.
    - 작업을 하기 위해, 각자의 작업 폴더에 git clone 명령어를 통해 레포지토리를 복사하신 후 사용하실 수 있습니다.
    - 물론 그 전에 Issue 와 Branch 사용법을 익혀 봅시다.

## Issue 사용법

- 이슈는 현재 Template이 있습니다. Github 상단의 Issue 탭에서 생성하거나 삭제, 수정이 가능합니다.
- 각 이슈는 번호를 갖고 있습니다. 이 번호를 "이슈 넘버"라고 합니다.
- 하나의 이슈는 "하나의 큰 작업"을 의미합니다. 휴식회사™에서 의미하는 하나의 큰 작업은 대략 100 ~ 500줄 정도의 수정을 의미합니다.
- Assignees에는 본인을 태그하며, Label은 약식으로 Feat, Bug 등 여러 라벨 중, 하나를 골라서 진행합니다.

### ✍️ 이슈 작성 예시

```markdown
제목: [Feat] MainRecordView에서 말하는 사람을 바꾸기 위한 슬라이드를 구현합니다.

본문:
📝 작업 목적
MainRecordView에서 말하는 사람을 바꿀 수 있도록 슬라이드 구현

🛠️ Tasks
- [ ] 할일 1
- [ ] 할일 2
    - [ ] 할일 2의 서브 태스크
```

## Branch 사용법
- Branch: dev를 제외한 모든 브랜치는 하나의 혹은 2개 이상의 Issue에 의해 생성되어야 합니다.
- 각 작업 사항을 작성한 Issue에서 branch를 분기합니다.

### 🌿 브랜치 생성 예시
```markdown
Feat/#325-Record-Implement-Slider
```

## 커밋 규칙
- 간단하게 머릿말은 4개정도 쓰겠습니다.
```markdown
[Feat/#이슈번호] 구현된 기능
[Add/#이슈번호] 추가한 "파일"
[Remove/#이슈번호] 제거한 "파일"
[Chore/#이슈번호] 기타
```
💡 pbxproj 파일은 꼭 맨 마지막에 커밋 해주세요!

## 풀 리퀘스트(PR) 가이드라인
PR은 해결하려는 이슈에 연결되어야 합니다.
리포지토리에 제공된 PR 템플릿을 사용하세요.
PR은 병합하기 전에 적어도 한 명 이상의 다른 팀원이 검토해야 합니다.
PR을 병합하기 전에 병합 충돌이 해결되어야 합니다.
PR이 UI 변경과 관련된 경우 PR에 스크린샷을 포함하세요.

```markdown
제목: [Feat/#IssueNumber] 특정 기능 구현

설명:
이 PR은 다음을 구현하여 #IssueNumber 문제를 해결합니다:
- 기능 구현 1
- 기능 2 추가
- 제거된 파일

스크린샷:
스크린샷: [해당되는 경우, 문제를 설명하는 데 도움이 되는 스크린샷을 추가하세요.]
```

## 코딩 규칙
- 코드 가독성을 우선시합니다. 약어 대신 명확한 단어를 사용하고 축약어 대신 완전한 단어를 사용하세요.
- 클래스, 구조체, 확장, 프로토콜 등의 정의의 시작과 끝에는 한 줄을 비워둡니다.
- 임포트 문이 여러 개 있는 경우 알파벳 순서로 정렬하세요.
- 코드에는 필요한 경우 주석을 추가하여 코드의 기능을 설명하거나, 이해하기 어려운 로직에 대한 설명을 추가하세요.
- 동일한 코드를 여러 번 작성하는 대신 함수나 클래스 등을 작성하여 코드를 재사용하고, 모듈화하세요.
- 변수는 값이 변할 수 있고, 상수는 한 번 할당되면 변경할 수 없습니다. 가능하면 상수를 사용하고, 필요한 경우에만 변수를 사용하세요.

### ⌨️ 코드 가독성 예시
```swift
let n = "Tom" // 이름을 나타내는 변수에 'n'이라는 적합하지 않은 약어를 사용했습니다.
let name = "Tom" // 'name'이라는 완전한 단어를 사용하여 변수의 목적을 명확히 표현했습니다.
```
```swift
//클래스, 구조체, 확장, 프로토콜 등의 정의의 시작과 끝에는 한 줄을 비워둡니다.

// 잘못된 예시
class MyClass {
    var name: String
    init(name: String) {
        self.name = name
    }
}class AnotherClass {
    var id: Int
    init(id: Int) {
        self.id = id
    }
}

// 올바른 예시
class MyClass {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class AnotherClass {
    var id: Int

    init(id: Int) {
        self.id = id
    }
}
```

```swift
// 임포트 문이 여러 개 있는 경우 알파벳 순서로 정렬하세요.

// 잘못된 예시
import UIKit
import Alamofire
import Foundation

// 올바른 예시
import Alamofire
import Foundation
import UIKit
```
### ⌨️ 주석 예시
```swift
// 이 함수는 주어진 두 수의 합을 반환합니다.
func add(a: Int, b: Int) -> Int {
    return a + b
}
```

### ⌨️ 모듈화(코드 재사용) 예시
```swift
// 재사용할 수 있는 함수
func printGreeting(name: String) {
    print("Hello, \(name)!")
}
```

### ⌨️ 변수와 상수 예시
```swift
let constantValue = 10 // 이 값은 변경할 수 없습니다.
var variableValue = 20 // 이 값은 변경할 수 있습니다.
```
💡 커밋 전, cmd+a -> ctl + i 를 통해 코드 포맷(자동정렬)을 꼭 적용해주세요!

## 네이밍 규칙
- 명확하고 직관적인 이름을 사용하세요. 이름은 변수, 함수, 클래스 등이 무엇을 하는지 알 수 있어야 합니다.
- 일반적으로 알려진 이름이 아니라면 모호한 이름이나 약어를 사용하지 마세요.
- 변수와 함수 이름은 소문자(camelCase), 클래스 및 구조체 이름은 대문자(PascalCase)로 시작합니다.

### 🏷️ 네이밍 예시
```swift
var itemCount: Int
func calculateSum() {}
class ItemList {}
```

## 디렉토리 구조 규칙
- 관련 파일을 디렉터리로 그룹화합니다.
- 디렉터리에는 명확하고 설명이 포함된 이름을 사용하세요.
- 가능한 한 평평한 구조를 따르세요. 디렉터리가 3단계 이상 중첩되지 않도록 하세요.

## Git Workflow
<img width="690" alt="Screenshot 2023-07-10 at 8 15 34 PM" src="https://github.com/DeveloperAcademy-POSTECH/MC3-Team12-BreakCompany/assets/36729917/66efc12c-4369-4b48-ae3b-017352bc5231">

- 우리는 워크플로우를 위해 Git Flow 전략에서 약간의 변형된 형태를 사용합니다.
- master(main) 브랜치는 HEAD의 소스 코드가 항상 다음 릴리스를 위해 전달된 최신 개발 변경 사항이 있는 상태를 반영하는 주요 브랜치입니다.
- develop 브랜치는 개발이 완료된 최신 브랜치 입니다. 주로 개발된 내역이 병합되는 브랜치에 해당합니다.
- 모든 개발 작업은 develop 브랜치에서 분기된 feature 브랜치에서 이루어져야 합니다.
- 기능이 완료되면 풀 리퀘스트를 통해 develop 브랜치에 다시 병합해야 합니다.
- main 브랜치는 최종 릴리즈 또는 중간 스프린트 이후 반영합니다.

## Git Project
- 우리는 에자일 및 스크럼 개발 프로세스를 실현하고 일정, 작업 항목, 버그 등을 효과적으로 추적하고 관리하기위해, Jira, Confluence 등과 비교해 보다 쉽게 접근이 가능한, Github의 Project 기능을 사용합니다.

💡 사진의 예시는 Github Project의 간략한 형태를 표현하기 위한 예시입니다. 작업 제목과 이슈 및 세부내용은 팀 협업을 위해선, 상세하고 쉽게 이해되도록 작성되어야합니다!

| | |
|-|-|
|![image](https://github.com/hhajime/test/assets/36729917/ee96621d-fc3b-4ff2-9b18-3c6c20d74f10) | ![image](https://github.com/hhajime/test/assets/36729917/9beacf07-8835-40cc-9e52-e941bef82541) |
| **1. KhanBan Board:** 프로젝트 보드는 카드 및 칼럼을 포함하여 프로젝트의 전반적인 진행 상황을 시각화하는 장소입니다. 일반적으로 각 칼럼은 작업의 특정 단계 (예: Todo, In Progress, Done)를 나타내며, 각 카드는 작업 항목을 나타냅니다. 카드는 다른 칼럼으로 드래그 앤 드롭하여 진행 상황을 업데이트할 수 있습니다. | **2. Cards:** 카드는 프로젝트 보드에서 작업 항목을 나타냅니다. 각 카드는 이슈 또는 풀 리퀘스트를 나타냅니다. 카드에는 작업 항목에 대한 세부 사항, 관련 작업자, 라벨 등을 포함할 수 있습니다. |
|![image](https://github.com/hhajime/test/assets/36729917/ca97262b-0c72-4a7b-9e5a-47ce1f782422) | ![image](https://github.com/hhajime/test/assets/36729917/249d15d5-978e-4bd5-b7d6-f09fcc85083a) |
| **3. Projects Board:** 칼럼형태의 리스트는 프로젝트 내용의 주요 정보에 집중합니다. 각 프로젝트 리스트는 카드와 타임라인의 모든 정보를 포함하고 있으며, 해당 리스트를 클릭시 보드의 카드 클릭과 같은 화면을 확인 할 수 있습니다. | **4. Project Timelines(Milestones):** 각 프로젝트 보드에 대한 타임라인을 생성하여 스프린트 기간 동안의 작업을 계획하고 관리합니다. 이 타임라인은 스프린트 시작 및 종료 날짜, 중요한 이벤트 및 마일스톤 등을 시각화하는 데 사용합니다. |
