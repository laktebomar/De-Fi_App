pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";




contract FarmToken is ERC20{
    using Address for address;
    using SafeERC20 for IERC20;
    
    IERC20 public token;
    constructor(address _token) public ERC20("FarmToken", "FRM"){
            token = IERC20(_token);
    }

    function balance() public view returns(uint) {
        return token.balanceOf(address(this));       
    }

    function deposit(uint256 _amount) public {
    // Amount must be greater than zero
    require(_amount > 0, "amount cannot be 0");

    // Transfer MyToken to smart contract
    token.transferFrom(msg.sender, address(this), _amount);

    // Mint FarmToken to msg sender
    _mint(msg.sender, _amount);
}

function withdraw(uint256 _amount) public {
    // Burn FarmTokens from msg sender
    _burn(msg.sender, _amount);

    // Transfer MyTokens from this smart contract to msg sender
    token.transfer(msg.sender, _amount);
}

}