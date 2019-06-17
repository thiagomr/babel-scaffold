import { Mongoose } from 'mongoose';
import logger from '~/lib/logger';

class MongoConnection {
    constructor(url) {
        this.mongoose = new Mongoose();
        this.url = url;
        this.options = {
            reconnectTries: 5,
            reconnectInterval: 2000,
            useNewUrlParser: true
        }

        this.mongoose.connection.on('connected', () => logger.info('mongo connected'));
        this.mongoose.connection.on('error', () => logger.error('mongo error'));
        this.mongoose.connection.on('disconnected', () => logger.warn('mongo disconnected'));
        this.mongoose.connection.on('reconnectFailed', () => logger.error('mongo failed'));
    }

    async connect() {
        await this.mongoose.connect(this.url, this.options);
    }

    async disconnect() {
        await this.mongoose.disconnect();
    }
}

export default MongoConnection;
