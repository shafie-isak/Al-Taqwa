import jwt from 'jsonwebtoken';

const blacklist = new Set();

const authMiddleware = (req, res, next) => {
    const token = req.header('Authorization')?.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Access denied. No token provided.' });
    }

    // Check if the token is blacklisted
    if (blacklist.has(token)) {
        return res.status(403).json({ error: 'Access denied. Token has been revoked.' });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; 
        next();
    } catch (err) {
        return res.status(401).json({ error: 'Invalid token.' });
    }
};

export default authMiddleware;