// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IWETH {
    function deposit() external payable;
    function withdraw(uint256) external;
    function approve(address spender, uint256 amount) external returns (bool);
}

contract AutoSwapPolSponsorUSDC is Ownable {
    // Uniswap V3 SwapRouter instance.
    ISwapRouter public immutable swapRouter;
    // Addresses for WMATIC and USDC tokens.
    address public immutable WMATIC;
    address public immutable USDC;
    // Vault wallet that receives the USDC after swap.
    address public vaultWallet;

    // Event to log successful swaps.
    event SwapAndForward(address indexed sender, uint256 maticIn, uint256 usdcOut);

    // Constructor sets the router, token addresses and the vault wallet.
    constructor(
        address _swapRouter,
        address _wmatic,
        address _usdc,
        address _vaultWallet
    ) Ownable(msg.sender) {
        swapRouter = ISwapRouter(_swapRouter);
        WMATIC = _wmatic;
        USDC = _usdc;
        vaultWallet = _vaultWallet;
    }

    function swapAndSend(uint256 amountOutMinimum) public payable {
        require(msg.value > 0.01 ether, "Must send at least 0.01 MATIC");

        uint256 amountToSwap = msg.value - 0.01 ether;

        IWETH(WMATIC).deposit{value: amountToSwap}();
        IWETH(WMATIC).approve(address(swapRouter), amountToSwap);

        // Swap WMATIC to USDC
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
            tokenIn: WMATIC,
            tokenOut: USDC,
            fee: 3000,
            recipient: address(this),
            deadline: block.timestamp + 20 minutes,
            amountIn: amountToSwap,
            amountOutMinimum: amountOutMinimum,
            sqrtPriceLimitX96: 0
        });

        uint256 usdcReceived = swapRouter.exactInputSingle(params);
        require(usdcReceived > 0, "Swap failed");

        require(IERC20(USDC).transfer(vaultWallet, usdcReceived), "USDC transfer failed");

        emit SwapAndForward(msg.sender, amountToSwap, usdcReceived);
    }

    function setVaultWallet(address _vaultWallet) external onlyOwner {
        vaultWallet = _vaultWallet;
    }

    receive() external payable {
        // Using 0 as the minimum output here; for production add slippage protection.
        swapAndSend(0);
    }
}
