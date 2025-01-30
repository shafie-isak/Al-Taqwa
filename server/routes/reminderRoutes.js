import express from 'express';
import authMiddleware from '../middlewares/authMiddleware.js';
import {
    createReminder,
    getReminders,
    updateReminder,
    deleteReminder,
    toggleToDo,
    markAsCompleted,
} from '../controllers/reminderController.js';

const router = express.Router();

// Routes
router.post('/add', authMiddleware ,createReminder); 
router.get('/getreminders', authMiddleware ,getReminders); 
router.put('/update/:id', authMiddleware ,updateReminder); 
router.delete('/delete/:id', authMiddleware ,deleteReminder); 
router.put('/toggle-todo/:id', authMiddleware , toggleToDo); 
router.put('/:id/mark-completed', authMiddleware, markAsCompleted);

export default router;