 -include .env 

  deploy-sepolia:
    forge script script/DeployVoting.s.sol:DeployVoting --rpc-url $(SEPOLIA_RPC_URL)
    --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
    --vvvv