var firebaseConfig = {
    apiKey: "AIzaSyBUFarAIUCHFdR-pIrYGaTNJC43CpFBZZA",
    authDomain: "maskproject-6e385.firebaseapp.com",
    databaseURL: "https://maskproject-6e385.firebaseio.com",
    projectId: "maskproject-6e385",
    storageBucket: "maskproject-6e385.appspot.com",
    messagingSenderId: "759315784284",
    appId: "1:759315784284:web:f7c963bac46cd7798cbc99",
    measurementId: "G-B4436TDC82"
  };
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();

    var firebaseEmailAuth; //파이어베이스 email 인증 모듈 전역변수
  var firebaseDatabase; //파이어베이스 db 모듈 전역변수
  var userInfo; //가입한 유저의 정보. object 타입


  firebaseEmailAuth = firebase.auth(); //파이어베이스 인증 객체
  firebaseDatabase = firebase.database(); //파이어베이스 데이터베이스 객체


      //유저가 로그인 했는지 안했는지 확인해주는 함수
      function userSessionCheck() {

        //로그인이 되어있으면 - 유저가 있으면, user를 인자값으로 넘겨준다.
        firebaseEmailAuth.onAuthStateChanged(function (user) {

          if (user) {


              //자바스크립트 dom 선택자를 통해서 네비게이션 메뉴의 엘리먼트 변경해주기
            document.getElementById("id").textContent = user.email+" 님이 로그인했습니다.";

              //alert(userInfo.userid);  //uid는 db에서 user 테이블의 각 개체들의 pk 인데, 이 값은 인증에서 생성된 아이디의 pk 값과 같다. *중요!

              return true;
            }
          });
      }
