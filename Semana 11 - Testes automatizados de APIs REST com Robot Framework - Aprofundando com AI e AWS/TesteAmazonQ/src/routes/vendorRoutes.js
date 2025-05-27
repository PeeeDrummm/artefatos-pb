const express = require('express');
const router = express.Router();
const VendorService = require('../services/vendorService');
const { validateVendorRequest } = require('../middleware/validateRequest');

const vendorService = new VendorService();

const registerHandler = async (req, res, next) => {
    try {
        const result = await vendorService.registerVendor(req.body);
        
        if (!result.success) {
            return res.status(400).json({ message: result.message });
        }
        
        return res.status(201).json({ message: result.message });
    } catch (error) {
        next(error);
    }
};

// Attach vendorService to the handler for testing purposes
registerHandler.vendorService = vendorService;

router.post('/register', validateVendorRequest, registerHandler);

module.exports = router;