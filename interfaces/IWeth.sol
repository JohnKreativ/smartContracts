// SPDX-License-Identifier: GPL
pragma solidity >=0.6.6;

/*interface to make ETH a token */
interface IWETH {
    function balanceOf(address account) external view returns (uint);
    function deposit() external payable;
    function transfer(address recipient, uint amount) external returns (bool);
    function withdraw(uint) external;
}
