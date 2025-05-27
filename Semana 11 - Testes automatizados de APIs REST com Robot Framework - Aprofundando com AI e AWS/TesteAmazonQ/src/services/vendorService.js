const validator = require('validator');
const bcrypt = require('bcryptjs');

class VendorService {
    constructor() {
        this.vendors = new Map();
    }

    validateVendor(vendorData) {
        const { name, email, password } = vendorData;

        // Check for mandatory fields
        if (!name || !email || !password) {
            return {
                isValid: false,
                message: 'All fields are mandatory'
            };
        }

        // Validate name length and content
        if (name.length < 2 || name.length > 100) {
            return {
                isValid: false,
                message: 'Name must be between 2 and 100 characters'
            };
        }

        // Validate email format
        if (!validator.isEmail(email)) {
            return {
                isValid: false,
                message: 'The email is invalid'
            };
        }

        // Check if email is already in use
        if (this.vendors.has(email.toLowerCase())) {
            return {
                isValid: false,
                message: 'The email is already in use'
            };
        }

        // Validate password length
        if (password.length < 5) {
            return {
                isValid: false,
                message: 'The password must have at least 5 characters'
            };
        }

        if (password.length > 10) {
            return {
                isValid: false,
                message: 'The password must have at most 10 characters'
            };
        }

        return {
            isValid: true
        };
    }

    async registerVendor(vendorData) {
        try {
            const validation = this.validateVendor(vendorData);
            
            if (!validation.isValid) {
                return {
                    success: false,
                    message: validation.message
                };
            }

            // Hash password
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(vendorData.password, salt);

            // Store vendor with hashed password
            this.vendors.set(vendorData.email.toLowerCase(), {
                name: vendorData.name,
                email: vendorData.email.toLowerCase(),
                password: hashedPassword,
                createdAt: new Date()
            });

            return {
                success: true,
                message: 'Vendor successfully registered'
            };
        } catch (error) {
            console.error('Error in vendor registration:', error);
            return {
                success: false,
                message: 'An error occurred during registration'
            };
        }
    }
}

module.exports = VendorService;