// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract RandomIpfsNft is ERC721URIStorage, VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface immutable i_vrfCoordinator;
    bytes32 public immutable i_gasLane;
    uint64 public immutable i_subscriptionId;
    uint32 public immutable i_callbackGasLimit;

    uint32 public constant NUM_WORDS = 1;
    uint16 public constant REQUEST_CONFIRMATIONS = 3;
    uint256 public constant MAX_CHANCE_VALUE = 100;

    //maps requestId to the address that called the requestId function
    mapping(uint256 => address) public s_requestIdToSender;
    string[3] public s_dogTokenUris;

    uint256 public s_tokenCounter;

    constructor(
        address vrfCoordinatorV2,
        bytes32 gasLane,
        uint64 subscriptionId,
        uint32 callbackGasLimit,
        string[3] memory dogTokenUris
    ) ERC721("Random IPFS NFT", "RIN") VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_tokenCounter = 0;
        s_dogTokenUris = dogTokenUris;
        // 0 st.bernard
        // 1 Pug
        // 2 Shiba
    }

    //Mint a Random Puppy
    //i_gasLane = the price per gas (Remember we renamed "keyHash" variable in the VRF contract to gasLane)
    //i_gasLane specifies which gasLane to use. See docs for a list of available lanes on each network
    //i_callbackGasLimit = max gas amount
    //100 gas @ 200 gwei / gas
    function requestDoggie() public returns (uint256 requestId) {
        requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, //price per gas
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit, //max gas amount
            NUM_WORDS
        );
        s_requestIdToSender[requestId] = msg.sender;
    }

    //fufillRandomWords callback function defined here is how we get the number back from our requestId function
    //once we get the random number from requestDoggieId this is the function that the oracle calls to fill the request
    //the reason it is "internal override" is because technically the oracle calls another contract (VRFConsumerBaseV2) to fill this
    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords)
        internal
        override
    {
        //owner of the dog
        address dogOwner = s_requestIdToSender[requestId];
        //assign this Nft a tokenId
        uint256 newTokenId = s_tokenCounter;
        s_tokenCounter = s_tokenCounter + 1;
        //0 - 99
        uint256 moddedRng = randomWords[0] % MAX_CHANCE_VALUE;
        uint256 breed = getBreedFromModdedRng(moddedRng);
        _safeMint(dogOwner, newTokenId);
        //set the tokenURI
        _setTokenURI(newTokenId, s_dogTokenUris[breed]);
    }

    // 0 - 9 = st. bernard
    // 10 - 29 = pug
    // 30 - 99 = shiba inu
    function getChanceArray() public pure returns (uint256[3] memory) {
        return [10, 30, MAX_CHANCE_VALUE];
    }

    function getBreedFromModdedRng(uint256 moddedRng)
        public
        pure
        returns (uint256)
    {
        uint256 cumulativeSum = 0;
        uint256[3] memory chanceArray = getChanceArray();

        for (uint256 i = 0; i < chanceArray.length; i++) {
            if (
                moddedRng >= cumulativeSum &&
                moddedRng < cumulativeSum + chanceArray[i]
            ) {
                //0 = St.Bernard
                //1 = Pug
                //2 = Shiba
                return i;
            }

            cumulativeSum = cumulativeSum + chanceArray[i];
        }
    }
}
