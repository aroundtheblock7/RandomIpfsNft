# Random Ipfs Nft 

### In this project we create a collection of Nft's that users can mint. Utilizing Chainlink's Verifiable Randomness (VRF) service we incorporate randomness into the minting process which ensures the NFT users receive is based on true/verifiable randomness.

### This project was deployed to Rinkeby network and in the photos below we see the contract creation and the "request doggie" (mint) transcations in etherscan. We also see the "internal transaction hash" which was the oracle responding to the "requestDoggie" function and fufilling our request via the "fulfillRandomWords" function. We can see which random NFT "doggie" we received on opensea in photo below as well as a photo of the Chainlink VRF page which provides us the "Consumer" and "Last Fufillment" info.

### Must set up .env file with private key and project Id if cloning and runing project
### To compile... yarn hardhat compile
### To deploy... yarn hardhat deploy --network rinkeby
### To mint... yarn hardhat deploy --tags mint --network rinkeby 

<img width="1323" alt="Screen Shot 2022-07-22 at 11 06 55 AM" src="https://user-images.githubusercontent.com/81759076/180487802-4e89d3ef-59e9-477b-a547-e4b195d019b4.png">
<img width="1520" alt="Screen Shot 2022-07-22 at 11 33 07 AM" src="https://user-images.githubusercontent.com/81759076/180487870-6969bfaf-f442-4794-aa5b-c8e62b155194.png">
<img width="1637" alt="Screen Shot 2022-07-22 at 11 35 17 AM" src="https://user-images.githubusercontent.com/81759076/180487897-88918b87-448f-4f69-9b85-68210c30e104.png">
<img width="1736" alt="Screen Shot 2022-07-22 at 11 37 52 AM" src="https://user-images.githubusercontent.com/81759076/180487944-271bfc04-207e-4a70-a264-c14e2486d2af.png">
<img width="1509" alt="Screen Shot 2022-07-22 at 11 31 34 AM" src="https://user-images.githubusercontent.com/81759076/180488007-fdd4d389-0f9b-4e20-b1da-a339a1f45da9.png">
<img width="1282" alt="Screen Shot 2022-07-22 at 11 44 22 AM" src="https://user-images.githubusercontent.com/81759076/180488108-025ddbf8-f7f3-4fdf-94c9-3cadc574926e.png">
<img width="1694" alt="Screen Shot 2022-07-22 at 12 09 16 PM" src="https://user-images.githubusercontent.com/81759076/180488132-aabe6f9a-fb66-414a-9e6d-7621a54d816a.png">
