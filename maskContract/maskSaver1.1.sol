pragma solidity ^0.6.0;

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract MaskSaver {
    
    using SafeMath for uint256;
    
    address owner;
    
    struct MaskInfo {
        uint256 serialNumber;
        address manufacturerAddr;
        address[] expDistributor; // 예상유통지가 여러개 일수 있음
        address[] realDistributor; // 예상유통지가 여러개 일수 있음
        address expSeller;
        address realSeller;
    }
    
    struct manufacturer {
        string manufacturerName;
        uint256 maskAmountOutput;
        uint256 maskAmountHave;
        uint256 maskIndex;
    }
    
    mapping (address => manufacturer) manufacturers;
    mapping (uint256 => MaskInfo) masks;
    
    bool public factoryOn;
    
    string public expDistributor;
    
    uint256 public newMaskAmount;
    uint256 public errorRange;
    uint256 public index;
    uint256 public temp;
    
    // event that communicate with things.
    event MaskProduction(string _maskFactoryName, uint256 _MaskQuantity, string _statusMessage);
    event manufacturerToDistributor(string _manufacturerName, string _distributorName, string _statusMessage);
    event MaskQuantityCheck(string _maskFactoryName, uint256 _MaskQuantity, string _statusMessage);
    
    constructor(string memory _manufacturerName) public {
        
        bytes memory isManufacturerNameEmpty = bytes(_manufacturerName);

        if (isManufacturerNameEmpty.length == 0) {
            revert();
        }
        else {
            owner = msg.sender;
            manufacturers[msg.sender].manufacturerName = _manufacturerName;
            manufacturers[msg.sender].maskIndex = 0;
            errorRange = 5;
        }
    }

    // Access control
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    // Boolen to know factory open 
    modifier closeFactory {
        require(factoryOn == false);
        _;
    }
    
    function setErrorRange(uint256 _range) external onlyOwner { //Temporary function to set the error range.
        errorRange = _range;
    }
    
    function startMaskMaking(uint256 _MaskQuantity) external onlyOwner {
        factoryOn = true;
        newMaskAmount = _MaskQuantity;
        temp = _MaskQuantity;
        index = manufacturers[msg.sender].maskIndex;
        
        while (temp >= 500) {
            masks[index].serialNumber = now;
            masks[index].manufacturerAddr = msg.sender;
            temp = temp.sub(500);
            index++;    
        }
        
        emit MaskProduction(manufacturers[msg.sender].manufacturerName, _MaskQuantity, "Making masks..");
    }
    
    function stopMaskMaking() external onlyOwner {
        factoryOn = false;
        manufacturers[msg.sender].maskAmountOutput = newMaskAmount;
        manufacturers[msg.sender].maskAmountHave = manufacturers[msg.sender].maskAmountHave.add(newMaskAmount);
        newMaskAmount = 0;
        emit MaskProduction(manufacturers[msg.sender].manufacturerName, manufacturers[msg.sender].maskAmountOutput, "Finished making masks!");
    }

    function getOwner() external view returns (address) {
        return owner;
    }
    
    function getManufacturerName() external view returns (string memory){
        return manufacturers[msg.sender].manufacturerName;
    }
    
    function getMaskProductionDate(uint256 _index) external view returns (uint256) {
        return masks[_index].serialNumber;
    }
    
    function getMaskProductionAddr(uint256 _index) external view returns (address) {
        return masks[_index].manufacturerAddr;
    }
    
    function getMaskQuantityToday(address _manufacturerAddr) external view returns (uint256){
        return manufacturers[_manufacturerAddr].maskAmountOutput;
    }
    
    function getMaskQuantityHave(address _manufacturerAddr) external view returns (uint256){
        return manufacturers[_manufacturerAddr].maskAmountHave;
    }
}
