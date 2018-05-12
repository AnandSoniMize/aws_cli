//redshift.js
var Redshift = require('node-redshift');
var logger = require('tracer').colorConsole();
// let to = require('await-to-js');
import to from 'await-to-js';


var client = {
    user: "adminuser",
    database: "database1",
    password: "TopSecret1",
    port: 5439,
    host: "mycluster.cpdvkneibipx.eu-central-1.redshift.amazonaws.com",
};

// https://stackoverflow.com/a/49311904/1024794
function catchEm(promise) {
    return promise.then(data => [null, data])
        .catch(err => [err]);
}

logger.info("creating redshift connection with client", client);
// The values passed in to the options object will be the difference between a connection pool and raw connection
var redshift = new Redshift(client, {rawConnection: true});

// logger.info("creating a table");

async function doAll(cb) {
    logger.info("cb", cb);
    let err;
    [err] = await to(destroyTable())
    logger.info("err", err);
    if (err) {
        logger.error(err);
        return cb(err)
    }
    /*let err, user, savedUser, notification;

    [ err, user ] = await to(UserModel.findById(1));
    if(!user) return cb('No user found');

    [ err, savedTask ] = await to(TaskModel({userId: user.id, name: 'Demo Task'}));
    if(err) return cb('Error occurred while saving task');

    if(user.notificationsEnabled) {
        [ err ] = await to(NotificationService.sendNotification(user.id, 'Task Created'));
        if(err) return cb('Error while sending notification');
    }

    if(savedTask.assignedUser.id !== user.id) {
        [ err, notification ] = await to(NotificationService.sendNotification(savedTask.assignedUser.id, 'Task was created for you'));
        if(err) return cb('Error while sending notification');
    }
*/
    cb(null, "ok");
}

doAll(function (result) {
    logger.info("result", result);
})/*.then(function (result) {
    logger.info("result", result);
}).catch(err => {
    logger.error(err);
})*/;

async function destroyTable(cb) {
    // try {
    //     logger.info('destroing a table');
    //     [err, _] = await to(redshift.rawQuery(`drop database testtable;`, {raw: true})) // https://www.npmjs.com/package/await-to-js
    //     if (err) {
    //         logger.error(err);
    //         cb(err, null);
    //     }
        cb(null, "ok")
    // } catch (e) {
    //     cb(e)
    // }
}

// redshift.rawQuery(`create table testtable (testcol int);`, {raw: true})
//     .then(function (data) {
//         logger.info(data);
//         logger.info("inserting data in a table");
//         redshift.rawQuery(`insert into testtable values (100);`, {raw: true})
//             .then(function (data) {
//                 logger.info(data);
//
//                 logger.info("requesting data");
//                 redshift.rawQuery(`SELECT * FROM "testtable"`, {raw: true})
//                     .then(function (data) {
//                         logger.info(data);
//                     })
//                     .catch(function (err) {
//                         logger.error(err);
//                     });
//             })
//             .catch(function (err) {
//                 logger.error(err);
//             });
//
//     })
//     .catch(function (err) {
//         logger.error(err);
//     });


