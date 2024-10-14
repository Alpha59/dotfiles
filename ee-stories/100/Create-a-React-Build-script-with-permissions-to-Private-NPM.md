
# Create a React Build script with permissions to Private NPM
*Only completed once, code should be re-usable for each of the 4 Web Applications*

### **Summary**:

**As a** developer, **I want** to create a React Build script with permissions to Internal NPM **so that** I streamline the build process for our React applications.

### **Description:**

1. **Configure Webpack for Development:**
    1. Navigate to the root of your React application and locate the `webpack.dev.config.js` configuration file.
    2. Modify the `output` section to ensure your bundled files are stored in the `build` folder. Use the following code snippet:

```
`     const path = require('path');`
`     // ...`
`     output: {`
`         clean: true,`
`         filename: '[name].bundle.[fullhash].js',`
`         chunkFilename: '[id].[name].[fullhash].js',`
`         path: path.resolve(__dirname, 'build/dev'),`
`     },`
```



1. **Configure Webpack for Production:**
    1. Locate the `webpack.prod.config.js` configuration file.
    2. Modify the `output` section to store bundled artifacts in the `build/public` folder. Use the following code snippet:

```
`     const path = require('path');`
`     // ...`
`     output: {`
`         clean: true,`
`         filename: '[name].bundle.[fullhash].js',`
`         chunkFilename: '[id].[name].[fullhash].js',`
`         path: path.resolve(__dirname, 'build/public'),`
`     }`
```

1. **Update package.json:**
    1. Open your `package.json` file.
    2. Ensure that your app name follows the format `@amzn/YourAppName` without spaces and starting with an uppercase letter. Modify the `'name'` attribute. Replace `<YourAppName>` with the appropriate name.

* Replace the `'scripts'` section with the following code to define node scripts that you can run with Brazil-Build:

```
`     'scripts': {`
`         'server': 'webpack serve --config ./webpack.dev.config.js',`
`         'build': 'webpack --config ./webpack.prod.config.js',`
`         'release': 'webpack --config ./webpack.prod.config.js',`
`         'prebuild': 'rm -rf build/'`
`     }`
```

* Add the following sections to your `package.json` as needed:

```
`     'npm-pretty-much': {`
`         'ciBuild': 'never',`
`         'runRelease': 'always',`
`         'runTest': 'always'`
`     },`
`     'devDependencies': {`
`         'html-webpack-plugin': '^5.5.0',`
`         'interpolate-html-plugin': '^4.0.0',`
`         'sass': '^1.49.11',`
`         'ts-loader': '^9.2.9',`
`         'webpack-bundle-analyzer': '^4.5.0',`
`         'webpack-cli': '^4.9.2',`
`         'webpack-dev-server': '^4.8.1'`
`     }`
```

1. **Run React Application Locally:**
    1. Confirm that your React application is configured correctly by running it locally. Use the following commands:

```
`brazil-build`
`brazil-build run server`
```

### **Acceptance Criteria:**

* **Should have**:React application configured for use with AWS CDK and AWS Amplify.
* **Should have**:Application running without issues in the local development environment.
* **Should have**:Changes committed and pushed to the Git repository.
