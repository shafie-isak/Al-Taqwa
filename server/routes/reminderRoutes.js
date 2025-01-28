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
router.post('/add', createReminder); 
router.get('/getreminders', getReminders); 
router.put('/update/:id', updateReminder); 
router.delete('/delete/:id', deleteReminder); 
router.put('/toggle-todo/:id',  toggleToDo); 
router.put('/:id/mark-completed', authMiddleware, markAsCompleted);

export default router;