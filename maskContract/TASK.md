1. 유통정보 불러오기

- startMaskDeal(), stopMaskDeal() => 판매정보가 dealInfos에 저장

ex)
* A 제조사 -> B 유통사

dealinfos {
    예상 유통지 = B 유통사
    실제 유통지 = " "
    판매 가격 = 1000000
}

* B 유통사 -> C 유통사

dealinfos {
    예상 유통지 = B 유통사, C 유통사
    실제 유통지 = B 유통사, " "
    판매 가격 = 1000000, 2000000
}

* C 유통사 -> D 약국 

dealinfos {
    예상 유통지 = B 유통사, C 유통사, D 약국
    실제 유통지 = B 유통사, C 유통사, " "
    판매 가격 = 1000000, 2000000, 3000000
}

유통정보가 모두 저장되어 있지만 배열, 구조체로 저장되어 있어 반환할 수 없음
(You cannot return some types from non-internal functions, notably multi-dimensional dynamic arrays and structs.)


2. ERC721 - NFT

A제조사, B제조사, C제조사에서 마스크 생산

A maskMasking -> NFT1 mask
B maskMasking -> NFT2 mask
C maskMasking -> NFT3 mask

세 곳의 제조사로부터 D 유통사가 마스크를 구매

dealMask(A, D, NFT1) ...
dealMask(B, D, NFT2) ...
dealMask(C, D, NFT3) ...

========= D 유통사 창고 ============
NFT1 mask, ... , ... , ...
NFT2 mask, ... , ...
NFT3 mask, ...
===================================

>> D 유통사의 총 재고량 = NFT1 mask + NFT2 mask + NFT3 mask 총량
>> 여러 종류의 마스크(토큰)를 관리하는 법 필요


3. 














!! 제한/요구사항 및 추가해야 하는 기능 적어주세용
