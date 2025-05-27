const validateVendorRequest = (req, res, next) => {
    const { name, email, password } = req.body;

    // Check if body exists and has the right format
    if (!req.body || typeof req.body !== 'object') {
        return res.status(400).json({
            message: 'Invalid request format'
        });
    }

    // Check for mandatory fields
    if (!name || !email || !password) {
        return res.status(400).json({
            message: 'All fields are mandatory'
        });
    }

    // Check data types
    if (
        typeof name !== 'string' ||
        typeof email !== 'string' ||
        typeof password !== 'string'
    ) {
        return res.status(400).json({
            message: 'Invalid data types'
        });
    }

    // Sanitize inputs
    req.body.name = name.trim();
    req.body.email = email.trim().toLowerCase();

    next();
};

module.exports = { validateVendorRequest };