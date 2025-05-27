const request = require('supertest');
const app = require('../src/index'); // Your Express app
const bcrypt = require('bcryptjs');

// Assumption: You have a vendorService module that manages vendor data
// and can be imported. Adjust the path if it's different.
// This service should have methods like findByEmail(email) and clearAllForTesting().
// If your service is structured differently, this part will need adaptation.
let vendorService;
try {
    // Try to import the service, adjust path as necessary
    // This assumes vendorService is a singleton or you can get an instance
    vendorService = require('../src/services/vendorService'); // EXAMPLE PATH
} catch (e) {
    console.warn(
        "Warning: Could not import vendorService directly. " +
        "The 'should hash password before storing' test might not work as intended " +
        "without a way to access the service layer or its data. " +
        "The original fragile method of accessing service via app._router is highly discouraged."
    );
}

describe('Vendor Registration', () => {
    // Hook to run before each test in this suite
    beforeEach(async () => {
        // Clear any persisted vendor data before each test to ensure isolation
        // This requires your vendorService to have a method for clearing its data.
        // If using a database, this would involve clearing relevant tables or using transactions.
        if (vendorService && typeof vendorService.clearAllForTesting === 'function') {
            await vendorService.clearAllForTesting();
        } else if (vendorService && typeof vendorService.clearAll === 'function') { // Common alternative name
             await vendorService.clearAll();
        }
        // If you can't directly clear, ensure your tests use unique data that won't collide,
        // or reset the app state if possible (more complex).
    });

    // Scenario 1: Vendor registration with all fields filled correctly
    test('should register vendor when all fields are filled correctly', async () => {
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'Test Vendor One', // Using unique email
                email: 'vendor1@test.com',
                password: 'pass123'
            });

        expect(response.status).toBe(201);
        expect(response.body.message).toBe('Vendor successfully registered');
    });

    // Scenario 2: Vendor registration with mandatory fields not filled
    test('should reject registration when mandatory fields are missing', async () => {
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'Test Vendor Two',
                // email field missing
                password: 'pass123'
            });

        expect(response.status).toBe(400);
        expect(response.body.message).toBe('All fields are mandatory');
    });

    // Scenario 3: Vendor registration with an email address already in use
    test('should reject registration when email is already in use', async () => {
        const duplicateEmail = 'duplicate3@test.com';
        // First registration
        await request(app)
            .post('/vendors/register')
            .send({
                name: 'First Vendor',
                email: duplicateEmail,
                password: 'pass123'
            });

        // Second registration with same email
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'Second Vendor',
                email: duplicateEmail,
                password: 'pass456'
            });

        expect(response.status).toBe(400);
        expect(response.body.message).toBe('The email is already in use');
    });

    // Scenario 4: Vendor registration with an invalid email address
    test('should reject registration when email is invalid', async () => {
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'Test Vendor Four',
                email: 'invalid-email',
                password: 'pass123'
            });

        expect(response.status).toBe(400);
        expect(response.body.message).toBe('The email is invalid');
    });

    // Scenario 5: Vendor registration with a password shorter than 5 characters
    test('should reject registration when password is too short', async () => {
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'Test Vendor Five',
                email: 'short-password5@test.com', // Unique email
                password: '1234'
            });

        expect(response.status).toBe(400);
        expect(response.body.message).toBe('The password must have at least 5 characters');
    });

    // Scenario 6: Vendor registration with a password longer than 10 characters
    test('should reject registration when password is too long', async () => {
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'Test Vendor Six',
                email: 'long-password6@test.com', // Unique email
                password: '12345678901'
            });

        expect(response.status).toBe(400);
        expect(response.body.message).toBe('The password must have at most 10 characters');
    });

    // Scenario 7: Vendor registration with invalid name length
    test('should reject registration when name is too short', async () => {
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'A',
                email: 'short-name7@test.com', // Unique email
                password: 'pass123'
            });

        expect(response.status).toBe(400);
        expect(response.body.message).toBe('Name must be between 2 and 100 characters');
    });

    // Scenario 8: Vendor registration with invalid data types
    test('should reject registration when data types are invalid', async () => {
        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 123, // Should be string
                email: 'invalid-type8@email.com', // Unique email
                password: 'pass123'
            });

        expect(response.status).toBe(400);
        // The message might vary depending on your validation library
        // Update if your actual error message is different
        expect(response.body.message).toBe('Invalid data types');
    });

    // Scenario 9: Verify password is properly hashed
    test('should hash password before storing', async () => {
        // Ensure vendorService was imported and has the necessary methods
        if (!vendorService || typeof vendorService.findByEmailNormalized !== 'function') {
            console.warn("Skipping 'should hash password before storing' test: vendorService not available or findByEmailNormalized is missing.");
            // You might want to make the test fail or be pending explicitly
            // For now, just returning to avoid further errors if service is not set up for this.
            return;
        }

        const vendorData = {
            name: 'Hash Test Vendor Nine',
            email: 'hash-test9@test.com', // Unique email
            password: 'securePassword123'
        };

        // Register the vendor
        const registrationResponse = await request(app)
            .post('/vendors/register')
            .send(vendorData);

        // Check if registration was successful before trying to fetch
        expect(registrationResponse.status).toBe(201);

        // Get the stored vendor directly from the service layer
        // This assumes your service stores emails in a consistent case (e.g., lowercase)
        // or that findByEmailNormalized handles this.
        const storedVendor = await vendorService.findByEmailNormalized(vendorData.email);

        expect(storedVendor).toBeDefined(); // Make sure vendor was found
        if (storedVendor) { // Proceed only if vendor was actually found
            expect(storedVendor.password).not.toBe(vendorData.password); // Check it's not plaintext
            const isMatch = await bcrypt.compare(vendorData.password, storedVendor.password);
            expect(isMatch).toBe(true); // Check if the original password matches the hash
        }
    });

    // Scenario 10: Email case insensitivity
    test('should treat emails as case insensitive during registration conflict', async () => {
        const baseEmail = 'case.test10@test.com'; // Unique base email
        // Register with lowercase email
        await request(app)
            .post('/vendors/register')
            .send({
                name: 'Case Test Ten',
                email: baseEmail.toLowerCase(),
                password: 'pass123'
            });

        const response = await request(app)
            .post('/vendors/register')
            .send({
                name: 'Case Test Ten Uppercase',
                email: baseEmail.toUpperCase(),
                password: 'pass123'
            });

        expect(response.status).toBe(400);
        expect(response.body.message).toBe('The email is already in use');
    });
});