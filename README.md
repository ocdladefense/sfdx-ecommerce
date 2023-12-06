# sfdx-ecommerce
## About
Sfdx-ecommerce is an implementation of the Authorize.net SOAP API for the Salesforce Apex programming language.  It uses the `application/json` Content-Type for both requests and responses and supports both Authorize.net sandboxes and production environments.  For more information, see the Authorize.net documentation or the code examples, below.
## Installation
## Examples
### Process a Transaction
```java
AuthorizeDotNetClient client = new AuthorizeDotNetClient();
CreateTransactionRequest req = new CreateTransactionRequest();

AuthorizeDotNetResponse resp = client.send(req);
```
### Retrieve a Customer Profile
```java
// Example code here.
```
### Create a Customer Payment Profile
```java
// Example code here.
```
### Create a Shipping Address
```java
// Example code here.
```
