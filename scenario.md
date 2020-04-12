4.18 컨트랙트 작성완료
~25 다 합치기
마스크 500개 => 1box로 정의 요기서 한개 두개로 하면 백엔드에서 *500개 처리함

0. 마스크 struct
	구조체
	- 제조사에서 만들어준 SerialNum => timestamp
	- 제조사
	- 예상 유통사
	- 실제 유통사
	- 예상 판매사
	- 실제 판매사
	0.1 마스크 생성시 제조사 와 serialNum 입력되어야함.
		+파라미터 : SerialNum, 제조사ID
		+변수 :
		+컨트랙함수 : ~~createMask(string _SerialNum, string _makerId)~~ => startMaskMaking(uint256 _MaskQuantity)
		+이벤트 : 마스크 구조체 생성
		+기타 : 제조사에서 요 함수를 쓰면될듯
		
	0.2 SerialNum에 맞는 마스크 찾아서 리턴해줘야함.
		+파라미터 : SerialNum
		+변수 :
		+컨트랙함수 : ~~getMaskInfo(string _SerialNum)~~ =>
				getManufacturerName()
				getMaskProductionDate(uint256 _index)
				getMaskProductionAddr(uint256 _index)
				getMaskQuantity(address _manufacturerAddr)
		+이벤트 : ~~마스크 구조체 변수들 다 리턴해주기~~ =? 각각 함수별 리턴
		+기타 : 
	
1. 제조사(maker)
	구조체
	- makerId(ex.001) 첫째자리 0으로시작 
	- 일일 마스크 생산량 => 타
	- 보유중인 마스크 serialNum 배열 -> 재고량 배열크기로 체크하면될듯
	
	1.0. 제조사 정보 리턴
		파라미터 : makerId,
		변수 :  
        컨트랙함수 : getMakerInfo(string makerId)
        이벤트 : 구조체 변수들 리턴
		기타 : 
		
	1.1. 1box 제조시 시리얼번호를 부여한다.(시리얼 = timestamp)
        파라미터 : SerialNum(배열일 수 있음), 제조할 box개수,
		변수 :  
        컨트랙함수 : createMaskbox(string[] _SerialNumArray)
        이벤트 : 파라미터로 받은 배열의 SerialNum들과 makerId를 이용해 마스크구조체 생성, SerialNumArray들 마스크재고배열에 추가
		리턴 : 
		기타 : 웹에서 시리얼번호 쏴주기
        
	1.2. 박스 단위로 유통사와 계약한다.
		파라미터 : 마스크 시리얼넘버 배열, 계약할 유통사, 계약할 box 개수
        변수 : 
        컨트랙함수 : contractTodealer(string[] _SerialNumArray, string dealerID)
        이벤트 : 마스크 구조체에 예상 유통사 추가하고 제조사 마스크재고배열에서 SerialNumArray들 뺀다.
		리턴 : SerialNumArray 리턴해야할듯.
        
	1.3.(보류) 유통사로 물류 이동과정을 명시한다. (택배 추적 시스템)//??(잘 모르겠음)
        변수 : 운송장번호, 개수
        컨트랙함수 : 
        이벤트 : 


2. 유통사(dealer)
	구조체
	- dealerId(ex.10A) 첫째자리 1로 시작
	- 일일 마스크 수입량(이것도 고민중)
	- 소유중인 마스크 serialNum 배열

	2.0. 유통사 정보 리턴
		파라미터 : dealerId,
		변수 :  
        컨트랙함수 : getdealerInfo(string dealerId)
        이벤트 : 
		기타 : 
	2.1. 제조사로부터 납품받은 마스크 처리
		파라미터 : SerialNumArray
        변수 : 
        컨트랙함수 : addMaskBox(string[] SerialNumArray)
        이벤트 : SerialNumArray를 마스크 재고 배열에 추가
        
	2.2. 박스 단위로 판매점에 납품
		파라미터 : 마스크 serialNum 배열, 계약할 판매사, 계약할 box 개수
        변수 : 
        컨트랙함수 : contractToseller(string[] _SerialNumArray, string dealerId)
        이벤트 : 마스크 구조체에 계약할 판매사 ID를 예상 판매사에 넣어주고 SerialNumArray들 마스크재고배열에서 삭제.

    
3. 판매사(seller)
	구조체
	- sellerId(ex.20A) 첫째자리 2로시작
	- 일일 마스크 수입량(이것또한)
	- 소유중인 마스크 serialNum배열
	- 마스크 serialNum별 재고량(여기서는 들어온 박스*500해서 표시하고 serialNum별로 재고체크하는게 어떨까)
	123412424152 - 500
	125125151251 - 499
	
	
	3.0. 판매사 정보 리턴
		파라미터 : sellerId,
		변수 :  
        컨트랙함수 : getsellerInfo(string sellerId)
        이벤트 : 
		기타 : 
	3.1. 납품받은 박스들 처리
		파라미터 : SerialNumArray
        변수 : 
        컨트랙함수 : addMask(string[] SerialNumArray)
        이벤트 : SerialNumArray를 마스크 재고 배열에 추가(이 함수는 유통사랑 같이써도될듯)
	
	3.2. 판매
		파라미터 : serialNum
		변수 :  
        컨트랙함수 : sellMask(string serialNum)
        이벤트 : serialNum에 해당하는 배열 재고량 -1 
		기타 : 

추가 필요한 함수들 : 
1. 실제, 예상 비교
2. 법적근거 체크
