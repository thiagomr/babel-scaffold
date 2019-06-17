import mainController from '~/server/controllers/main-controller';

class Router {
    constructor(app) {
        app.get('/ping', mainController.ping);
    }
}

export default Router;
