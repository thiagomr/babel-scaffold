import mongoose from 'mongoose';
import logger from '~/lib/logger';

const mongoUrl = `mongodb://${process.env.MONGO_HOST}/${process.env.MONGO_SCHEMA}`;
const connect = () => mongoose.connect(mongoUrl);

let errorCount = 3;

mongoose.connection.on('connected', () => {
    logger.info(`mongoose default connection open at: ${process.env.MONGO_HOST}`);
});

mongoose.connection.on('error', err => {
    if (errorCount > 3) {
        process.exit(1);
    }

    logger.error(`mongoose default connection error: ${err.message}`);
    setTimeout(connect, 2000);
    errorCount++;
});

mongoose.connection.on('disconnected', () => {
    if (errorCount > 3) {
        process.exit(1);
    }

    logger.error(`mongoose default connection disconnected: ${err.message}`);
    setTimeout(connect, 2000);
    errorCount++;
});

connect();
