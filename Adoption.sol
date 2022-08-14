// Zihe Jia, student #1008252392, Personnal Project, For APS1050 2022 Winter Term 
// New Function 1: Adoption Records
// New Function 2: Cancel Adoption
// New Function 3: Give a "like" to a particular dog
// New Function 4: Donate to Pet Shop
// New Function 5: Display donor and amount information

pragma solidity ^0.5.0;

contract Adoption {

address[16] public adopters;
// Adopting a pet
 
uint public pet_Id;
 // mapping(uint => uint) public likemap;


function adopt(uint petId) public returns (uint) {
  require(petId >= 0 && petId <= 15);

  adopters[petId] = msg.sender;

  return petId;
}

// Retrieving the adopters
function getAdopters() public view returns (address[16] memory) {
  return adopters; 
}

function() external payable {
}



// New Function 1: Adoption Records
event LoglistAdoption(uint _num, address _contributer);
function getListAdoption() public {
    for(uint i=0; i<16; i++){
        emit LoglistAdoption(i, adopters[i]);
    }
}
//////////////////////////////////////////////////////////////////////



// New Function 2: Cancel Adoption
function cancelAdoption() public returns (bool){
    for(uint i=0; i<16; i++){
        if (msg.sender == adopters[i]) {
            adopters[i] = 0x0000000000000000000000000000000000000000;
            return true;
        }
    }
    return false;
}
//////////////////////////////////////////////////////////////////////



// New Function 3: Give a "like" to a particular dog
uint [16] public like; 

// Record users' likes for dogs
function likeIncrement(uint _petId) public{
    ++like[_petId];
 } 

// test function of like
function test_likeIncremen() public{
     likeIncrement(1);
 }
//////////////////////////////////////////////////////////////////////



// New Function 4: Donate to Pet Shop
uint public totalMoney;
uint public numofcontributer;
//address public owner = msg.sender;
// address owner = this;
address payable AddrPetShop = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

struct contributerToPetShop{
    address addrToShop;
    uint amountToShop;
}
mapping(uint => contributerToPetShop) public contributerList;

// Donate to Pet Shop
function contributeToPetShop() public payable returns (bool) {
    if( msg.value == 0 )   // Avoid invalid transactions
    return false;

    numofcontributer++;
    totalMoney += msg.value;
    contributerList[numofcontributer] = contributerToPetShop(msg.sender, msg.value); 
    return true;
}

// Transferring the amount in the contract account to the Pet Shop account
function transferToPetShop()public payable returns (bool) {
    if(totalMoney == 0)
    return false;

    AddrPetShop.transfer(totalMoney);
    totalMoney = 0;
    return true;
}

// Get the address and balance of the blockchain where the current contract is located
// function getConstractAddressBalance() public returns(address ConstractAddress, uint ConstractBalance){
//     return (this,this.balance);
// }
//////////////////////////////////////////////////////////////////////



// New Function 5: Display donor and amount information
event LoglistContribute(uint _num, address _contributer, uint _amountToShop);
function getListContribute() public {
    for(uint i=1; i<=numofcontributer; i++){
        emit LoglistContribute(i, contributerList[i].addrToShop, contributerList[i].amountToShop);
    }
}
//////////////////////////////////////////////////////////////////////

}