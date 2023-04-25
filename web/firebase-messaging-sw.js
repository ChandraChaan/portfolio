importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
    apiKey: "AIzaSyCcyArg2tLT6FgAIvfe_mU2Q1DAzGC1gD4",
    authDomain: "rollapp123-6b732.firebaseapp.com",
    projectId: "rollapp123-6b732",
    storageBucket: "rollapp123-6b732.appspot.com",
    messagingSenderId: "873492171667",
    appId: "1:873492171667:web:f210c8d97d4b34f169b666",
    measurementId: "G-9X1ZNVD6ZY"
 };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });