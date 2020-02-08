import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';


admin.initializeApp();

const fcm = admin.messaging();

export const sendToTopic = functions.firestore
       .document('videos/{Item}')
       .onCreate(async snapshot => {

         const message: admin.messaging.MessagingPayload = {
           notification: {
             title: 'New Sermon!',
             body: `A new sermon has been uploaded`,
             icon: "default",
             sound: "default"
           }
         };

         return fcm.sendToTopic('sermon', message);
       });




export const newEvent = functions.firestore
       .document('events/{Item}')
       .onCreate(async snapshot => {

         const message: admin.messaging.MessagingPayload = {
           notification: {
             title: 'New Event!',
             body: `There is a new event at Full Gospel Church`,
             icon: "default",
             sound: "default"
           }
         };

         return fcm.sendToTopic('sermon', message);
       });
