import restify from 'restify';
import bodyParser from 'body-parser';
import morgan from 'morgan';
import router from '~/server/router';

class Server {
    constructor(app) {
        this.app = app;
        this.port = process.env.PORT || 8000;
        this.middlewares();
        this.router();
        this.listen();
    }

    router() {
		router(this.app);
    }

    middlewares() {
        this.app.use(morgan('tiny'));
        this.app.use(bodyParser.json());
    }

    listen() {
        this.app.listen(this.port, () => console.log(`server listen at port ${this.port}`));
    }
}

new Server(restify.createServer());
