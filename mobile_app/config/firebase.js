// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyClHmm_4MbhbVzleHQDQJUK38KWlk99nXc",
    authDomain: "fir-auth-f648f.firebaseapp.com",
    projectId: "fir-auth-f648f",
    storageBucket: "fir-auth-f648f.appspot.com",
    messagingSenderId: "745319786740",
    appId: "1:745319786740:web:09642eb5dae4684d5c96a1"
  };

// Initialize Firebase
const Firebase = initializeApp(firebaseConfig);

export default Firebase;