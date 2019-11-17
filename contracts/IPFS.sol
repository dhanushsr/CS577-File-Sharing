pragma solidity 0.5.12;
pragma experimental ABIEncoderV2;
import './users.sol';


contract IPFS {

    Users users;
    enum userTypes {Admin, Student, Faculty, Staff}

    struct File{
        string _name;
        address _sender;
        address _reciver;
        string _encrypted_hash;
    }

    struct Library{
        File[] files;
        uint _file_count;
    }

    mapping(address => Library) privateLibrary;
    mapping(uint => Library) publicLibrary;

    constructor(address _users_contract) public {
        users = Users(address(_users_contract));
    }

    modifier userOnly {
        require(users.isUser(msg.sender) == true, "Not Registered User");
        _;
    }

    function sendPrivateFile(string memory filename, address receiver, string memory encrypted_hash) public userOnly {
        require(users.isUser(receiver) == true, "Receiver Not Found");
        privateLibrary[receiver].files.push(File(filename, msg.sender, receiver, encrypted_hash));
        privateLibrary[receiver]._file_count++;
    }

    function getMyFiles() public view userOnly returns(File[] memory) {
        return privateLibrary[msg.sender].files;
    }

    function addGroupFile(string memory filename, string memory encrypted_hash) public userOnly {
        uint groupID = users.getGroupID(msg.sender);
        publicLibrary[groupID].files.push(File(filename, msg.sender, msg.sender, encrypted_hash));
        publicLibrary[groupID]._file_count++;
    }

    function getGroupFiles() public view userOnly returns(File[] memory) {
        uint groupID = users.getGroupID(msg.sender);
        return publicLibrary[groupID].files;
    }

    function deleteGroupFile(uint _index, uint _type) public {
        delete publicLibrary[_type].files[_index];
    }
}