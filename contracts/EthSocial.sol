// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract EthSocial {
  struct UserStruct { 
    string username;
    uint age;
    bool isUser;
  }

  struct Post { 
    string title;
    string body;
    uint time;
  }

  mapping (address => UserStruct) users;
  mapping (address => Post[]) posts;
  
  address[] userList;

  function getTotalUsers() public view returns (uint) { 
    return userList.length;
  }

  function getUser(address _userAddress) public view returns (UserStruct memory) { 
    require(users[_userAddress].isUser == true, "User doesn't exist!!");

    return users[_userAddress];
  }

  function createUser(address _userAddress, string memory _username, uint _age) public returns (bool success) { 
    require(_userAddress == msg.sender, "You can't create an account on behalf of others!!");
    
    UserStruct memory user;
    user.username = _username;
    user.age = _age;
    user.isUser = true;

    userList.push(_userAddress);
    users[_userAddress] = user;

    return true;
  }

  function createPost(address _userAddress, string memory _title, string memory _body) public returns (Post memory) { 
    require(_userAddress == msg.sender, "You can't post on behalf of others!!");
    require(users[_userAddress].isUser == true, "You need to create a user first!!");

    Post memory newPost; 
    newPost.title= _title;
    newPost.body = _body;
    newPost.time = block.timestamp;

    posts[_userAddress].push(newPost);
    
    return newPost;
  }

  function getPosts(address _userAddress) public view returns (Post[] memory) {
    require(users[_userAddress].isUser == true, "Can't get post for nonexistent user!");

    return posts[_userAddress];
  }
}
