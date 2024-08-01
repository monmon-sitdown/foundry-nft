pragma solidity ^0.8.19;

import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {Test} from "forge-std/Test.sol";
import {MintBasicNft} from "../script/Interactions.s.sol";

//import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";

contract BasicNftTest is Test {
    string constant NFT_NAME = "Dgie";
    string constant NFT_SYMBOL = "DOG";

    BasicNft public basicNft;
    DeployBasicNft public deployer;

    address public deployerAddress;

    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    //"ipfs://QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png";
    address public constant USER = address(1);

    function setUp() public {
        emit log("Setting up BasicNftTest");
        basicNft = new BasicNft();
        emit log("BasicNft contract deployed");
        //basicNft = deployer.run(); //注释掉之后才对 注释之前报错
    }

    function testNameIsCorrect() public view {
        string memory expectedName = NFT_NAME;
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG_URI)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
