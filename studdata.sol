// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Student Data Management using Struct, Array, and Fallback
contract StudentData {
    // Structure to store student details
    struct Student {
        uint256 id;
        string name;
        uint256 age;
        string course;
    }

    // Dynamic array to store students
    Student[] public students;

    // Event logs for transparency
    event StudentAdded(uint256 id, string name, uint256 age, string course);
    event FallbackReceived(address sender, uint256 value);

    // Function to add a new student
    function addStudent(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _course
    ) public {
        students.push(Student(_id, _name, _age, _course));
        emit StudentAdded(_id, _name, _age, _course);
    }

    // Function to get student details by index
    function getStudent(uint256 index)
        public
        view
        returns (uint256, string memory, uint256, string memory)
    {
        require(index < students.length, "Invalid index");
        Student memory s = students[index];
        return (s.id, s.name, s.age, s.course);
    }

    // Function to get total students
    function getStudentCount() public view returns (uint256) {
        return students.length;
    }

    // Fallback function to handle plain Ether transfers
    fallback() external payable {
        emit FallbackReceived(msg.sender, msg.value);
    }

    // Receive function (if Ether sent directly)
    receive() external payable {
        emit FallbackReceived(msg.sender, msg.value);
    }

    // To check total Ether balance received by this contract
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
