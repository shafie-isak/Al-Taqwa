import mongoose from 'mongoose';

const ReminderSchema = new mongoose.Schema({
    title: { type: String, required: true },
    time: { type: String, required: true },
    recurringDays: { type: [String], default: [] },
    isToDo: { type: Boolean, default: false },
    completed: { type: Boolean, default: false },
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }, // Add userId
});

export default mongoose.model('Reminder', ReminderSchema);