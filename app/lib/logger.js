import winston from 'winston';
import moment from 'moment-timezone';

const logger = new (winston.Logger)({
    'transports': [new (winston.transports.Console)({
        'colorize': true,
        'prettyPrint': true,
        'timestamp': () => moment().tz(process.env.TIMEZONE).format('YYYY-MM-DD HH:mm:ss')
    })]
});

export default logger;
