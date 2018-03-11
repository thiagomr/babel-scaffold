import mongoose, { Schema } from 'mongoose';

const ContactSchema = new Schema({
    'email': String,
    'created_at': Number,
});

ContactSchema.index({ "email": 1 }, { 'unique': true });

export default mongoose.model('Contact', ContactSchema);
