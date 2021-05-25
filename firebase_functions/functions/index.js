const admin = require('firebase-admin');
admin.initializeApp();
const database = admin.firestore();

const functions = require('firebase-functions');
const { log } = require('firebase-functions/lib/logger');

const scheduleNotificationsCollection = database.collection("SCHEDULE_NOTIFICATIONS")

const servicesCollection = database.collection("SERVICES")



exports.joinToWaitingRoom = functions.https.onRequest(async (req, res) => {
  try {
    const serviceId = req.body.serviceId
    const doc = servicesCollection.doc(serviceId)
    const service = await doc.get();
    const waitingIds = Array.from(service.get('waitingRoomIds'))
    const times = (waitingIds.map(e => e.time.toMillis()))

    const idIndex = times.indexOf(Math.min(...times))

    const subscribersIds = Array.from(service.get('subscribersIds'));


    const worthyUid = waitingIds[idIndex].uid
    subscribersIds.push(worthyUid)
    waitingIds.splice(idIndex, 1)




    await doc.update({ 'subscribersIds': subscribersIds, 'waitingRoomIds': waitingIds })
    await sendNotification(`You joined succeffully to ${service.get(['name'])} `, worthyUid)


    res.sendStatus(200)
  }
  catch (e) {
    res.sendStatus(500).send(e)
  }

});



exports.scheduledFunction = functions.pubsub.schedule('* * * * *').onRun(async (context) => {


  // setServiceStatus()

  const query = await scheduleNotificationsCollection
    .where("whenToNotify", '<=', admin.firestore.Timestamp.now()).get()


  query.forEach(async document => {


    sendNotification(document.get('body'), document.get('uid'))

    await scheduleNotificationsCollection.doc(document.id).delete()


  });


  
});


// servicesCollection.get()

const sendNotification = async (body, uid) => {
  const userDoc = await database.collection('USERS').doc(uid).get()
  const notification = {
    notification: { title: 'Exercise reminder 💪🏼', body: body },
    token: userDoc.get('notificationToken'),
    data: { click_action: 'FLUTTER_NOTIFICATION_CLICK' }
  };

  await admin.messaging().send(notification);

}









exports.test = functions.https.onRequest(async (req, res) => {

  const query = await scheduleNotificationsCollection
    .where("whenToNotify", '<=', admin.firestore.Timestamp.now()).get()


  query.forEach(async document => {


    sendNotification(document.get('body'), document.get('uid'))

    await scheduleNotificationsCollection.doc(document.id).delete()


  });

  res.sendStatus(200)
})

const setServiceStatus = async () => {
  console.log('-----------------------');

  const now = admin.firestore.Timestamp.now()
  const services = await servicesCollection.get()
  services.docs.forEach(document => {
    const now = admin.firestore.Timestamp.now().toDate()
    const doc = servicesCollection.doc(document.id);
    const endedAt = document.get('end').toDate()
    const startedAt = document.get('start').toDate()
    let status;
    if (now > endedAt) {
      if (now - endedAt >= 300000) {
        doc.delete()
        return;
      }
      else {

        status = 'ended'

      }
    }
    else if (now > startedAt) {
      status = 'started'
    }
    else {
      status = 'waiting'
    }


    doc.update({ 'status': status })


  })
}

