pragma solidity 0.5.12;

contract Users {

    enum userTypes {Admin, Student, Faculty, Staff}

    address public admin;

    mapping(address => record) internal users;

    address[] newUsers;
    mapping(address => record) internal newUserRecord;
    uint newUsers_count = 0;

    mapping(address => ContactList) internal contacts;

    struct ContactList {
        address[] _contacts;
        uint _contacts_count;
    }

    struct record {
        uint _type;
        bool isExist;
        string _key;
    }
    
    constructor(string memory _publickey) public {
        admin = msg.sender;
        users[admin] = record(0, true, _publickey);
    }

    modifier adminOnly
    {
        require(admin == msg.sender, "Admin User Only");
        _;
    }

    modifier userOnly {
        require(users[msg.sender].isExist == true, "Not Registered");
        _;
    }

    function registerUser(address  newUser) public adminOnly {
        require(users[newUser].isExist == false, "User Already Esist");
        record memory newrecord = newUserRecord[newUser];
        users[newUser] = newrecord;
        delete newUserRecord[newUser];
    }

    function deRgisterUser(address _user) public adminOnly {
        require(users[_user].isExist == true, "Already Not Esist");
        delete users[_user];
    }

    function getNewUser() public adminOnly returns(address) {
        require(newUsers_count > 0, "No new user");
        address return_val = newUsers[newUsers_count -1];
        delete newUsers[newUsers_count - 1];
        newUsers_count --;
        return return_val;
    }

    function requestRegistration(string memory _key, uint _type) public {
        require(uint(userTypes.Staff) >= _type, "Invalid type");
        require(users[msg.sender].isExist == false, "User Already Esist");
        newUsers.push(msg.sender);
        newUserRecord[msg.sender] = record(_type, true, _key);
        newUsers_count ++;
    }

    function isUser(address _user) public view returns(bool) {
        return users[address(_user)].isExist;
    }
    
    function getGroupID(address _user) public view returns(uint) {
        return users[address(_user)]._type;
    }
    
    function addContact(address _contact) public userOnly {
        contacts[msg.sender]._contacts.push(_contact);
        contacts[msg.sender]._contacts_count ++;
    }
    
    function myContacts() public view returns(address[] memory) {
        return contacts[msg.sender]._contacts;
    }
    
    function getPublicKey(address user) public view returns(string memory) {
        return users[user]._key;
    }
    
    function addToMyContacts(address user) public userOnly{
        require(users[user].isExist == true, "User Not Found");
        contacts[msg.sender]._contacts.push(user);
        contacts[msg.sender]._contacts_count++;
    }

}