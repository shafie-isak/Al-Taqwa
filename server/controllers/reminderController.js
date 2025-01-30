import Reminder from '../models/reminder.js';


// Create a new reminder
export const createReminder = async (req, res) => {
    try {
        console.log("Incoming data: ", req.body);
        const { title, recurringDays, time } = req.body;
        if (!title || !time) {
            return res.status(400).json({error: 'Title and time required'});

        }
        const reminder = new Reminder ({
            title,
            recurringDays,
            time
        });

        await reminder.save();
        res.status(201).json(reminder);
    } catch (err) {
        console.log("error creating reminder: ", err);
        res.status(400).json({ error: err.message });
    }
};


// Get all reminders for a user
export const getReminders = async (req, res) => {
    try {
        const reminders = await Reminder.find({});
        res.status(200).json(reminders);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

export const updateReminder = async (req, res) => {
    try {
        const reminder = await Reminder.findOneAndUpdate(
            { _id: req.params.id },
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
  

  export const getToDos = async (req, res) => {
    try {
        const todos = await Reminder.find({ isToDo: true });
        res.status(200).json(todos);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};




// Mark a To-do as completed
export const markAsCompleted = async (req, res) => {
    try {
        const todo = await Reminder.findById(req.params.id);
        if (!todo) {
            return res.status(404).json({ error: "To-do not found" });
        }

        const updatedTodo = await Reminder.findByIdAndUpdate(
            req.params.id,
            { completed: !todo.completed },
            { new: true }
        );

        res.status(200).json(updatedTodo);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};
