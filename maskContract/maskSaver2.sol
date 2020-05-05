pragma solidity ^0.5.0;

// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v2.3.0/contracts/utils/Address.sol
/**
 * @dev 주소 타입과 관련된 함수의 모음,
 */
library Address {
    /**
     * @dev 만일 `account` 가 컨트랙트라면 참(true)를 반환합니다.
     *
     * 이 테스트는 불완전하며, false-negatives가 있을 수 있습니다:
     * 컨트랙트의 생성자를 실행하는 중, 주소는 컨트랙트를 포함하지
     * 않은 것으로 보고될 것입니다.
     *
     * > 이 함수가 거짓(false)을 반환하는 주소가 외부 소유 계정(EOA)
     * 이며 컨트랙트가 아니라고 가정하는 것은 확실하지 않습니다.
     */
    function isContract(address account) internal view returns (bool) {
        // 코드는 생성자 실행이 완료되고 나서 저장되므로, 생성 중인
        // 컨트랙트에 대해 0을 반환하는 extcodesize에
        // 의존합니다.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v2.3.0/contracts/math/SafeMath.sol
/**
 * @dev 오버플로우 검사를 포함한 솔리디티의 산술 연산에 대한
 * 래퍼입니다.
 *
 * 솔리디티의 산술 연산은 오버플로우됩니다. 프로그래머는 일반적으로
 * 고수준 프로그래밍 언어의 일반적인 동작인 오버플로우가 에러를 발생시키는 것
 * 으로 가정하기 때문에, 이는 버그의 결과일 수 있습니다.
 * `SafeMath`는 연산이 오버플로우될 때 트랜잭션을 되돌려
 * 직관적으로 복원합니다.
 *
 * 확인되지 않은 연산 대신에 이 라이브러리를 사용하면 
 * 버그가 제거되므로, 항상 사용하는 것이 좋습니다.
 */
library SafeMath {
    /**
     * @dev 부호 없는 정수 두 개를 더한 값을 반환하고, 오버플로우를
     * 예외처리합니다.
     *
     * 솔리디티의 `+` 연산자를 대체합니다.
     *
     * 요구사항:
     * - 덧셈은 오버플로우될 수 없습니다.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev 두 부호 없는 정수의 차를 반환합니다.
     * 결과가 음수일 경우 오버플로우입니다.
     *
     * 솔리디티의 `-` 연산자를 대체합니다.
     *
     * 요구사항:
     * - 뺄셈은 오버플로우될 수 없습니다.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev 두 부호 없는 정수의 곱을 반환합니다.
     * 오버플로우 발생 시 예외처리합니다.
     *
     * 솔리디티의 `*` 연산자를 대체합니다.
     *
     * 요구사항:
     * - 곱셈은 오버플로우될 수 없습니다.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // 가스 최적화: 이는 'a'가 0이 아님을 요구하는 것보다 저렴하지만,
        // 'b'도 테스트할 경우 이점이 없어집니다.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev 두 부호 없는 정수의 몫을 반환합니다. 0으로 나누기를 시도할 경우
     * 예외처리합니다. 결과는 0의 자리에서 반올림됩니다.
     *
     * 솔리디티의 `/` 연산자를 대체합니다. 참고: 이 함수는
     * `revert` 명령코드(잔여 가스를 건들지 않음)를 사용하는 반면, 솔리디티는
     * 유효하지 않은 명령코드를 사용해 복귀합니다(남은 모든 가스를 소비).
     *
     * 요구사항:
     * - 0으로 나눌 수 없습니다.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // 솔리디티는 0으로 나누기를 자동으로 검출하고 중단합니다.
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // 이를 만족시키지 않는 경우가 없어야 합니다.

        return c;
    }

    /**
     * @dev 두 부호 없는 정수의 나머지를 반환합니다. (부호 없는 정수 모듈로 연산),
     * 0으로 나눌 경우 예외처리합니다.
     *
     * 솔리디티의 `%` 연산자를 대체합니다. 이 함수는 `revert`
     * 명령코드(잔여 가스를 건들지 않음)를 사용하는 반면, 솔리디티는
     * 유효하지 않은 명령코드를 사용해 복귀합니다(남은 모든 가스를 소비).
     *
     * 요구사항:
     * - 0으로 나눌 수 없습니다.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}

// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v2.3.0/contracts/drafts/Counters.sol
/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev 오직 1씩만 증가 또는 감소할 수 있는 카운터(counter)를 제공합니다. 이는 가령 매핑의 원소 수 추적,
 * ERC721 ID 발행, 또는 요청 ID 개수를 세는 데 사용할 수 있습니다.
 *
 * `using Counters for Counters.Counter;`으로 포함시킵니다.
 * 1씩 증가시키는 것으로 256 bit 정수를 오버플로우 시킬 수 없으므로, `increment`는 SafeMath
 * 오버플로우 체크를 스킵하고, 가스를 절약할 수 있습니다. 그러나 이는 기본적으로 `_value`가 직접 액세스되지 않는다는 가정하에 올바른 사용을 상정하고 있습니다.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // 이 변수는 라이브러리의 사용자로부터 직접 액세스되어서는 안 됩니다: 상호작용은 라이브러리의 함수들로만
        // 제한되어져야 합니다. 솔리디티 v0.5.2부터, 비록 이 기능을 추가하는 제안이 있지만, 이는 강제될 수 없습니다:
        // https://github.com/ethereum/solidity/issues/4637를 참조하세요.
        uint256 _value; // 기본값: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

library ObjectLib {

  using SafeMath for uint256;
  enum Operations { ADD, SUB, REPLACE }
  // Constants regarding bin or chunk sizes for balance packing
  uint256 constant TYPES_BITS_SIZE   = 16;                     // Max size of each object
  uint256 constant TYPES_PER_UINT256 = 256 / TYPES_BITS_SIZE; // Number of types per uint256


  //
  // Objects and Tokens Functions
  //

  /**
  * @dev Return the bin number and index within that bin where ID is
  * @param _tokenId Object type
  * @return (Bin number, ID's index within that bin)
  */
  function getTokenBinIndex(uint256 _tokenId) internal pure returns (uint256 bin, uint256 index) {
     bin = _tokenId * TYPES_BITS_SIZE / 256;
     index = _tokenId % TYPES_PER_UINT256;
     return (bin, index);
  }


  /**
  * @dev update the balance of a type provided in _binBalances
  * @param _binBalances Uint256 containing the balances of objects
  * @param _index Index of the object in the provided bin
  * @param _amount Value to update the type balance
  * @param _operation Which operation to conduct :
  *     Operations.REPLACE : Replace type balance with _amount
  *     Operations.ADD     : ADD _amount to type balance
  *     Operations.SUB     : Substract _amount from type balance
  */
  function updateTokenBalance(
    uint256 _binBalances,
    uint256 _index,
    uint256 _amount,
    Operations _operation) internal pure returns (uint256 newBinBalance)
  {
    uint256 objectBalance;
    if (_operation == Operations.ADD) {

        objectBalance = getValueInBin(_binBalances, _index);
        newBinBalance = writeValueInBin(_binBalances, _index, objectBalance.add(_amount));

    } else if (_operation == Operations.SUB) {

        objectBalance = getValueInBin(_binBalances, _index);
        newBinBalance = writeValueInBin(_binBalances, _index, objectBalance.sub(_amount));

    } else if (_operation == Operations.REPLACE) {

        newBinBalance = writeValueInBin(_binBalances, _index, _amount);

    } else {
      revert("Invalid operation"); // Bad operation
    }

    return newBinBalance;
  }
  /*
  * @dev return value in _binValue at position _index
  * @param _binValue uint256 containing the balances of TYPES_PER_UINT256 types
  * @param _index index at which to retrieve value
  * @return Value at given _index in _bin
  */
  function getValueInBin(uint256 _binValue, uint256 _index) internal pure returns (uint256) {

    // Mask to retrieve data for a given binData
    uint256 mask = (uint256(1) << TYPES_BITS_SIZE) - 1;

    // Shift amount
    uint256 rightShift = 256 - TYPES_BITS_SIZE * (_index + 1);
    return (_binValue >> rightShift) & mask;
  }

  /**
  * @dev return the updated _binValue after writing _amount at _index
  * @param _binValue uint256 containing the balances of TYPES_PER_UINT256 types
  * @param _index Index at which to retrieve value
  * @param _amount Value to store at _index in _bin
  * @return Value at given _index in _bin
  */
  function writeValueInBin(uint256 _binValue, uint256 _index, uint256 _amount) internal pure returns (uint256) {
    require(_amount < 2**TYPES_BITS_SIZE, "Amount to write in bin is too large");

    // Mask to retrieve data for a given binData
    uint256 mask = (uint256(1) << TYPES_BITS_SIZE) - 1;

    // Shift amount
    uint256 leftShift = 256 - TYPES_BITS_SIZE * (_index + 1);
    return (_binValue & ~(mask << leftShift) ) | (_amount << leftShift);
  }
}

/**
 * @dev [EIP](https://eips.ethereum.org/EIPS/eip-165)에 정의된
 * ERC165 표준의 인터페이스입니다.
 *
 * 구현체는 지원하는 컨트랙트 인터페이스를 선언할 수 있으며, 
 * 외부에서 (`ERC165Checker`) 이 함수를 호출해 지원 여부를 조회할 수 있습니다.
 *
 * 구현에 대해서는 `ERC165`를 참조하세요.
 */
interface IERC165 {
    /**
     * @dev 만일 컨트랙트가 `interfaceId`로 정의된 인터페이스를 구현했으면,
     * 참(true)을 반환합니다. ID 생성 방법에 대한 자세한 내용은 해당
     * [EIP section](https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified)
     * 을 참조하세요.
     *
     * 이 함수 호출은 30000 가스보다 적게 사용할 것입니다.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

/**
 * @dev `IERC165` 인터페이스의 구현체.
 *
 * 컨트랙트는 이를 상속받을 수 있으며 `_registerInterface`를 호출해 인터페이스 지원을
 * 선언할 수 있습니다.
 */
contract ERC165 is IERC165 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /**
     * @dev 지원 여부에 대한 인터페이스 ID의 매핑
Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // 파생된 컨트랙트는 고유한 인터페이스에 대한 지원만 등록하면 됩니다.
        // ERC165 자체에 대한 지원만 여기에서 등록합니다.
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev `IERC165.supportsInterface`를 참조하세요.
     *
     * 시간 복잡도는 O(1)이며, 항상 30000 가스 미만을 사용하도록 보장합니다.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev 컨트랙트가 `interfaceId`로 정의한 인터페이스를 구현했음을
     * 등록합니다. 실제 ERC165 인터페이스의 지원은 자동으로 되며
     * 이 인터페이스 ID의 등록은 필요하지 않습니다.
     *
     * `IERC165.supportsInterface`를 참조하세요.
     *
     * 요구사항:
     *
     * - `interfaceId`는 ERC165 유효하지 않은 인터페이스(`0xffffffff`)일 수 없습니다.
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

/**
 * @dev ERC721 호환 컨트랙트의 필수 인터페이스
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev `owner` 계정의 NFT의 개수를 반환합니다.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev `tokenId`에 의해 명시된 NFT의 소유자를 반환합니다.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev 특정 NFT (`tokenId`)를 한 계정(`from`)에서
     * 다른 계정(`to`)으로 전송합니다.
     *
     * 
     *
     * 요구사항:
     * - `from`, `to`는 0일 수 없습니다.
     * - `tokenId`는 `from`이 소유하고 있어야 합니다.
     * - 만일 호출자가 `from`이 아니라면, `approve` 또는
     * `setApproveForAll`를 통해 이 NFT의 전송을 허가받았어야 합니다.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public;
    /**
     * @dev 특정 NFT (`tokenId`)를 한 계정 (`from`)에서
     * 다른 계정(`to`)으로 전송합니다.
     *
     * 요구사항:
     * - 만일 호출자가 `from`이 아니라면, `approve` 또는
     * `setApproveForAll`를 통해 이 NFT를 전송을 허가받았어야 합니다.
     */
    function transferFrom(address from, address to, uint256 tokenId) public;
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
} 

// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v2.3.0/contracts/token/ERC721/IERC721Receiver.sol
/**
 * @title ERC721 토큰 수신자 인터페이스
 * @dev ERC721 자산 컨트랙트로부터 safeTransfers를 지원하고 싶은
 * 컨트랙트를 위한 인터페이스입니다.
 */
contract IERC721Receiver {
    /**
     * @notice NFT 수신 처리
     * @dev ERC721 스마트 컨트랙트는 `safeTransfer` 후 수신자가 구현한
     * 이 함수를 호출합니다. 이 함수는 반드시 함수 선택자를 반환해야 하며,
     * 그렇지 않을 경우 호출자는 트랜잭션을 번복할 것입니다. 반환될 선택자는
     * `this.onERC721Received.selector`로 얻을 수 있습니다. 이 함수는
     * 전송을 번복하거나 거절하기 위해 예외를 발생시킬 수도 있습니다.
     * 참고: ERC721 컨트랙트 주소는 항상 메시지 발신자입니다.
     * @param operator `safeTransferFrom` 함수를 호출한 주소
     * @param from 이전에 토큰을 소유한 주소
     * @param tokenId 전송하고자 하는 NFT 식별자
     * @param data 특별한 형식이 없는 추가적인 데이터
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
}

// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v2.3.0/contracts/token/ERC721/ERC721.sol
contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`와 동일
    // `IERC721Receiver(0).onERC721Received.selector`로부터 얻을 수도 있습니다
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // 토큰 ID에서 소유자로의 매핑
    mapping (uint256 => address) private _tokenOwner;

    // 토큰 ID에서 승인된 주소로의 매핑
    mapping (uint256 => address) private _tokenApprovals;

    // 소유자에서 소유한 토큰 개수로의 매핑
    mapping (address => Counters.Counter) private _ownedTokensCount;

    // 소유자에서 운영자(operator) 승인 여부로의 매핑
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    constructor () public {
        // ERC165를 통해 ERC721을 준수하도록 지원되는 인터페이스를 등록하세요
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    /**
     * @dev 명시한 주소의 잔액을 얻습니다.
     * @param owner 잔액을 요청하는 주소
     * @return uint256 전달받은 주소가 보유한 수량
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev 명시된 토큰 ID의 소유자를 얻습니다.
     * @param tokenId uint256 소유자를 요청하는 토큰의 ID
     * @return address 주어진 토큰 ID의 현재 표시된 소유자
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");

        return owner;
    }

    /**
     * @dev 주어진 토큰 ID의 전송을 다른 주소에게 허가합니다.
     * 영(zero) 주소는 승인된 주소가 없음을 나타냅니다.
     * 한 번에 하나의 승인된 주소만 있을 수 있습니다.
     * 토큰 소유자나 승인된 운영자만이 호출할 수 있습니다.
     * @param to address 주어진 토큰 ID에 대해 승인할 주소
     * @param tokenId uint256 승인하고자 하는 토큰 ID
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev 토큰 ID에 대해 승인된 주소를, 만일 설정된 주소가 없으면 0을 얻습니다.
     * 만일 토큰 ID가 존재하지 않는 경우 되돌려집니다.
     * @param tokenId uint256 승인된 주소를 요청하는 토큰의 ID
     * @return address 주어진 토큰 ID에 대해 현재 승인된 주소
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev 주어진 운영자의 승인을 설정 또는 해제합니다.
     * 운영자는 발신자를 대신해 모든 토큰을 전송할 수 있도록 허가되었습니다.
     * @param to 승인을 설정하고자 하는 운영자의 주소
     * @param approved 설정하고자 하는 승인의 상태를 나타냅니다
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "ERC721: approve to caller");

        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    /**
     * @dev 주어진 소유자에 대해 운영자가 승인되었는지 여부를 말해줍니다.
     * @param owner 승인을 조회하고자 하는 소유자 주소
     * @param operator 승인을 조회하고자 하는 운영자 주소
     * @return bool 주어진 운영자가 주어진 소유자로부터 승인되었는지 여부
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev 주어진 토큰 ID의 소유권을 다른 주소로 전송합니다.
     * 이 메소드는 사용하지 않는 것이 좋습니다. 가능하다면 `safeTransferFrom`을 사용하세요.
     * msg.sender는 소유자, 승인된 주소, 또는 운영자여야 합니다.
     * @param from 토큰의 현재 소유자
     * @param to 주어진 토큰 ID의 소유권을 받을 주소
     * @param tokenId 전송할 토큰의 uint256 ID
     */
    function transferFrom(address from, address to, uint256 tokenId) public {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev 주어진 토큰 ID의 소유권을 다른 주소로 안전하게 전송합니다.
     * 만일 목표 주소가 컨트랙트라면, 컨트랙트는 `onERC721Received`를 구현했어야만 합니다.
     * 이는 안전한 전송으로부터 호출되며 마법의 값
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`를 반환합니다;
     * 만일 다른 경우에는 전송이 되돌려집니다.
     * msg.sender는 소유자, 승인된 주소, 운영자여야 합니다
     * @param from 토큰의 현재 소유자
     * @param to 주어진 토큰 ID의 소유권을 받을 주소
     * @param tokenId 전송할 토큰의 uint256 ID
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev 주어진 토큰 ID의 소유권을 다른 주소로 안전하게 전송합니다.
     * 만일 목표 주소가 컨트랙트라면, 컨트랙트는 `onERC721Received`를 구현했어야만 합니다.
     * 이는 안전한 전송으로부터 호출되며 마법의 값
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`를 반환합니다;
     * 만일 다른 경우에는 전송이 되돌려집니다.
     * msg.sender는 소유자, 승인된 주소, 운영자여야 합니다
     * @param from 토큰의 현재 소유자
     * @param to 주어진 토큰 ID의 소유권을 받을 주소
     * @param tokenId 전송할 토큰의 uint256 ID
     * @param _data 안전한 전송 검사와 함께 전송하고자 하는 바이트 데이터
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev 지정한 토큰이 존재하는지 여부를 반환합니다.
     * @param tokenId uint256 존재를 조회하고자 하는 토큰의 ID
     * @return bool 토큰의 존재 여부
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev 지정된 납부자가 주어진 토큰 ID를 전송할 수 있는지 여부를 반환합니다.
     * @param spender 조회하고자 하는 납부자의 주소
     * @param tokenId uint256 전송하고자 하는 토큰 ID
     * @return bool msg.sender가 주어진 토큰 ID에 대해 승인되었는지,
     * 운영자인지, 또는 토큰의 소유자인지 여부
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev 새 토큰을 발행하기 위한 내부 함수.
     * 주어진 토큰 ID가 이미 존재하면 되돌립니다.
     * @param to 발행된 토큰을 소유할 주소
     * @param tokenId uint256 발행될 토큰의 ID
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev 특정 토큰을 소각하기 위한 내부 함수.
     * 토큰이 존재하지 않으면 되돌립니다.
     * 더 이상 사용되지 않으며, _burn(uint256)을 대신 사용하세요.
     * @param owner 소각할 토큰의 소유자
     * @param tokenId uint256 소각할 토큰의 ID
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner, "ERC721: burn of token that is not own");

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev 특정 토큰을 소각하기 위한 내부 함수.
     * 토큰이 존재하지 않으면 되돌립니다.
     * @param tokenId uint256 소각할 토큰의 ID
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev 주어진 토큰 ID의 소유권을 다른 주소로 전송하기 위한 내부 함수.
     * transferFrom과 달리, msg.sender에 제한이 없습니다.
     * @param from 토큰의 현재 소유자
     * @param to 주어진 토큰 ID의 소유권을 받고자 하는 주소
     * @param tokenId uint256 전송될 토큰의 ID
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev 목표 주소에서 `onERC721Received`를 호출할 내부 함수.
     * 대상 주소가 컨트랙트가 아닌 경우 호출이 실행되지 않습니다.
     *
     * 이 기능은 더 이상 사용되지 않습니다.
     * @param from 주어진 토큰 ID의 이전 소유자를 나타내는 주소
     * @param to 토큰을 받을 목표 주소
     * @param tokenId uint256 전송될 토큰의 ID
     * @param _data bytes 호출과 함께 전송할 추가 데이터
     * @return bool 호출이 예상한 값(magic value)을 반환했는지 여부
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev 주어진 토큰 ID의 현재 승인을 지우는 개인 함수.
     * @param tokenId uint256 전송할 토큰의 ID
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

contract ERC721XTokenNFT is ERC721 {

    using ObjectLib for ObjectLib.Operations;
    using ObjectLib for uint256;
    using Address for address;

    // bytes4 internal constant InterfaceId_ERC721Enumerable = 0x780e9d63;
    bytes4 internal constant ERC721_RECEIVED = 0x150b7a02;
    bytes4 internal constant InterfaceId_ERC721Metadata = 0x5b5e139f;

    uint256[] internal allTokens;
    mapping(address => mapping(uint256 => uint256)) packedTokenBalance;
    mapping(uint256 => address) internal tokenOwner;
    mapping(address => mapping(address => bool)) operators;
    mapping (uint256 => address) internal tokenApprovals;
    mapping(uint256 => uint256) tokenType;

    uint256 constant NFT = 1;
    uint256 constant FT = 2;

    string baseTokenURI;

    constructor(string memory _baseTokenURI) public {
        baseTokenURI = _baseTokenURI;
        _registerInterface(InterfaceId_ERC721Metadata);
    }

    function name() external view returns (string memory) {
        return "ERC721XTokenNFT";
    }

    function symbol() external view returns (string memory) {
        return "ERC721X";
    }

    /**
     * @dev Returns whether the specified token exists
     * @param _tokenId uint256 ID of the token to query the existence of
     * @return whether the token exists
     */
    function exists(uint256 _tokenId) public view returns (bool) {
        return tokenType[_tokenId] != 0;
    }

    function implementsERC721() public pure returns (bool) {
        return true;
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens
     * @param _index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 _index) public view returns (uint256) {
        require(_index < totalSupply());
        return allTokens[_index];
    }

    /**
     * @dev Gets the owner of a given NFT
     * @param _tokenId uint256 representing the unique token identifier
     * @return address the owner of the token
     */
    function ownerOf(uint256 _tokenId) public view returns (address) {
        require(tokenOwner[_tokenId] != address(0), "Coin does not exist");
        return tokenOwner[_tokenId];
    }

    /**
     * @dev Gets Iterate through the list of existing tokens and return the indexes
     *        and balances of the tokens owner by the user
     * @param _owner The adddress we are checking
     * @return indexes The tokenIds
     * @return balances The balances of each token
     */
    function tokensOwned(address _owner) public view returns (uint256[] memory indexes, uint256[] memory balances) {
        uint256 numTokens = totalSupply();
        uint256[] memory tokenIndexes = new uint256[](numTokens);
        uint256[] memory tempTokens = new uint256[](numTokens);

        uint256 count;
        for (uint256 i = 0; i < numTokens; i++) {
            uint256 tokenId = allTokens[i];
            if (balanceOf(_owner, tokenId) > 0) {
                tempTokens[count] = balanceOf(_owner, tokenId);
                tokenIndexes[count] = tokenId;
                count++;
            }
        }

        // copy over the data to a correct size array
        uint256[] memory _ownedTokens = new uint256[](count);
        uint256[] memory _ownedTokensIndexes = new uint256[](count);

        for (uint256 i = 0; i < count; i++) {
            _ownedTokens[i] = tempTokens[i];
            _ownedTokensIndexes[i] = tokenIndexes[i];
        }

        return (_ownedTokensIndexes, _ownedTokens);
    }

    /**
     *  @dev Gets the number of tokens owned by the address we are checking
     *  @param _owner The adddress we are checking
     *  @return balance The unique amount of tokens owned
     */
    function balanceOf(address _owner) public view returns (uint256 balance) {
        (,uint256[] memory tokens) = tokensOwned(_owner);
        return tokens.length;
    }

    /**
     * @dev return the _tokenId type' balance of _address
     * @param _address Address to query balance of
     * @param _tokenId type to query balance of
     * @return Amount of objects of a given type ID
     */
    function balanceOf(address _address, uint256 _tokenId) public view returns (uint256) {
        (uint256 bin, uint256 index) = _tokenId.getTokenBinIndex();
        return packedTokenBalance[_address][bin].getValueInBin(index);
    }

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    )
        public
    {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    )
        public
    {
        _transferFrom(_from, _to, _tokenId);
        require(
            checkAndCallSafeTransfer(_from, _to, _tokenId, _data),
            "Sent to a contract which is not an ERC721 receiver"
        );
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        _transferFrom(_from, _to, _tokenId);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId)
        internal
    {
        require(tokenType[_tokenId] == NFT);
        require(isApprovedOrOwner(_from, ownerOf(_tokenId), _tokenId));
        require(_to != address(0), "Invalid to address");

        _updateTokenBalance(_from, _tokenId, 0, ObjectLib.Operations.REPLACE);
        _updateTokenBalance(_to, _tokenId, 1, ObjectLib.Operations.REPLACE);

        tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function tokenURI(uint256 _tokenId) public view returns (string memory) {
        require(exists(_tokenId), "Token doesn't exist");
        return string(abi.encodePacked(
            baseTokenURI, 
            uint2str(_tokenId),
            ".json"
        ));
    }

   function uint2str(uint _i) private pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }

        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }

        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }

        return string(bstr);
    }

    /**
     * @dev Internal function to invoke `onERC721Received` on a target address
     * The call is not executed if the target address is not a contract
     * @param _from address representing the previous owner of the given token ID
     * @param _to target address that will receive the tokens
     * @param _tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return whether the call correctly returned the expected magic value
     */
    function checkAndCallSafeTransfer(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    )
        internal
        returns (bool)
    {
        if (!_to.isContract()) {
            return true;
        }
        bytes4 retval = IERC721Receiver(_to).onERC721Received(
            msg.sender, _from, _tokenId, _data
        );
        return (retval == ERC721_RECEIVED);
    }

    /**
     * @dev Will set _operator operator status to true or false
     * @param _operator Address to changes operator status.
     * @param _approved  _operator's new operator status (true or false)
     */
    function setApprovalForAll(address _operator, bool _approved) public {
        // Update operator status
        operators[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param _to address to be approved for the given token ID
     * @param _tokenId uint256 ID of the token to be approved
     */
    function approve(address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);
        require(_to != owner);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender));

        tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    function _mint(uint256 _tokenId, address _to) internal {
        require(!exists(_tokenId), "Error: Tried to mint duplicate token id");
        _updateTokenBalance(_to, _tokenId, 1, ObjectLib.Operations.REPLACE);
        tokenOwner[_tokenId] = _to;
        tokenType[_tokenId] = NFT;
        allTokens.push(_tokenId);
        emit Transfer(address(this), _to, _tokenId);
    }

    function _updateTokenBalance(
        address _from,
        uint256 _tokenId,
        uint256 _amount,
        ObjectLib.Operations op
    )
        internal
    {
        (uint256 bin, uint256 index) = _tokenId.getTokenBinIndex();
        packedTokenBalance[_from][bin] =
            packedTokenBalance[_from][bin].updateTokenBalance(
                index, _amount, op
        );
    }


    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * @param _tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 _tokenId) public view returns (address) {
        return tokenApprovals[_tokenId];
    }

    /**
     * @dev Function that verifies whether _operator is an authorized operator of _tokenHolder.
     * @param _operator The address of the operator to query status of
     * @param _owner Address of the tokenHolder
     * @return A uint256 specifying the amount of tokens still available for the spender.
     */
    function isApprovedForAll(address _owner, address _operator) public view returns (bool isOperator) {
        return operators[_owner][_operator];
    }

    function isApprovedOrOwner(address _spender, address _owner, uint256 _tokenId)
        internal
        view
        returns (bool)
    {
        return (
            _spender == _owner ||
            getApproved(_tokenId) == _spender ||
            isApprovedForAll(_owner, _spender)
        );
    }

    // FOR COMPATIBILITY WITH ERC721 Standard, UNUSED.
    function tokenOfOwnerByIndex(address _owner, uint256 _index) public pure returns (uint256 _tokenId) {_owner; _index; return 0;}
}

contract ERC721X {
  function implementsERC721X() public pure returns (bool);
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
  function balanceOf(address owner) public view returns (uint256);
  function balanceOf(address owner, uint256 tokenId) public view returns (uint256);
  function tokensOwned(address owner) public view returns (uint256[] memory, uint256[] memory);

  function transfer(address to, uint256 tokenId, uint256 quantity) public;
  function transferFrom(address from, address to, uint256 tokenId, uint256 quantity) public;

  // Fungible Safe Transfer From
  function safeTransferFrom(address from, address to, uint256 tokenId, uint256 _amount) public;
  function safeTransferFrom(address from, address to, uint256 tokenId, uint256 _amount, bytes memory data) public;

  // Batch Safe Transfer From
  function safeBatchTransferFrom(address _from, address _to, uint256[] memory tokenIds, uint256[] memory _amounts, bytes memory _data) public;

  function name() external view returns (string memory);
  function symbol() external view returns (string memory);

  // Required Events
  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
  event TransferWithQuantity(address indexed from, address indexed to, uint256 indexed tokenId, uint256 quantity);
  event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
  event BatchTransfer(address indexed from, address indexed to, uint256[] tokenTypes, uint256[] amounts);
}

/**
 * @title ERC721X token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 *  from ERC721X contracts.
 */
contract ERC721XReceiver {
  /**
    * @dev Magic value to be returned upon successful reception of an amount of ERC721X tokens
    *  Equals to `bytes4(keccak256("onERC721XReceived(address,uint256,bytes)"))`,
    *  which can be also obtained as `ERC721XReceiver(0).onERC721XReceived.selector`
    */
  bytes4 constant ERC721X_RECEIVED = 0x660b3370;
  bytes4 constant ERC721X_BATCH_RECEIVE_SIG = 0xe9e5be6a;

  function onERC721XReceived(address _operator, address _from, uint256 tokenId, uint256 amount, bytes memory data) public returns(bytes4);

  /**
   * @dev Handle the receipt of multiple fungible tokens from an MFT contract. The ERC721X smart contract calls
   * this function on the recipient after a `batchTransfer`. This function MAY throw to revert and reject the
   * transfer. Return of other than the magic value MUST result in the transaction being reverted.
   * Returns `bytes4(keccak256("onERC721XBatchReceived(address,address,uint256[],uint256[],bytes)"))` unless throwing.
   * @notice The contract address is always the message sender. A wallet/broker/auction application
   * MUST implement the wallet interface if it will accept safe transfers.
   * @param _operator The address which called `safeTransferFrom` function.
   * @param _from The address from which the token was transfered from.
   * @param _types Array of types of token being transferred (where each type is represented as an ID)
   * @param _amounts Array of amount of object per type to be transferred.
   * @param _data Additional data with no specified format.
   */
  function onERC721XBatchReceived(
          address _operator,
          address _from,
          uint256[] memory _types,
          uint256[] memory _amounts,
          bytes memory _data
          )
      public
      returns(bytes4);
}

// Additional features over NFT token that is compatible with batch transfers
contract ERC721XToken is ERC721X, ERC721XTokenNFT {

    using ObjectLib for ObjectLib.Operations;
    using Address for address;

    bytes4 internal constant ERC721X_RECEIVED = 0x660b3370;
    bytes4 internal constant ERC721X_BATCH_RECEIVE_SIG = 0xe9e5be6a;

    event BatchTransfer(address from, address to, uint256[] tokenTypes, uint256[] amounts);

    constructor(string memory _baseTokenURI) public ERC721XTokenNFT(_baseTokenURI) {}


    modifier isOperatorOrOwner(address _from) {
        require((msg.sender == _from) || operators[_from][msg.sender], "msg.sender is neither _from nor operator");
        _;
    }

    function implementsERC721X() public pure returns (bool) {
        return true;
    }

    /**
     * @dev transfer objects from different tokenIds to specified address
     * @param _from The address to BatchTransfer objects from.
     * @param _to The address to batchTransfer objects to.
     * @param _tokenIds Array of tokenIds to update balance of
     * @param _amounts Array of amount of object per type to be transferred.
     * Note:  Arrays should be sorted so that all tokenIds in a same bin are adjacent (more efficient).
     */
    function _batchTransferFrom(address _from, address _to, uint256[] memory _tokenIds, uint256[] memory _amounts)
        internal
        isOperatorOrOwner(_from)
    {

        // Requirements
        require(_tokenIds.length == _amounts.length, "Inconsistent array length between args");
        require(_to != address(0), "Invalid recipient");

        if (tokenType[_tokenIds[0]] == NFT) {
            tokenOwner[_tokenIds[0]] = _to;
            emit Transfer(_from, _to, _tokenIds[0]);
        }

        // Load first bin and index where the object balance exists
        (uint256 bin, uint256 index) = ObjectLib.getTokenBinIndex(_tokenIds[0]);

        // Balance for current bin in memory (initialized with first transfer)
        // Written with bad library syntax instead of as below to bypass stack limit error
        uint256 balFrom = ObjectLib.updateTokenBalance(
            packedTokenBalance[_from][bin], index, _amounts[0], ObjectLib.Operations.SUB
        );
        uint256 balTo = ObjectLib.updateTokenBalance(
            packedTokenBalance[_to][bin], index, _amounts[0], ObjectLib.Operations.ADD
        );

        // Number of transfers to execute
        uint256 nTransfer = _tokenIds.length;

        // Last bin updated
        uint256 lastBin = bin;

        for (uint256 i = 1; i < nTransfer; i++) {
            // If we're transferring an NFT we additionally should update the tokenOwner and emit the corresponding event
            if (tokenType[_tokenIds[i]] == NFT) {
                tokenOwner[_tokenIds[i]] = _to;
                emit Transfer(_from, _to, _tokenIds[i]);
            }
            (bin, index) = _tokenIds[i].getTokenBinIndex();

            // If new bin
            if (bin != lastBin) {
                // Update storage balance of previous bin
                packedTokenBalance[_from][lastBin] = balFrom;
                packedTokenBalance[_to][lastBin] = balTo;

                // Load current bin balance in memory
                balFrom = packedTokenBalance[_from][bin];
                balTo = packedTokenBalance[_to][bin];

                // Bin will be the most recent bin
                lastBin = bin;
            }

            // Update memory balance
            balFrom = balFrom.updateTokenBalance(index, _amounts[i], ObjectLib.Operations.SUB);
            balTo = balTo.updateTokenBalance(index, _amounts[i], ObjectLib.Operations.ADD);
        }

        // Update storage of the last bin visited
        packedTokenBalance[_from][bin] = balFrom;
        packedTokenBalance[_to][bin] = balTo;

        // Emit batchTransfer event
        emit BatchTransfer(_from, _to, _tokenIds, _amounts);
    }

    function batchTransferFrom(address _from, address _to, uint256[] memory _tokenIds, uint256[] memory _amounts) public {
        // Batch Transfering
        _batchTransferFrom(_from, _to, _tokenIds, _amounts);
    }

    /**
     * @dev transfer objects from different tokenIds to specified address
     * @param _from The address to BatchTransfer objects from.
     * @param _to The address to batchTransfer objects to.
     * @param _tokenIds Array of tokenIds to update balance of
     * @param _amounts Array of amount of object per type to be transferred.
     * @param _data Data to pass to onERC721XReceived() function if recipient is contract
     * Note:  Arrays should be sorted so that all tokenIds in a same bin are adjacent (more efficient).
     */
    function safeBatchTransferFrom(
        address _from,
        address _to,
        uint256[] memory _tokenIds,
        uint256[] memory _amounts,
        bytes memory _data
    )
        public
    {

        // Batch Transfering
        _batchTransferFrom(_from, _to, _tokenIds, _amounts);

        // Pass data if recipient is contract
        if (_to.isContract()) {
            bytes4 retval = ERC721XReceiver(_to).onERC721XBatchReceived(
                msg.sender, _from, _tokenIds, _amounts, _data
            );
            require(retval == ERC721X_BATCH_RECEIVE_SIG);
        }
    }

    function transfer(address _to, uint256 _tokenId, uint256 _amount) public {
        _transferFrom(msg.sender, _to, _tokenId, _amount);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId, uint256 _amount) public {
        _transferFrom(_from, _to, _tokenId, _amount);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId, uint256 _amount)
        internal
        isOperatorOrOwner(_from)
    {
        require(tokenType[_tokenId] == FT);
        require(_amount <= balanceOf(_from, _tokenId), "Quantity greater than from balance");
        require(_to != address(0), "Invalid to address");

        _updateTokenBalance(_from, _tokenId, _amount, ObjectLib.Operations.SUB);
        _updateTokenBalance(_to, _tokenId, _amount, ObjectLib.Operations.ADD);
        emit TransferWithQuantity(_from, _to, _tokenId, _amount);
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, uint256 _amount) public {
        safeTransferFrom(_from, _to, _tokenId, _amount, "");
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, uint256 _amount, bytes memory _data) public {
        _transferFrom(_from, _to, _tokenId, _amount);
        require(
            checkAndCallSafeTransfer(_from, _to, _tokenId, _amount, _data),
            "Sent to a contract which is not an ERC721X receiver"
        );
    }

    function _mint(uint256 _tokenId, address _to, uint256 _supply) internal {
        // If the token doesn't exist, add it to the tokens array
        if (!exists(_tokenId)) {
            tokenType[_tokenId] = FT;
            allTokens.push(_tokenId);
        } else {
            // if the token exists, it must be a FT
            require(tokenType[_tokenId] == FT, "Not a FT");
        }

        _updateTokenBalance(_to, _tokenId, _supply, ObjectLib.Operations.ADD);
        emit TransferWithQuantity(address(this), _to, _tokenId, _supply);
    }


    function checkAndCallSafeTransfer(
        address _from,
        address _to,
        uint256 _tokenId,
        uint256 _amount,
        bytes memory _data
    )
        internal
        returns (bool)
    {
        if (!_to.isContract()) {
            return true;
        }

        bytes4 retval = ERC721XReceiver(_to).onERC721XReceived(
            msg.sender, _from, _tokenId, _amount, _data);
        return(retval == ERC721X_RECEIVED);
    }

}

/**
 * @title maskSaver main contract
 * @dev maskSaver contract that make transaction and mint
 *  from ERC721X contracts.
 */
contract maskSaver is ERC721XToken {

    struct Mask {
        string  manufacturerName;
        address manufacturerAddr;
        uint256 date;
    }
    
    Mask[] public Masks; // 첫 아이템의 인덱스는 0입니다
    uint256[] public maskIDIntList;
    address public owner;
    
    event NFT_MakeEvent(string _name, address _account, string _Message);
    event FT_MakeEvent(string _name, address _account, uint256 _supply, string _Message);
    event DealEvent(address _from, address _to, uint256 _tokenId, uint256 _amount, string _Message);
    event SellEvent(address _from, uint256 _tokenId, uint256 _amount, string _Message);
    
    constructor(string memory _baseTokenURI) public ERC721XToken(_baseTokenURI) {
            owner = msg.sender;
    }

    function name() external view returns (string memory) {
        return "Mask";
    }

    function symbol() external view returns (string memory) {
        return "MSK";
    }

    // fungible mint
    function mint(uint256 _tokenId, address _to, uint256 _supply) external {
        _mint(_tokenId, _to, _supply);
    }

    // nft mint
    function mint(uint256 _tokenId, address _to) external {
        _mint(_tokenId, _to);
    }
    
    /**
     * @dev mask making start with tokenId for order // FT
     * @param _name string to write mask manufacturerName
     * @param _account The address to batchTransfer objects to.
     * @param _supply Amount that wants to mint
     */
    function _maskMaking(string memory _name, address _account, uint256 _supply) public {
        //require(msg.sender == owner);
        uint256 maskId = Masks.push(Mask(_name, _account, now)) - 1; // 유일한 마스크  ID
        _mint(maskId, _account, _supply); // FT 새 마스크를 생산
        emit FT_MakeEvent(_name, _account, _supply, "Making masks...");
    }
    
    /**
     * @dev mask making start with tokenId for order // NFT
     * @param _name string to write mask manufacturerName
     * @param _account The address to batchTransfer objects to.
     */
    function _maskMaking(string memory _name, address _account) public {
        //require(msg.sender == owner);
        uint256 maskId = Masks.push(Mask(_name, _account, now)) - 1; // 유일한 마스크  ID
        _mint(maskId, _account); // NFT 새 마스크를 생산
        emit NFT_MakeEvent(_name, _account, "Masking the mask...");
    }
    
    // deal function
    function dealMasks(address _from, address _to, uint256 _tokenId, uint256 _amount) public {
        //require(ownerOf(_tokenId) == _from);
        require(balanceOf(_from, _tokenId) >= _amount);
        safeTransferFrom(_from, _to, _tokenId, _amount);
        emit DealEvent(_from, _to, _tokenId, _amount, "dealing masks...");
    }
    
    /**
     * @dev sellfunction that seller sell mask to people
     * @param _from The address of seller.
     * @param _tokenId tokenId which mask token is sold.
     * @param _amount How many mask token is sold.
     * Note:  Arrays should be sorted so that all tokenIds in a same bin are adjacent (more efficient).
     */
    function sellMasks(address _from, uint256 _tokenId, uint256 _amount) public {
        //require(ownerOf(_tokenId) == _from);
        require(balanceOf(_from, _tokenId) >= _amount);
        //safeTransferFrom(_from, 모아지는 지갑 주소, _tokenId, _amount);
        emit SellEvent(_from, _tokenId, _amount, "Selling masks...");
    }
    
    //논란의 여지가 있음. 소각은 나중에 생각하기로
    function burnToken(uint256 _tokenId) public {
        // if 60days later after sold mask, burn token
        require(checkDate60(_tokenId));
        _burn(_tokenId);
    }
    
    // check date thst based on law
    function checkDate(uint256 maskId) public view returns (bool) {
        return (Masks[maskId].date + 5 days > block.timestamp);
    }
    
    // for burn token
    function checkDate60(uint256 maskId) public view returns (bool) {
        return (Masks[maskId].date + 60 days > block.timestamp);
    }
    
    // 1 = NFT, 2 = FT
    function checkNFT(uint256 _tokenId) public view returns (uint256){
        return tokenType[_tokenId];
    }
    
    // check mask list whick token is inside
    function maskListReturn(uint256 _number) public view returns (uint256) {
        return maskIDIntList[_number];
    }
} 
