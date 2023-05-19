// SPDX-License-Identifier: BUSL-1.1
pragma solidity >=0.8.4;

//EQUALIZER FINANCE

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '../interfaces/Equalizer/IERC3156FlashLender.sol';
import '../interfaces/Equalizer/IERC3156FlashBorrower.sol';
import '../interfaces/Equalizer/IVault.sol';
import '../interfaces/Equalizer/IVaultFactory.sol';
import "hardhat/console.sol";

contract FBorrower is IERC3156FlashBorrower {
    enum Action {NORMAL, OTHER}
    IERC3156FlashLender public lender;
    IVaultFactory vaultFactory;

    /// @dev ERC-3156 Flash loan callback
    function onFlashLoan(address initiator,address token,uint256 amount,uint256 fee,bytes calldata data) external override returns (bytes32) {
        require(msg.sender == address(lender), 'FLASH_BORROWER_UNTRUSTED_LENDER');
        require(initiator == address(this), 'FLASH_BORROWER_LOAN_INITIATOR');
        Action action = abi.decode(data, (Action));


        console.log("received");
        // if (action == Action.NORMAL) {

        // } else if (action == Action.OTHER) {
            
        // }

        return keccak256('ERC3156FlashBorrower.onFlashLoan');
    }

    /// @dev Initiate a flash loan by user flashLoan,flashLoan then calls the onFlashLoan
    function flashBorrow(address token, uint256 amount,address _lender) public {
        bytes memory data = abi.encode(Action.NORMAL);
        lender = IERC3156FlashLender(_lender);

        IERC20 borrowToken = IERC20(token);
        uint256 _allowance = borrowToken.allowance(address(this), address(lender));
        uint256 _fee = lender.flashFee(token, amount);
        uint256 _repayment = amount + _fee;
        borrowToken.approve(address(lender), _allowance + _repayment);
        lender.flashLoan(this, token, amount, data);
    } 


    /**

//extracted contract    
// constructor(address _lender) {
//     lender = IERC3156FlashLender(_lender); 
// }
//when is the lender and factory in constructor passed passed?
//pass the address of the lender
//it seems all interfaces need to be wrapped to connect to the main smart contract and inherit functionalities
// in the javascript, the argument can be added to the deploy function
//pSwap.deployed('0x99499',{from:,to:,value:})


        function approveRepayment(address token, uint256 amount) public {
        uint256 _allowance = IERC20(token).allowance(address(this), address(lender));
        uint256 _fee = lender.flashFee(token, amount);
        uint256 _repayment = amount + _fee;
        IERC20(token).approve(address(lender), _allowance + _repayment);
    }
    

    function flashBorrow(address token, uint256 amount) public {
        // Use this to pack arbitrary data to `onFlashLoan`
        bytes memory data = abi.encode(Action.NORMAL);
        approveRepayment(token, amount);
        lender.flashLoan(this, token, amount, data);
    }
     */
}


//flash loan provider smart contract triggers a loan from the vault