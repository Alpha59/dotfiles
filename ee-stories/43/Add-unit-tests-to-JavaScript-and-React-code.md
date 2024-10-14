
# Add unit tests to JavaScript/React code
### Summary
**As a** Software Engineer, **I want** to add unit tests to JavaScript/React code, **So That** we can ensure that individual components and functions behave as expected and catch potential bugs early in the development process.

This story focuses on setting up and writing unit tests for JavaScript and React components using common testing libraries such as **Jest** and **React Testing Library**. Unit testing ensures that small, isolated pieces of code work correctly, which leads to more robust and maintainable code.

### Vision
By implementing unit tests for JavaScript/React code, we improve code quality, reduce the risk of introducing bugs, and facilitate easier refactoring. Automated unit tests provide fast feedback during development, improving the overall development workflow and product reliability.

### Background
Unit tests are essential for testing the smallest units of functionality in code (e.g., functions, methods, components). For React applications, this includes testing individual components and their behavior, ensuring that components render correctly and handle interactions as expected. Using libraries like **Jest** and **React Testing Library**, we can simulate component rendering, state changes, and user interactions in isolation.

---

### Steps to Add Unit Tests to JavaScript/React Code

#### 1. **Install Testing Dependencies**

Start by installing the necessary testing libraries for JavaScript and React.

- **Jest**: Jest is a widely-used testing framework for JavaScript that provides a complete test runner, assertions, and mocking capabilities.
- **React Testing Library**: This library provides utilities to test React components without relying on implementation details.

Install the required libraries using npm:

```bash
# Install Jest and React Testing Library
npm install --save-dev jest @testing-library/react @testing-library/jest-dom
```

You may also need to install `babel-jest` if you're using Babel to compile your JavaScript code:

```bash
npm install --save-dev babel-jest @babel/preset-env @babel/preset-react
```

---

#### 2. **Set Up Jest Configuration**

Create a Jest configuration file (`jest.config.js`) to customize the behavior of the Jest test runner. This file ensures that Jest can correctly interpret JSX and ES6+ syntax when testing React components.

Example `jest.config.js`:

```javascript
module.exports = {
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  testEnvironment: 'jsdom',
  transform: {
    '^.+\.(js|jsx)$': 'babel-jest',
  },
  moduleFileExtensions: ['js', 'jsx'],
};
```

Additionally, set up Babel presets in your `.babelrc` file to compile modern JavaScript and JSX:

Example `.babelrc`:

```json
{
  'presets': ['@babel/preset-env', '@babel/preset-react']
}
```

In your `jest.setup.js` file, you can configure Jest to use `@testing-library/jest-dom` for DOM-related assertions:

```javascript
import '@testing-library/jest-dom/extend-expect';
```

---

#### 3. **Write Unit Tests for JavaScript Functions**

For standard JavaScript functions, you can write unit tests that validate the function's behavior by providing input and asserting the expected output.

Here’s an example function and corresponding unit test:

Example `sum.js` file:

```javascript
export const sum = (a, b) => a + b;
```

Example unit test (`sum.test.js`):

```javascript
import { sum } from './sum';

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});

test('adds 0 + 5 to equal 5', () => {
  expect(sum(0, 5)).toBe(5);
});
```

Run the test using the following command:

```bash
npm run test
```

---

#### 4. **Write Unit Tests for React Components**

To test React components, use **React Testing Library** to simulate rendering, interactions, and state changes.

Example React component (`Button.js`):

```javascript
import React from 'react';

const Button = ({ label, onClick }) => (
  <button onClick={onClick}>{label}</button>
);

export default Button;
```

Example unit test (`Button.test.js`):

```javascript
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import Button from './Button';

test('renders button with label', () => {
  render(<Button label='Click me' />);
  const buttonElement = screen.getByText(/Click me/i);
  expect(buttonElement).toBeInTheDocument();
});

test('calls onClick handler when clicked', () => {
  const handleClick = jest.fn();
  render(<Button label='Click me' onClick={handleClick} />);
  const buttonElement = screen.getByText(/Click me/i);

  fireEvent.click(buttonElement);
  expect(handleClick).toHaveBeenCalledTimes(1);
});
```

- The `render` function from **React Testing Library** simulates rendering the component.
- The `screen.getByText` method allows querying the DOM to find specific elements.
- The `fireEvent.click` method simulates user interaction with the button.

---

#### 5. **Test State Changes and Component Behavior**

For more complex React components that maintain state or interact with other components, you can test state changes and behavior using React Testing Library's utilities.

Example stateful component (`Counter.js`):

```javascript
import React, { useState } from 'react';

const Counter = () => {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
};

export default Counter;
```

Example unit test (`Counter.test.js`):

```javascript
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import Counter from './Counter';

test('increments count when button is clicked', () => {
  render(<Counter />);

  const countElement = screen.getByText(/Count: 0/i);
  expect(countElement).toBeInTheDocument();

  const buttonElement = screen.getByText(/Increment/i);
  fireEvent.click(buttonElement);

  const updatedCountElement = screen.getByText(/Count: 1/i);
  expect(updatedCountElement).toBeInTheDocument();
});
```

- The test checks that the initial state (`Count: 0`) is rendered correctly.
- It then simulates a click event on the increment button and verifies that the component's state updates (`Count: 1`).

---

#### 6. **Mock External Dependencies**

If your components or functions rely on external services (e.g., API calls, Redux actions), you can use **Jest mocks** to simulate these dependencies in unit tests.

Example mocking an API call in a component (`UserProfile.js`):

```javascript
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const UserProfile = ({ userId }) => {
  const [user, setUser] = useState(null);

  useEffect(() => {
    axios.get(`/api/users/$\{userId}`).then((response) => {
      setUser(response.data);
    });
  }, [userId]);

  return user ? <div>{user.name}</div> : <div>Loading...</div>;
};

export default UserProfile;
```

Example test with a mocked API call (`UserProfile.test.js`):

```javascript
import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import axios from 'axios';
import UserProfile from './UserProfile';

jest.mock('axios');

test('fetches and displays user profile', async () => {
  const mockUser = { name: 'John Doe' };
  axios.get.mockResolvedValue({ data: mockUser });

  render(<UserProfile userId={1} />);

  expect(screen.getByText(/Loading.../i)).toBeInTheDocument();

  await waitFor(() => expect(screen.getByText(/John Doe/i)).toBeInTheDocument());
});
```

- **jest.mock('axios')**: Mock the `axios` library.
- The test verifies that the loading state is rendered first, followed by the user’s name after the API call is resolved.

---

#### 7. **Run Unit Tests**

To run all the tests, execute the following command:

```bash
npm run test
```

Jest will automatically discover and run all files ending with `.test.js` or `.spec.js`.

For continuous testing during development, you can enable Jest’s watch mode:

```bash
npm run test -- --watch
```

---

### 8. **Test Coverage**

You can configure Jest to collect code coverage data by adding the following to your Jest configuration (`jest.config.js`):

```javascript
module.exports = {
  collectCoverage: true,
  coverageDirectory: 'coverage',
  collectCoverageFrom: ['src/**/*.js', 'src/**/*.jsx'],
};
```

Run the tests with coverage:

```bash
npm run test -- --coverage
```

Jest will generate a coverage report indicating which parts of your code are covered by tests.

---

### Acceptance Criteria
- Should have written unit tests for key JavaScript functions.
- Should have written unit tests for React components, including rendering and state changes.
- Should be able to mock external dependencies in unit tests.
- Should have configured the test environment using Jest and React Testing Library.
- Should have verified that all tests pass with adequate coverage.
