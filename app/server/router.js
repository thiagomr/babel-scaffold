export default (server) => {
    server.get('/ping', (req, res) => res.send(200, 'pong'));
}
