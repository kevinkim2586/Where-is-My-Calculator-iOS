# My 계산기 🧮
![icon2](https://user-images.githubusercontent.com/44637101/115650264-dd9bd800-a363-11eb-949a-fb8ae31fd6b2.png)
### App Store 에서 최신 버전을 다운받을 수 있습니다. [My 계산기](https://apps.apple.com/kr/app/my%EA%B3%84%EC%82%B0%EA%B8%B0/id1562660543?l=en)


## 💡 무슨 앱이야?

** 간단하고 깔끔한 계산기 모음 앱 (6종 계산기) **

- **일반 계산기**
- **단위** 계**산기**
- **금 시세 계산기**
- **할인 계산기**
- **환율 계산기**
- **학점 계산기**

## ❓ 왜 만들었어?

- iOS & Swift 공부를 시작한지 한 달째 되던 무렵, 간단한거 ***뭐라도 좀 만들어봐야*** 실력이 늘 것 같았다. Swift 문법 책을 아무리 봐도, 정작 "앱 개발"을 해보지 않으면 실력이 안 늘 것을 알기에, 도전해보게 되었다.
 
- 그래서 첫 앱으로 어떤 것을 만들면 좋을까 생각하다가 ***계산기*** 를 생각하게 되었다.

- 다만 그냥 일반 계산기만 있으면 식상하니까, " ***계산기 모음*** " 컨셉으로 가고자 했다. 어떤 계산기를 추가로 넣으면 좋을까 생각하다 바로바로 떠올릴 수 있는 대표적인 계산기 (~~금 빼고~~) 총 6개를 탑재하게 됐다.

- 비록 앱이 독창적이지 않고, 자잘한 오류가 좀 있지만, 개발을 바닥부터 시작해서 이렇게 앱 하나를 100% 완성했다는 데에 너무 뿌듯했다.

## 🌄 스크린샷 (GIF 파일)

![](https://images.velog.io/images/kevinkim2586/post/e6a509a7-fd68-47d4-97c4-8722b13403f6/Mar-25-2021%2014-28-09.gif)
![](https://images.velog.io/images/kevinkim2586/post/1a71c3cf-e2ef-4053-bb16-46fe7fa054ad/Mar-25-2021%2014-28-22.gif)
![](https://images.velog.io/images/kevinkim2586/post/cab55443-9edf-45bd-9cc2-2caf5bdd92b3/Mar-25-2021%2014-28-29.gif)
![](https://images.velog.io/images/kevinkim2586/post/238bf651-3c98-42bb-8353-c7bf31688709/Mar-25-2021%2014-28-35.gif)
![](https://images.velog.io/images/kevinkim2586/post/32e74b20-d5a4-481b-8497-c545f17e4cb9/Mar-25-2021%2014-28-44.gif)
![](https://images.velog.io/images/kevinkim2586/post/599cfc5d-533a-4d10-874c-dc7d60cdfe19/Mar-25-2021%2014-28-50.gif)





## 📌 배운 점

---

✅  **MVC 디자인 패턴 적용** 

→ 처음으로 디자인 패턴이라는 것을 사용해 본 프로젝트다. (~~그러나 완성해놓고보니 MVC 는 곧 Massive View Controller라는 것을 깨달았다..~~)

✅  **User Defaults 사용법**

→ 학점 계산기는 값을 저장해야 하기 때문에 User Defaults를 이용해 유저 입력값을 저장할 수 있었다.

✅  **Delegate Design Pattern**

→ View Controller와 Model의 통신을 위해서 Delegate 패턴을 사용했습니다.

✅  **HTTP 통신**

→ Alamofire를 이용해서 다양한 API 호출 (ex. 금 시세, 환율 정보 등)




































