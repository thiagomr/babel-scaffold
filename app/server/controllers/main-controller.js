/**
 * @class
 */
class MainController {
    /**
     * API heathly check
     * @returns {string} pong
     */
    ping(req, res) {
        return res.send(200, 'pong');
    }
}

export default new MainController();
