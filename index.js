import 'dotenv/config';
import restify from 'restify';
import Mongo from '~/config/mongo';
import Server from '~/server/server';
import logger from '~/lib/logger';

(async function () {
    try {
        const mongo = new Mongo(`mongodb://${process.env.MONGO_HOST}/${process.env.MONGO_SCHEMA}`);
        const server = new Server(restify.createServer());

        await mongo.connect();
        await server.listen();
    } catch (e) {
        logger.error(e);
    }
})();
