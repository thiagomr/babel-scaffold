import bodyParser from 'body-parser';
import morgan from 'morgan';
import logger from '~/lib/logger';
import Router from '~/server/router';

class Server {
    constructor(app) {
        this.app = app;
        this.port = process.env.PORT || 8000;
        this.middlewares();
        this.router = new Router(app);


    }

    middlewares() {
        this.app.use(morgan('tiny'));
        this.app.use(bodyParser.json());
    }

    listen() {
        this.app.listen(this.port, () => logger.info(`server listen at port ${this.port}`));
    }
}

export default Server;
