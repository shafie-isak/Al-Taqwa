import express from 'express';
import authMiddleware from '../middlewares/authMiddleware.js';
import {
    createReminder,
    getReminders,
    updateReminder,
    deleteReminder,
    toggleToDo,
    markAsCompleted,
    getToDos
} from '../controllers/reminderController.js';

const router = express.Router();

// Routes
router.post('/add', createReminder); 
router.get('/getreminders', getReminders); 
router.put('/update/:id',authMiddleware, updateReminder); 
router.delete('/delete/:id', deleteReminder); 
router.put('/toggle-todo/:id',authMiddleware, toggleToDo); 
router.get("/get-todos", authMiddleware, getToDos);
router.put('/toggle-complete/:id', markAsCompleted);

export default router;