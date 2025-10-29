
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
