import mongoose from 'mongoose';

/**
 * @class Contact
 */
const contactSchema = new mongoose.Schema({
    'email': String
});

export default mongoose.model('contact', contactSchema);
