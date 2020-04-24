
//주민번호 뒷자리 xxxxx로 바꿔주는 함수
function civilNumberEncode(num){
  //8번부터 13번까지 변경
  var tmp = num;
  return tmp.substr(0, 8) + "xxxxxx";
}
