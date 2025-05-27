# ServeRest Marketplace

This project implements a vendor registration system for the ServeRest Marketplace.

## Features

- Vendor registration with validation for:
  - Mandatory fields (name, email, password)
  - Email format and uniqueness
  - Password length (5-10 characters)

## Installation

```bash
npm install
npm install cors
```

### CORS Configuration

The API includes CORS support out of the box. By default, it allows requests from any origin ('*'). 
You can configure allowed origins by setting the `ALLOWED_ORIGINS` environment variable as a comma-separated list:

```bash
ALLOWED_ORIGINS=https://example.com,https://app.example.com
```

The following CORS settings are configured:
- Methods: GET, POST
- Allowed Headers: Content-Type

## Running the Tests

```bash
npm test
```

## API Endpoints

### POST /vendors/register

Register a new vendor with the following fields:
- name (required)
- email (required, must be valid and unique)
- password (required, must be 5-10 characters)

#### Success Response
- Status: 201
- Body: `{ "message": "Vendor successfully registered" }`

#### Error Responses
- Status: 400
- Body: `{ "message": "<error message>" }`

Possible error messages:
- "All fields are mandatory"
- "The email is invalid"
- "The email is already in use"
- "The password must have at least 5 characters"
- "The password must have at most 10 characters"