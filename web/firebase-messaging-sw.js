importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCn6xImuKu2ywEM2cMeUbRixBGLhaOi11k",
  authDomain: "rollapp-2c71b.firebaseapp.com",
  projectId: "rollapp-2c71b",
  storageBucket: "rollapp-2c71b.appspot.com",
  messagingSenderId: "897107102601",
  appId: "1:897107102601:web:3c3dba140ec011e126ef58",
  measurementId: "G-83YL6H9JGF"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    // By default, the system notification sound should play without specifying a sound file
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
