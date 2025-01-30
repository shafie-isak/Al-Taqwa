import Reminder from '../models/reminder.js';


// Create a new reminder
export const createReminder = async (req, res) => {
    try {
        const { title, recurringDays, time } = req.body;
        if (!title || !time) {
            return res.status(400).json({ error: 'Title and time required' });
        }

        const reminder = new Reminder({
            title,
            recurringDays,
            time,
            userId: req.user.id, // Add userId from authenticated user
        });

        await reminder.save();
        res.status(201).json(reminder);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

// Get all reminders for a user
export const getReminders = async (req, res) => {
    try {
        const reminders = await Reminder.find({ userId: req.user.id }); // Fetch reminders for the logged-in user
        res.status(200).json(reminders);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

export const updateReminder = async (req, res) => {
    try {
        const reminder = await Reminder.findOneAndUpdate(
            { _id: req.params.id, userId: req.user.id }, // Ensure the reminder belongs to the user
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
        });
        if (!reminder) return res.status(404).json({ error: 'Reminder not found' });
        res.status(200).json({ message: 'Reminder deleted successfully' });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};


// Mark a reminder as a To-do
// ✅ Toggle the isToDo status
export const toggleToDo = async (req, res) => {
    try {
      // Find the current reminder
      const reminder = await Reminder.findById(req.params.id);
      
      if (!reminder) {
        return res.status(404).json({ error: "Reminder not found" });
      }
  
      // Toggle the isToDo status
      const updatedReminder = await Reminder.findByIdAndUpdate(
        req.params.id,
        { isToDo: !reminder.isToDo }, 
        { new: true }
      );
  
      res.status(200).json(updatedReminder);
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