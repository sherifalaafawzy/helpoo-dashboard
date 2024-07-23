importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
   apiKey: 'AIzaSyDD3yuKlcZqBeZHSsCk7KduW8heJzst0-g',
       appId: '1:719348853637:web:53cdb1c9464de5667672ec',
       messagingSenderId: '719348853637',
       projectId: 'insurance-dashboard-d27c1',
       authDomain: 'insurance-dashboard-d27c1.firebaseapp.com',
       storageBucket: 'insurance-dashboard-d27c1.appspot.com',
       measurementId: 'G-XGCD8B1ZLG',
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