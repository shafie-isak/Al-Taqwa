import express from 'express';
import authMiddleware from '../middlewares/authMiddleware.js';
import {
    createReminder,
    getReminders,
    updateReminder,
    deleteReminder,
    setAsToDo,
    markAsCompleted,
} from '../controllers/reminderController.js';

const router = express.Router();

// Routes
router.post('/', authMiddleware, createReminder); 
router.get('/', authMiddleware, getReminders); 
router.put('/:id', authMiddleware, updateReminder); 
router.delete('/:id', authMiddleware, deleteReminder); 
router.put('/:id/set-todo', authMiddleware, setAsToDo); 
router.put('/:id/mark-completed', authMiddleware, markAsCompleted);

export default router;