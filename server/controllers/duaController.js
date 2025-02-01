import Dua from '../models/duaModel.js';

export const getDuas = async (req, res) => {
  try {
    const duas = await Dua.find();
    res.status(200).json(duas);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

export const getDuaById = async (req, res) => {
  try {
    const dua = await Dua.findById(req.params.id);
    if (!dua) return res.status(404).json({ error: 'Dua not found' });
    res.status(200).json(dua);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};