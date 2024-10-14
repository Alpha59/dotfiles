
# Add Domain and Certificate to CloudFront
*Only completed once, code should be re-usable for each of the 4 Web Applications*

### **Summary:**

**As a** developer, **I want** to configure CloudFront to use a custom domain and an SSL certificate for our React application so that I have enhanced security and provide a more professional appearance.

This configuration should be applied using the provided CDK code.

### Background:

In our existing React application, we need to configure CloudFront to use a custom domain and an SSL certificate for enhanced security and a more professional appearance. This story outlines the steps to achieve this using the provided CDK code.

* Initialize DNS Stack:
    *  Create a new Cloud Development Kit (CDK) stack for DNS configuration. This stack is responsible for DNS-related settings.
* Provide Environment Details
    *   Ensure you have the necessary environment details, including `environmentName`, `stage`, `environmentConfig`, and `vpc`.
* Configure Custom Domain:
    * Follow the DNSStack (DnsStack) to configure a custom domain for your CloudFront distribution. This involves specifying the domain name and other domain-related settings.
* Configure CloudFront:
    * Using the CDK, configure the CloudFront distribution to use the custom domain as its origin and associate it with the SSL certificate for secure access.
* Test Configuration:
    *  After configuring CloudFront with the custom domain and SSL certificate, thoroughly test the setup to ensure it works as expected.

```
        const dnsStack = new DnsStack(app, `$\{environmentName}-Dns`, {
              env: environment,
              stage: stage.name,
              region: environmentConfig.region,
              shortName: 'drop',
              hostedZoneId: 'Z0726560118E4FOCB5GJ6',
              hostedZoneName: 'reverse-logistics.devices.amazon.dev',
              softwareType: SoftwareType.INFRASTRUCTURE,
              vpc: vpc.vpc,
          });

    // Define your custom domain name
    const domainName = 'reverse-logistics.devices.amazon.dev';

    // Create a CloudFront Web Distribution
    const distribution = new cloudfront.CloudFrontWebDistribution(this, 'AmplifyDistribution', {
      viewerProtocolPolicy: cloudfront.ViewerProtocolPolicy.REDIRECT_TO_HTTPS,
      originConfigs: [
        {
          customOriginSource: {
            domainName: 'amplify-app-id.amplifyapp.com', // Replace with your Amplify app ID
          },
          behaviors: [
            {
              isDefaultBehavior: true,
            },
          ],
        },
      ],
      errorConfigurations: [
        {
          errorCode: 403,
          responsePagePath: '/index.html',
          responseCode: 200,
        },
        {
          errorCode: 404,
          responsePagePath: '/index.html',
          responseCode: 200,
        },
      ],
    });

    // Define the CloudFront alias for your custom domain
    const domain = new cloudfront.AliasRecord(this, 'DomainAlias', {
      recordName: domainName,
      target: cloudfront.RecordTarget.fromAlias(new origins.CloudFrontWebDistribution(distribution)),
      zone: route53.HostedZone.fromHostedZoneAttributes(this, 'HostedZone', {
        hostedZoneId: 'Z0726560118E4FOCB5GJ6',
        zoneName: 'reverse-logistics.devices.amazon.dev',
      }),
    });
  }
```

### **Acceptance Criteria:**

* **Should Have:** Custom domain settings configured in the DNSStack (DnsStack).
* **Should Have:** CloudFront configured with the custom domain and SSL certificate.
* **Should Have:** SSL certificate associated with the CloudFront distribution.
* **Should Have:** Successful testing of CloudFront with the custom domain.
* **Should Have:** Verification that the SSL certificate provides secure access.
* **Should Have:** Detailed documentation of the CloudFront configuration and its integration with the custom domain and SSL certificate.
* **Should Have:** The CDK code should be reusable for other web applications.
