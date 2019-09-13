import mongoose from 'mongoose';

const contactSchema = new mongoose.Schema({
    'email': String
});

export default mongoose.model('contact', contactSchema);
