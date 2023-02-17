// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Welcome to Vitalik's Hype Shoe Store 
// Vitalik loves shoes and wants to sell shoes on Ethereum 
// He wants to keep a record of all his customers so he can send them an airdrop later!
contract VitaliksHypeShoeStore {
    struct Item {
        uint256 id; 
        string productName; 
        uint256 cost; 
    }

    struct Customer  {
        Item[] purchasedItems; 
        string email;
        string cell;  
        string firstName;
        string lastName;
        uint256 index; 
    }
  
    mapping(address => Customer) private customers;
    address[] private customerIndex;
    
    event AddCustomer(
        address indexed customerAddress, 
        string email, 
        string cell, 
        string firstName, 
        string lastName, 
        uint256 index
    );

    event BuyShoe( 
        address indexed customerAddress, 
        uint256 id,
        string productName,
        uint256 cost
    );

    function isCustomer(address customerAddress) public view returns(bool) {
        if(customerIndex.length == 0) {
            return false;
        }
        uint256 tempCustomerIndex = customers[customerAddress].index;
        return customerIndex[tempCustomerIndex] == customerAddress;
    }

    function getTotalCustomers() public view returns(uint) {
        return customerIndex.length;
    }

    function getCustomerFromIndex(uint256 index) public view returns(address) {
        return customerIndex[index];
    }

    function getCustomer(address customerAddress) public view returns(Customer memory) {
        return customers[customerAddress];
    }

    function addCustomerInformation(
        address customerAddress, 
        string memory email, 
        string memory cell, 
        string memory firstName, 
        string memory lastName
    ) public returns(uint256) {
        customers[customerAddress].email = email; 
        customers[customerAddress].cell = cell; 
        customers[customerAddress].firstName = firstName; 
        customers[customerAddress].lastName = lastName; 
        
        customerIndex.push(customerAddress);
        customers[customerAddress].index = customerIndex.length-1;

        emit AddCustomer(
            customerAddress, 
            customers[customerAddress].email, 
            customers[customerAddress].cell, 
            customers[customerAddress].firstName, 
            customers[customerAddress].lastName, 
            customers[customerAddress].index
        );

        return customerIndex.length-1;
    }

    function buyShoe(
        address customerAddress, 
        uint256 id, 
        string memory productName, 
        uint256 cost
    ) public payable {
        require(!isCustomer(customerAddress), "Customer needs to register first!");
        customers[customerAddress].purchasedItems.push(Item({id: id, productName: productName, cost: cost}));
        emit BuyShoe(customerAddress, id, productName, cost);
    }
}