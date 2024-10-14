
# Create a Validation workflow on Bulk Uploads
### Summary
**As a** developer, **I want** to create a validation mechanism for a bulk upload modal, **So That** the system can validate data before it is submitted in bulk, ensuring that invalid records are identified and addressed before processing.

This story focuses on adding validation logic to a bulk upload modal that checks for common errors such as missing fields, incorrect data types, or invalid values in the uploaded data. The goal is to prevent errors during bulk processing and provide immediate feedback to the user when validation fails.

### Vision
By implementing a validation mechanism in the bulk upload modal, users can immediately see which records have issues and correct them before the data is processed. This improves the efficiency of bulk uploads, reduces system errors, and ensures data integrity by preventing the submission of invalid data.

### Background
Bulk upload operations can be prone to errors when large amounts of data are submitted without validation. By incorporating a validation step within the bulk upload modal, the system can pre-emptively identify and reject problematic records, reducing the number of failed uploads and improving overall user experience.

### Purpose
The purpose of this story is to create a validation process for the bulk upload modal, ensuring that all data being uploaded adheres to predefined rules and formats before it is processed. This will help prevent invalid data from being uploaded and improve the quality of the data in the system.

## Details
### 1. Create the Bulk Upload Modal
First, we need to implement the modal that allows users to upload their bulk data. This modal should provide a simple interface where users can upload a file (e.g., CSV or Excel) and review any validation errors.

#### Example Modal Structure (React):
```jsx
import React, { useState } from 'react';

function BulkUploadModal({ onClose, onUpload }) {
  const [file, setFile] = useState(null);
  const [validationErrors, setValidationErrors] = useState([]);

  const handleFileChange = (event) => {
    const selectedFile = event.target.files[0];
    setFile(selectedFile);
  };

  const handleUpload = async () => {
    if (file) {
      const errors = await validateFile(file);  // Validate file before upload
      if (errors.length > 0) {
        setValidationErrors(errors);  // Show validation errors in the modal
      } else {
        onUpload(file);  // Proceed with upload if no errors
      }
    }
  };

  return (
    <div className='modal'>
      <div className='modal-content'>
        <h2>Bulk Upload</h2>
        <input type='file' onChange={handleFileChange} />
        <button onClick={handleUpload}>Upload</button>
        <button onClick={onClose}>Cancel</button>

        {validationErrors.length > 0 && (
          <div className='validation-errors'>
            <h3>Validation Errors</h3>
            <ul>
              {validationErrors.map((error, index) => (
                <li key={index}>{error}</li>
              ))}
            </ul>
          </div>
        )}
      </div>
    </div>
  );
}

export default BulkUploadModal;
```

- **File Input**: Allows users to upload a file.
- **Upload Button**: Validates the file before allowing the user to proceed.
- **Validation Errors**: Displays a list of errors if the uploaded file fails validation.

### 2. Define Validation Rules
Define the validation rules that will be applied to the uploaded data. Common validation rules for bulk uploads might include:
  - **Required Fields**: Ensure that mandatory fields (e.g., ID, name, email) are present.
  - **Data Types**: Check that fields contain the correct data types (e.g., numbers, strings, dates).
  - **Value Ranges**: Verify that numeric values fall within the allowed range (e.g., age between 18 and 100).
  - **Unique Constraints**: Ensure that fields that should be unique (e.g., email) are not duplicated.
  - **Custom Business Logic**: Apply specific business rules, such as verifying email formats or ensuring a minimum length for certain fields.

#### Example Validation Logic (JavaScript):
```javascript
function validateFile(file) {
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.onload = (event) => {
      const fileContent = event.target.result;
      const rows = fileContent.split('
');
      const errors = [];

      rows.forEach((row, index) => {
        const columns = row.split(',');

        // Example validation checks:
        // Required field: ID
        if (!columns[0]) {
          errors.push(`Row $\{index + 1}: ID is required.`);
        }

        // Required field: Name
        if (!columns[1]) {
          errors.push(`Row $\{index + 1}: Name is required.`);
        }

        // Email format check
        if (columns[2] && !isValidEmail(columns[2])) {
          errors.push(`Row $\{index + 1}: Invalid email format.`);
        }

        // Age must be between 18 and 100
        const age = parseInt(columns[3], 10);
        if (isNaN(age) || age < 18 || age > 100) {
          errors.push(`Row $\{index + 1}: Age must be between 18 and 100.`);
        }
      });

      resolve(errors);
    };

    reader.readAsText(file);
  });
}

function isValidEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}
```
- **File Parsing**: This logic reads the file, parses each row, and applies the defined validation rules.
- **Validation Checks**: Basic checks include required fields, email format validation, and numeric range validation.
- **Error Reporting**: Errors are collected and passed back to the modal for display.

### 3. Display Validation Errors in the Modal
When the file is validated, any errors should be displayed in the modal, allowing the user to correct the data before proceeding with the upload.

#### Example Error Display (React):
```jsx
{validationErrors.length > 0 && (
  <div className='validation-errors'>
    <h3>Validation Errors</h3>
    <ul>
      {validationErrors.map((error, index) => (
        <li key={index}>{error}</li>
      ))}
    </ul>
  </div>
)}
```
- **Validation Errors**: Shows a list of validation errors directly in the modal so that users can review and correct their data.

### 4. Provide Feedback and Error Resolution
Once validation is complete, provide feedback to the user about any errors encountered during validation. If the data passes validation, allow the user to proceed with the upload.

- **Error Feedback**: Display the exact errors (e.g., missing fields, incorrect data types) in the modal.
- **Success**: If no errors are found, the user can proceed with uploading the file.

### 5. Test Bulk Upload Validation
Create tests to verify the bulk upload validation mechanism, ensuring that:
  - **Correct Data Passes**: Files with valid data successfully pass the validation step.
  - **Incorrect Data Fails**: Files with missing or incorrect data trigger the appropriate validation errors.
  - **Error Messages are Clear**: The validation errors provide meaningful, actionable feedback to the user.

#### Example Test Cases:
- **Valid Data**: Upload a CSV file with all required fields and valid data.
- **Missing Required Fields**: Upload a CSV file where certain required fields (e.g., ID, name) are missing.
- **Invalid Email Format**: Upload a CSV file where the email field contains an invalid format.
- **Age Out of Range**: Upload a CSV file where the age field contains values outside the allowed range.

### 6. Extend for Large Files
For larger files, consider implementing server-side validation. Instead of validating the entire file client-side, the file can be uploaded to the server, and the server can process the validation logic and return results.

#### Example Flow for Server-Side Validation:
1. **Client Uploads File**: The user uploads a file through the modal.
2. **Server Validates File**: The server validates the file in the background, checking for errors.
3. **Server  Validation Results**: The server returns validation errors (if any) to the client, which are then displayed in the modal.

### Testing
- **Validation Test**: Test files with valid and invalid data to ensure that errors are accurately captured and displayed.
- **Large File Test**: Test the behavior of the modal with large files to ensure that the validation process remains responsive.
- **Edge Case Test**: Test edge cases such as empty files, corrupted files, and files with extreme data values (e.g., very large integers or strings).

### External Dependencies
- File reading and parsing libraries (e.g., `FileReader` for client-side file parsing).
- Validation frameworks (if server-side validation is implemented).

## Acceptance Criteria
- Should have a bulk upload modal that allows users to upload files.
- Should validate the uploaded file based on predefined rules (e.g., required fields, data types).
- Should display validation errors in the modal for user review and correction.
- Should prevent the user from uploading invalid data until all validation errors are resolved.
- Should have tested the validation mechanism to ensure that valid data passes and invalid data fails.

### Gherkin
#### Scenario: Validating Bulk Upload Data
Given the user is uploading a bulk data file,
When the file contains missing or invalid fields,
Then the system should display validation errors and prevent the upload.

#### Scenario: Uploading Valid Data
Given the user is uploading a bulk data file,
When the file contains valid data,
Then the system should allow the file to be uploaded without errors.

## External Links
- [FileReader API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/FileReader)
- [React File Upload Example](https://reactjs.org/docs/uncontrolled-components.html#the-file-input-tag)
