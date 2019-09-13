/**
 * @module Router
 */

import mainController from '~/server/controllers/main-controller';

class Router {
    /**
     * Define app routes and handle controllers
     * @param {Restify} app
     */
    constructor(app) {
        app.get('/ping', mainController.ping);
    }
}

export default Router;
