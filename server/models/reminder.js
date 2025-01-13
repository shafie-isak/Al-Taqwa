import mongoose from 'mongoose';

const ReminderSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    title: { type: String, required: true },
    description: { type: String },
    time: { type: Date, required: true },
    recurringDays: { type: [String], default: [] },
    isToDo: { type: Boolean, default: false },
    completed: { type: Boolean, default: false }, 
}, { timestamps: true });

export default mongoose.model('Reminder', ReminderSchema);