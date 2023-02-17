// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Solidity {
    // Part 1: Data Types 

    /*
    *   Boolean: true or false
    */
    bool a; // Defaults to false if not initialized
    bool b = true;

    /*
    *   Integers: int or uint 
    *   int: signed integer 
    *       a) stores - and + values  
    *       b) ranges from -2^255 and 2^255-1 
    *   uint: unsigned integer 
    *       a) stores + values
    *       b) ranges from 0 to 2^256-1
    *   data sizes
    *       a) There are signed and unsigned integers with different sizes
    *           a) they range from int8 => int256 (steps of 8)
    *           b) uint8 => uint256 (steps of 8)
    */
    int8 c = -100; 
    int16 d = type(int16).min; 
    int24 e = 300;
    int32 f = 20; 
    int64 g = 404; 
    int72 h = 123; 
    int256 i; // defaults to 0

    uint8 j = 100; 
    uint16 k = 200; 
    uint24 l = 300;
    uint32 m = 400; 
    uint64 n = type(uint64).max; 
    uint256 o; // defaults to 0
    

    /*
    *   Address: address or address payable
    *   address: represents a standard Ethereum address
    *       a) 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045
    *   address payable: represents an Ethereum address you can send ether to
    *       a) contains the transfer and send methods
    * 
    */
    address p; 
    address payable q; 

    /*
    *   Bytes: bytes or bytesX
    *       a) bytes represent a dynamically-sized byte array 
    *       b) bytesX represents a fixed-size byte arrays that hold a sequence of bytes 
    *       c) values can range from bytes1 to bytes32
    *       d) you can represent bytesX as byteX[]
    *       
    */
    bytes r = hex"11"; //  dynamically sized byte array 
    // adding the hex keyword represents the hexadecimal literal which will put the binary represenation into bytes r
    // in this example hex"11" is actualy the value 0x30783131
    bytes1 s = 0x01; // fixed sized byte array 
    bytes32 t = "neo";

    /*
    *   String: string <name>; 
    *       a) strings are dynamic arrays of bytes
    *       b) regular strings can only contain ASCII characters between 0x20 (space character) & 0x7E (~ tilde character)
    *       c) with the unicode (uincode"test") keyword, they can contain any UTF-8 encoded characters
    */
    string u = "hello";
    // string v = "🫡"; this won't work becuase it can only contain ASCII characters 
    string v = unicode"🫡"; 
    string w = "asdf" "qwert"; // this is a valid string! strings can be split into multiple parts
    bytes stringBytes = bytes("me neo"); // converting between string to bytes
    // converting between hex and string
    bytes bytesValue = hex"41";
    string stringData = string(bytesValue);


    /*
    *   Structs: 
    *       struct <name> {
    *           <type> <name>; 
    *       }
    *       a) use a struct if you want to create your own data type
    *       b) can be used inside mappings and arrays
    *       c) you can declare a struct in a seperate file and import it to a contract
    */ 
    struct User {
        uint256 id; 
        address userAddress; 
        address[] friends;
    }

    /*
    *   Enum: 
    *      enum Direction {
    *           Left, // 0 
    *           Right, // 1
    *           Up, // 2 
    *           Down // 3
    *      }
    *      a) a way to create a user-defined type 
    *      b) they convert to integers
    *      c) requires at least one member 
    *      d) its default value when declared is the first member
    *      e) enums cannot have more than 256 members
    *      f) type(NameOfEnum).min or type(NameOfEnum).max gives you the smallest and largest number of the enum given
    */
    enum Status {
        Incomplete,
        Pending,
        Completed
    }
    Status public status1; // defaults to Status.Incomplete
    Status public status2 = Status.Pending; 
    uint minStatusValue = type(Status).min;
    uint maxStatusValue = type(Status).max;



    // Part 2: Data Structures
    /*
    *   Mappings: mapping(keyType => valueType) <access modifier> <name>;
    *       a) acts like a hashtable
    *       b) keyType can be any built-in value type (eg. bytes, string, enum and even a contract)
    *       c) initial default value is the 0 byte-represenation of the valueType
    *       d) you cannot iterate over a mapping
    *       
    */ 
    mapping(address => uint256) public testMapping1;
    mapping(address => mapping(address => uint256)) public testMapping2;
    mapping(uint256 => uint256) testMapping3; 

    /*
    *   Array: ArrayType[] <access modifier> <name>; 
    *          ArrayType[k] <access modifier> <name>; (where k = number of elements initalized)
    *       a) arrays can be either be compile-time fixed size or they have a dynamic size
    *       b) .push() and .pop() methods available
    */ 
    uint256[] public array1; 
    address[] public array2; 
    string[] public array3 = new string[](3); // ["", "", ""]
    address[2] public array4; // [0x0, 0x0]



    // Part 3: Other 
    /*
    *   Functions:  function <nameOfFunction>(params) <accessModifier> <returns>; 
    *      a) functions are executable snippets of code
    *      b) they are usually defined inside contracts, but they can also be defined outside contracts (scroll all the way down!)
    *      c) they can happen internally or externally
    *      d) they have different levels of visibility when interacting with other contracts
    *           external: part of the contract interface which means they can be called from other contracts and transactions
    *           public: public functions are part of the contract interface and can be either called internally or via message calls.
    *           internal: can only be accessed within the current contract or contracts deriving from it 
    *           private: private functions are like internal ones but they are not visible in derived contracts.
    *       e) they have different levels of state mutability 
    *           view: promises that the function won't modify the state of the blockchain
    *           pure: promises that the function won't modifiy or read the state of the blockchain
    *       e) there are multiple ways to return values from functions
    */
    
    // can be called within currnet contract or contracts deriving from it or via message calls
    function testFunction1(uint256 paramA) public returns(uint) {
        return 1;
    }

    // can be called within current contract or contracts deriving from it 
    function testFunction2() internal returns(uint) {
        return 1;
    }

    // similar to internal contracts but not visible to derived contracts
    function testFunction3() private returns(uint) {
        return 1;
    }

    // can be called from other contracts and transactions
    function testFunction4() external returns(uint) {
        return 1; 
    }

    function testFunction5() external returns(uint abc) {
        abc = 1;
    }

    // promises that the function won't modifiy or read the state of the blockchain
    function testFunction6() public pure returns(uint) {
        return 1; 
    }

    // view promises that the function won't modify the state of the blockchain
    function testFunction7() public view returns(uint) {
        return 1; 
    }


    /*
    *   Events: emit EventName(params)
    *       a) events allow developers to log information onto the Ethereum blockchain
    *       b) events are good for knowing when to perform an action, applications usually subscribe and listen to these events
    *       c) using the indexed keyword lets you filter through the logs by that parameter (up to 3 parameters can be indexed)
    */  
    event Jump(address indexed sender, uint256 height);

    function personJumps() external returns(uint256) {
        emit Jump(msg.sender, 1);
        return 1;
    }
}

// this is a valid function! functions can also be defined outside the contract
// these types of functions are called free functions
function helper() pure returns(string memory) {
    return "helloooo"; 
}