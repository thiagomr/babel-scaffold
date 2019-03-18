import restify from 'restify';
import logger from '~/lib/logger';
import router from '~/server/routes';

const server = restify.createServer();

function logRequest(req, res, next) {
	logger.info(`${req.method} - ${req.url}`);
	return next();
};

server.use(restify.bodyParser());
server.use(logRequest);

router(server);
server.listen(process.env.PORT, () => logger.info(`server listen at port ${process.env.PORT}`));
