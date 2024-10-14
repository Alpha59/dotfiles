
# Create baseline common functional tests to clean persistent data that pertains to only the given test
### Summary
**As a** QA Engineer, **I want** to create baseline common functional tests that clean up persistent data only related to the given test, **So That** tests do not leave behind any artifacts or data, ensuring that each test case runs in isolation and the system remains in a clean state between test runs.

This story focuses on implementing common functional tests that automatically clean up any persistent data created during the execution of the test. This will ensure that each test runs independently, does not interfere with other tests, and maintains a clean testing environment.

### Vision
By implementing a common test cleanup mechanism, we ensure that each functional test can create, modify, and delete data without affecting other tests or the overall state of the system. This approach enhances test reliability, eliminates side effects between tests, and ensures data consistency across the testing environment.

### Background
Persistent data created during tests can lead to unintended side effects, causing tests to fail unpredictably or giving false positives. By implementing a robust data cleanup mechanism, we ensure that each test operates on a clean slate and that persistent data is removed once the test is completed. This approach is especially important in environments where database entries, file system artifacts, or third-party service interactions need to be cleaned up after the test.

### Purpose
The purpose of this story is to create baseline common functional tests that manage their own data, ensuring that persistent data created during the test is cleaned up after the test completes. This guarantees that tests do not interfere with one another, promoting reliable and reproducible test results.

## Details
### 1. Identify Persistent Data to Be Cleaned
- Identify the types of persistent data that need to be cleaned after each test, including:
  - **Database Records**: Data inserted into a database during the test.
  - **File System Artifacts**: Temporary files or directories created during the test.
  - **External API Interactions**: Any external services or APIs that persist data during the test.
  - **Cache and Sessions**: Any cache or session data that may need to be reset.

### 2. Use a Fixture or Setup/Teardown Pattern
Implement a fixture or a **setup/teardown** pattern in the tests to handle the creation and deletion of persistent data. This pattern ensures that any data created during the test is cleaned up after the test execution, regardless of whether the test passes or fails.

#### Example of Setup/Teardown Pattern in Python Using `unittest`:
```python
import unittest
import os

class TestPersistentDataCleanup(unittest.TestCase):

    def setUp(self):
        # Setup: Create temporary files or insert data into the database
        self.temp_file = 'temp_test_file.txt'
        with open(self.temp_file, 'w') as f:
            f.write('Test data')

        # Example of inserting data into a database
        # self.db_connection = create_db_connection()
        # self.db_connection.execute('INSERT INTO test_table (data) VALUES ('test_data')')

    def tearDown(self):
        # Teardown: Clean up persistent data
        if os.path.exists(self.temp_file):
            os.remove(self.temp_file)

        # Example of cleaning up database records
        # self.db_connection.execute('DELETE FROM test_table WHERE data='test_data'')
        # self.db_connection.close()

    def test_something(self):
        # Your test logic
        self.assertTrue(os.path.exists(self.temp_file))

if __name__ == '__main__':
    unittest.main()
```
- **setUp**: Runs before each test to create necessary persistent data.
- **tearDown**: Runs after each test to clean up the persistent data, ensuring the system is reset to a clean state.

### 3. Use Transaction Rollbacks for Database Cleanup
When working with databases, one of the most effective methods of cleaning up persistent data is to wrap the test in a database transaction and roll back the transaction at the end of the test. This ensures that all database operations performed during the test are undone, leaving the database in its original state.

#### Example Using Transaction Rollback in Python (SQLAlchemy):
```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# Create a database engine and session
engine = create_engine('sqlite:///:memory:')
Session = sessionmaker(bind=engine)
session = Session()

def test_with_transaction():
    connection = engine.connect()
    transaction = connection.begin()  # Start a transaction

    try:
        # Perform database operations within the transaction
        session.add(MyModel(data='test'))
        session.commit()

        # Test logic here...
        assert session.query(MyModel).count() == 1

    finally:
        # Roll back the transaction to undo changes
        transaction.rollback()
        connection.close()
```
- **transaction.rollback()**: Rolls back any changes made during the test, ensuring the database is returned to its pre-test state.

### 4. Automate Cleanup for Files and Temporary Directories
For tests that create files or directories, automate the cleanup process using fixtures or temporary file systems. The Python `tempfile` module or other utilities can help create and manage temporary files and directories, ensuring they are cleaned up after each test.

#### Example Using `tempfile` for Temporary File Cleanup:
```python
import tempfile
import os

class TestFileCleanup(unittest.TestCase):

    def setUp(self):
        # Create a temporary directory
        self.temp_dir = tempfile.TemporaryDirectory()

    def tearDown(self):
        # Automatically cleanup the temporary directory
        self.temp_dir.cleanup()

    def test_file_creation(self):
        # Create a temporary file within the temporary directory
        temp_file_path = os.path.join(self.temp_dir.name, 'test_file.txt')
        with open(temp_file_path, 'w') as f:
            f.write('Test content')
        self.assertTrue(os.path.exists(temp_file_path))

if __name__ == '__main__':
    unittest.main()
```
- **TemporaryDirectory()**: Creates a temporary directory that is automatically cleaned up after the test completes.

### 5. Use Mocking for External API Calls
For tests that interact with external APIs or services that persist data, use mocking to simulate the external service’s behavior without actually persisting data.

#### Example Using `unittest.mock` to Mock External API Calls:
```python
from unittest.mock import patch
import unittest
import requests

class TestExternalApiCalls(unittest.TestCase):

    @patch('requests.post')
    def test_api_call(self, mock_post):
        # Simulate a successful API response
        mock_post.return_value.status_code = 200

        # Call the actual function that makes the API request
        response = requests.post('https://example.com/api', data={'key': 'value'})

        # Assert the mock was called and verify response
        mock_post.assert_called_once()
        self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()
```
- **patch**: Mocks the external API call, preventing real data from being persisted and allowing the test to run in isolation.

### 6. Centralize Cleanup Logic in a Base Test Class
To ensure consistency and reuse, centralize the cleanup logic in a base test class. Each test case can inherit from this class, automatically benefiting from the setup and teardown functionality.

#### Example Base Test Class for Cleanup:
```python
class BaseTestWithCleanup(unittest.TestCase):

    def setUp(self):
        # Common setup logic for persistent data (e.g., database, files)
        pass

    def tearDown(self):
        # Common cleanup logic for persistent data
        # Example: Clean up database entries, temporary files, etc.
        pass

class TestSpecificFunctionality(BaseTestWithCleanup):

    def test_example(self):
        # This test automatically benefits from the setup and teardown methods
        pass
```

### 7. Add Logging and Debug Information for Cleanup Failures
In case of test failures during cleanup, add logging to capture information about what data was not cleaned up. This can help in debugging issues related to persistent data that remains after a test.

#### Example Logging in Cleanup:
```python
import logging

class BaseTestWithLogging(unittest.TestCase):

    def tearDown(self):
        try:
            # Cleanup logic
            self.clean_up_persistent_data()
        except Exception as e:
            logging.error(f'Failed to clean up data: {str(e)}')
            raise

    def clean_up_persistent_data(self):
        # Example cleanup logic
        pass
```

### 8. CI/CD Integration
Ensure that these baseline functional tests with cleanup mechanisms are integrated into the CI/CD pipeline. This ensures that persistent data is automatically cleaned up during automated test runs, preventing side effects across different tests in the pipeline.

### Testing
- **Data Creation Test**: Verify that persistent data (e.g., database entries or files) is correctly created during the test.
- **Data Cleanup Test**: Verify that all persistent data created during the test is cleaned up afterward, ensuring no residual data.
- **Failure Handling Test**: Simulate test failures and ensure that the cleanup mechanism still runs as expected.
- **Isolation Test**: Ensure that tests run in isolation, with no side effects or dependencies on other tests’ data.

### External Dependencies
- Integration with database systems, file systems, or external APIs.
- Use of libraries or frameworks for mocking, logging, and testing (e.g., `unittest`, `pytest`, `unittest.mock`).

## Acceptance Criteria
- Should have a functional test framework that automatically cleans up persistent data related to each test case.
- Should have implemented a setup/teardown pattern to handle creation and cleanup of persistent data.
- Should have tested the functionality of the cleanup mechanism by running tests that create and delete persistent data.
- Should have integrated the tests into the CI/CD pipeline to ensure isolation and cleanliness between test runs.

### Gherkin
#### Scenario: Cleaning Up Database Records After Test
Given a test inserts records into the database,
When the test finishes execution,
Then the inserted records should be deleted from the database.

#### Scenario: Cleaning Up Temporary Files After Test
Given a test creates temporary files,
When the test finishes execution,
Then the temporary files should be automatically removed.

#### Scenario: Mocking External API Calls in Tests
Given a test interacts with an external API,
When the test is executed,
Then the API call should be mocked, and no real data should be persisted.

## External Links
- [unittest Documentation](https://docs.python.org/3/library/unittest.html)
- [pytest Fixture Documentation](https://docs.pytest.org/en/stable/fixture.html)
- [SQLAlchemy Transactions](https://docs.sqlalchemy.org/en/14/core/connections.html)
