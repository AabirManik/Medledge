



# 🛡️ Secure Report 
Sharing Platform with Audit Trail

A simple yet powerful **Solidity smart contract** for securely uploading and sharing reports, while keeping a **transparent on-chain audit trail**.  
Deployed on the **Celo Sepolia Testnet**, this project demonstrates how blockchain can ensure **trust, transparency, and data integrity** in report management.

---<img width="1597" height="1199" alt="celo3" src="https://github.com/user-attachments/assets/5cc675a8-fda9-4122-ad1f-2380fa6bdf9f" />

## 📖 Project Description

This project allows users to **upload reports securely**, store their details on the blockchain, and maintain an immutable **audit trail** of uploads.  
Each report contains metadata such as title, description, uploader address, timestamp, and IPFS hash for off-chain storage.

It’s a great starting point for beginners who want to understand:
- How to **structure and deploy** Solidity smart contracts  
- How to **store and retrieve** data on the blockchain  
- How **audit trails** can be implemented using blockchain events  

---

## 🚀 What It Does

1. **Uploads Reports Securely**  
   Users can upload a report containing title, description, and IPFS hash (file stored off-chain).

2. **Maintains Audit Trail**  
   Each upload triggers an on-chain event — creating a **tamper-proof log** of all report uploads.

3. **Retrieves Reports**  
   Users can view all reports or fetch any specific one using its report ID.

4. **Showcases Blockchain Use Case**  
   Demonstrates how decentralized systems can maintain transparency in file management and sharing.

---

## ✨ Features

- ✅ **Secure Report Uploads** – Reports include title, description, IPFS hash, and uploader address.  
- 🧾 **Immutable Audit Log** – Every upload emits an event stored on the blockchain.  
- 🔍 **Report Retrieval** – Access all reports or fetch one by ID instantly.  
- 💾 **Off-chain File Storage (IPFS)** – Large files are stored off-chain while metadata remains on-chain.  
- 🌐 **Deployed on Celo Sepolia Testnet** – Explore real transactions and verify transparency.  
- 👨‍💻 **Beginner-Friendly Solidity Code** – Clean, modular, and easy to understand for new developers.

---

## 🧠 Code Overview

Below is the main Solidity code used in this project 👇

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureReportShare {

    // Structure to store report details
    struct Report {
        uint256 id;
        string title;
        string ipfsHash;  // File stored off-chain (e.g., on IPFS)
        string description;
        address uploadedBy;
        uint256 timestamp;
    }

    // Array to store all uploaded reports
    Report[] public reports;

    // Event to log uploads (Audit Trail)
    event ReportUploaded(
        uint256 id,
        string title,
        string ipfsHash,
        address indexed uploadedBy,
        uint256 timestamp
    );

    // Function to upload a new report
    function uploadReport(
        string memory _title,
        string memory _ipfsHash,
        string memory _description
    ) public {
        uint256 reportId = reports.length + 1;

        reports.push(Report({
            id: reportId,
            title: _title,
            ipfsHash: _ipfsHash,
            description: _description,
            uploadedBy: msg.sender,
            timestamp: block.timestamp
        }));

        emit ReportUploaded(reportId, _title, _ipfsHash, msg.sender, block.timestamp);
    }

    // Function to view all reports
    function getAllReports() public view returns (Report[] memory) {
        return reports;
    }

    // Function to get a single report by ID
    function getReportById(uint256 _id) public view returns (Report memory) {
        require(_id > 0 && _id <= reports.length, "Invalid report ID");
        return reports[_id - 1];
    }
}
