// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.6.6;

import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface IKyberProxy {
    function maxGasPrice() external view returns(uint);
    function enabled() external view returns(bool);
    function info(bytes32 id) external view returns(uint);
    function getExpectedRate(IERC20 src, IERC20 dest, uint srcQty) external view returns (uint expectedRate, uint slippageRate);

    function tradeWithHint(IERC20 src, uint srcAmount, IERC20 dest, address destAddress, uint maxDestAmount,
        uint minConversionRate, address walletId, bytes calldata hint) external payable returns(uint);

    function swapTokenToToken(IERC20 src, uint srcAmount, IERC20 dest, uint minConversionRate) external returns(uint);
    function swapEtherToToken(IERC20 token, uint minConversionRate) external payable returns(uint);
    function swapTokenToEther(IERC20 token, uint srcAmount, uint minConversionRate) external returns(uint);
}

