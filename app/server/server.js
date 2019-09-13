/**
 * @module Server
 */

import bodyParser from 'body-parser';
import morgan from 'morgan';
import logger from '~/lib/logger';
import Router from '~/server/router';

class Server {
    /**
     * Sets port, starts middlewares and router
     * @param {Restify} app
     */
    constructor(app) {
        this.app = app;
        this.port = process.env.PORT || 8000;
        this.middlewares();
        this.router = new Router(app);
    }

    /**
     * Defines app midlewares
     */
    middlewares() {
        this.app.use(morgan('tiny'));
        this.app.use(bodyParser.json());
    }

    /**
     * Serves app at default port
     */
    listen() {
        this.app.listen(this.port, () => logger.info(`server listen at port ${this.port}`));
    }
}

export default Server;
