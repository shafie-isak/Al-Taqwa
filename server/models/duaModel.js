import mongoose from 'mongoose';

const duaSchema = new mongoose.Schema({
  title: { type: String, required: true },
  image: { type: String, required: true },
  sub_duas: [{
    title: { type: String, required: true },
    arabicDua: { type: String, required: true },
    translation: { type: String, required: true },
    repeat: { type: Number, required: true }
  }]
});

export default mongoose.model('duas', duaSchema);