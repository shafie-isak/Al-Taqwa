import Reminder from '../models/reminder.js';


// Create a new reminder
export const createReminder = async (req, res) => {
    try {
        const reminder = new Reminder({ ...req.body, userId: req.user.id });
        await reminder.save();
        res.status(201).json(reminder);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};


// Get all reminders for a user
export const getReminders = async (req, res) => {
    try {
        const reminders = await Reminder.find({ userId: req.user.id });
        res.status(200).json(reminders);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

export const updateReminder = async (req, res) => {
    try {
        const reminder = await Reminder.findOneAndUpdate(
            { _id: req.params.id, userId: req.user.id },
            req.body, 
            { new: true }
        );
        if (!reminder) return res.status(404).json({ error: 'Reminder not found' });
        res.status(200).json(reminder);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};


// Delete a reminder
export const deleteReminder = async (req, res) => {
    try {
        const reminder = await Reminder.findOneAndDelete({
            _id: req.params.id,
            userId: req.user.id,
        });
        if (!reminder) return res.status(404).json({ error: 'Reminder not found' });
        res.status(200).json({ message: 'Reminder deleted successfully' });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};


// Mark a reminder as a To-do
export const setAsToDo = async (req, res) => {
    try {
        const reminder = await Reminder.findOneAndUpdate(
            { _id: req.params.id, userId: req.user.id },
            { isToDo: true },
            { new: true }
        );
        if (!reminder) return res.status(404).json({ error: 'Reminder not found' });
        res.status(200).json(reminder);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};


// Mark a To-do as completed
export const markAsCompleted = async (req, res) => {
    try {
        const reminder = await Reminder.findOneAndUpdate(
            { _id: req.params.id, userId: req.user.id, isToDo: true },
            { completed: true },
            { new: true }
        );

        if (!reminder) { 
            return res.status(404).json({ error: 'To-do not found' });
        }
        res.status(200).json(reminder);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};