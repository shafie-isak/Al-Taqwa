import express from 'express';
import { getDuas, getDuaById } from '../controllers/duaController.js';
import authMiddleware from '../middlewares/authMiddleware.js';

const router = express.Router();

// Routes
router.get('/', getDuas);
router.get('/:id',getDuaById);

export default router;