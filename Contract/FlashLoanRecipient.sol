// SPDX-License-Identifier: BUSL-1.1
pragma solidity >=0.8.4;

//BALANCER
//import '../interfaces/Balancer/IVault.sol';
//import "../interfaces/Balancer/IFlashLoanRecipient.sol";
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
//import '../interfaces/IERC20.sol';
//import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
//import "../../interfaces/IWETH.sol";

import "hardhat/console.sol";

interface IVault{
  function flashLoan(IFlashLoanRecipient recipient,IERC20[] memory tokens,uint256[] memory amounts,bytes memory userData) external;
}
interface IFlashLoanRecipient {
  function receiveFlashLoan(IERC20[] memory tokens,uint256[] memory amounts,uint256[] memory feeAmounts,bytes memory userData) external;
}
interface IProtocolFeesCollector{
  function vault() external view returns (IVault);
  function getSwapFeePercentage() external view returns (uint256);
  function getFlashLoanFeePercentage() external view returns (uint256);
}
interface IWeth is IERC20{
    function deposit() external payable;
    function withdraw(uint wad) external;
    function balanceOf(address owner) external view returns(uint);
}


contract FlashLoanRecipient is IFlashLoanRecipient {
    IVault private constant vault = IVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
    address constant DAI=0x6B175474E89094C44Da98b954EedeAC495271d0F;
    
    event Log(string message,uint val);
    string greeting;

    //call by user to make flashLoan any other userdata is passed to userData
    //function makeFlashLoan(IERC20[] memory tokens,uint256[] memory amounts,bytes memory userData) external {
      function makeFlashLoan(IERC20[] memory tokens,uint256[] memory amounts,bytes memory userData) external {
        
      vault.flashLoan(this, tokens, amounts, userData); //call to vault
    }

    //system call to receive and return funds
    function receiveFlashLoan(IERC20[] memory tokens,uint256[] memory amounts,uint256[] memory feeAmounts,
        bytes memory userData) external override {
        //require(msg.sender = address(vault));
        //LOGIC here before fee is return
        
        //swap borrowed token to intermediary asset at cheap price in exchange1
        //swap intermediary asset for final or 2nd intermediary asset in exchange2
        console.log("flash loan received in contract");
        //transfer profit to wallet
        //console.log("Deploying a Greeter with greeting:", greeting);
        //emit Log("FlashLoan received and paid",amounts);
    }

}