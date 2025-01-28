import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import connectDB from './config/db.js';
import authRoutes from './routes/authRoutes.js';
import reminderRoutes from './routes/reminderRoutes.js';

dotenv.config();
const app = express();
app.use(cors());
connectDB();

app.use(express.json());
const PORT = 5000;


// Routes
app.use('/api/auth', authRoutes);
app.use('/api/reminders', reminderRoutes);


app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
