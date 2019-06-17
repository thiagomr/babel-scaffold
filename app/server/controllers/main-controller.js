class MainController {
    ping(req, res) {
        return res.send(200, 'pong');
    }
}

export default new MainController();
