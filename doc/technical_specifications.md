# Technical Specifications

## Overview

This document outlines the technical architecture, hardware, software, and methodologies to implement the project defined in the functional specifications.

---

## Table of Contents
- [Technical Specifications](#technical-specifications)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [1. Introduction](#1-introduction)
  - [2. Hardware Specifications](#2-hardware-specifications)
    - [Components](#components)
    - [Design Considerations](#design-considerations)
  - [3. Software Architecture](#3-software-architecture)
    - [Mobile Application](#mobile-application)
      - [**1. User Authentication via Firebase**](#1-user-authentication-via-firebase)
      - [**2. Device Pairing via Bluetooth**](#2-device-pairing-via-bluetooth)
      - [**3. Real-Time Data Visualization**](#3-real-time-data-visualization)
      - [**4. Leaderboard and Friend Group Management**](#4-leaderboard-and-friend-group-management)
      - [**Best Practices and Optimizations**](#best-practices-and-optimizations)
    - [Backend](#backend)
      - [**1. Real-Time Database for Trip Data Storage**](#1-real-time-database-for-trip-data-storage)
      - [**2. User Management and Authentication**](#2-user-management-and-authentication)
      - [**3. Cloud Functions for Leaderboard Computation and Push Notifications**](#3-cloud-functions-for-leaderboard-computation-and-push-notifications)
    - [Arduino Embeded Software](#arduino-embeded-software)
      - [**1. OBD-II Protocol Handling**](#1-obd-ii-protocol-handling)
      - [**2. GPS Data Acquisition**](#2-gps-data-acquisition)
      - [**3. BLE Communication for Data Transmission**](#3-ble-communication-for-data-transmission)
      - [**4. SD Card Data Logging**](#4-sd-card-data-logging)
  - [4. Data Flow and Backend](#4-data-flow-and-backend)
    - [Data Acquisition](#data-acquisition)
    - [Data Storage](#data-storage)
    - [Data Processing](#data-processing)
  - [5. User Interface Design](#5-user-interface-design)
    - [Application Features](#application-features)
    - [Design Principles](#design-principles)
  - [6. Performance and Scalability](#6-performance-and-scalability)
    - [Performance Goals](#performance-goals)
    - [Scalability](#scalability)
  - [7. Security and Privacy](#7-security-and-privacy)
    - [Security Features](#security-features)
      - [Data Encryption](#data-encryption)
      - [User Authentication](#user-authentication)
    - [Privacy Considerations](#privacy-considerations)

---

## 1. Introduction

This document defines the technical requirements for developing a real-time MPG monitoring and eco-driving incentive platform. The system includes:
- BLE-enabled Arduino hardware with GPS for real-time data capture.
- Firebase backend for data storage and analytics.
- A Flutter-based mobile app for Android (iOS planned for future iterations).

---

## 2. Hardware Specifications

### Components
1. **Microcontroller:** [Freematics ONE ](https://freematics.com/pages/products/freematics-one/) with integrated Bluetooth Low Energy (BLE) for wireless communication with the mobile app.
2. **GPS Module:** integrated to the Microcontroller. Provides geolocation data to augment trip metrics and segment urban vs. highway driving.
3. **OBD2 Interface:** integrated to the Microcontroller. Connects to the vehicle's OBD2 port for data acquisition (e.g., fuel flow, RPM, speed).
4. **Power Source:** Powered through the vehicle’s OBD2 port (12V-24V power supply).
5. **Data Storage:** The Microcontroller is compatible with micro SD up to 64Gb

### Design Considerations
- **Device Enclosure:** Compact and durable casing to withstand vehicle vibrations and temperature variations. The [Freematics ONE ](https://freematics.com/pages/products/freematics-one/) included cassing fit those requirements.
- **Ergonomics:** The system should be out of the way of the driver, and unlikely to be hit by accident. If the ercogonomic of the Controler doesn't match that requirements in a specific vehicle, an OBD2 extention will be used.

---

## 3. Software Architecture

### Mobile Application

#### **1. User Authentication via Firebase**

**Integration:**
- Add Firebase to the Flutter project by configuring the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files.
- Use the `firebase_auth` package to manage authentication workflows.

**Key Features:**
- **Email/Password Authentication:**
  ```dart
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: 'user@example.com',
    password: 'password123',
  );
  ```
- **Google Authentication:**
  Utilize `google_sign_in` alongside Firebase:
  ```dart
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
  ```
- **Persistent Login:**
  Firebase automatically persists authentication states across app sessions using Secure Storage for tokens.

**Security Measures:**
- Enforce strong password policies in Firebase Authentication settings.
- Enable multi-factor authentication (MFA) for added security.

---

#### **2. Device Pairing via Bluetooth**

**Bluetooth Low Energy (BLE):**
- Use the `flutter_blue` package for BLE communication. This package provides APIs for scanning, connecting, and interacting with Bluetooth devices.

**Implementation Steps:**
1. **Scanning for Devices:**
   ```dart
   FlutterBlue.instance.scan(timeout: Duration(seconds: 5)).listen((scanResult) {
     print('Device found: ${scanResult.device.name}');
   });
   ```
2. **Connecting to the Device:**
   ```dart
   final device = scanResult.device;
   await device.connect();
   ```
3. **Discovering Services and Characteristics:**
   ```dart
   var services = await device.discoverServices();
   services.forEach((service) {
     service.characteristics.forEach((characteristic) {
       print('Characteristic found: ${characteristic.uuid}');
     });
   });
   ```
4. **Reading/Writing Data:**
   ```dart
   await characteristic.write([0x12, 0x34]);
   final value = await characteristic.read();
   print('Value: $value');
   ```

**Security Considerations:**
- Implement pairing request confirmation to avoid unauthorized connections.
- Encrypt data transmitted over BLE using built-in security modes.

---

#### **3. Real-Time Data Visualization**

**Data Handling:**
- Use `cloud_firestore` for real-time updates. Structure Firestore documents as follows:
  ```
  Users Collection:
    - userId:
      - trips: [tripId, tripId]
      - leaderboards: [leaderboardId, leaderboardId]
  ```
- Fetch data in real-time:
  ```dart
  FirebaseFirestore.instance.collection('trips').snapshots().listen((event) {
    event.docs.forEach((doc) => print(doc.data()));
  });
  ```

**Visualization:**
- Use Flutter’s `Charts` package for graphs:
  - **Bar Charts for Historical Trends:**
    ```dart
    BarChart(
      data: [
        BarChartData(x: 'Jan', y: 50),
        BarChartData(x: 'Feb', y: 70),
      ],
    );
    ```
  - **Line Charts for Fuel Efficiency Over Time:**
    ```dart
    LineChart(
      data: [
        LineChartData(x: 1, y: 30),
        LineChartData(x: 2, y: 35),
      ],
    );
    ```

---

#### **4. Leaderboard and Friend Group Management**

**Data Structure:**
- **Firestore Collections:**
  ```
  Leaderboards Collection:
    - leaderboardId:
      - members: [userId1, userId2]
      - scores: {userId1: score, userId2: score}
  ```
- Update scores using Cloud Functions triggered by new trip data:
  ```javascript
  exports.updateLeaderboard = functions.firestore
    .document('trips/{tripId}')
    .onCreate((snapshot, context) => {
      const data = snapshot.data();
      // Logic to update leaderboard scores
    });
  ```

**UI for Management:**
- **Friend Group Screen:**
  - Display groups in a list view.
  - Provide options to create, delete, and join groups.
- **Leaderboard Screen:**
  - Use paginated lists for large data sets.
  - Highlight the current user’s rank.

---

#### **Best Practices and Optimizations**

1. **Performance:**
   - Use efficient state management libraries like `Provider` or `Riverpod` to avoid unnecessary UI rebuilds.
   - Cache data locally using `hive` or `shared_preferences` to reduce backend queries.

2. **Security:**
   - Secure Firestore rules to ensure only authorized users can access their data:
     ```json
     match /users/{userId} {
       allow read, write: if request.auth.uid == userId;
     }
     ```

3. **Scalability:**
   - Design the backend to scale with Firebase auto-scaling.
   - Optimize database queries using Firestore indexing.


### Backend
#### **1. Real-Time Database for Trip Data Storage**

**Implementation:**

- **Data Structure:**
  - Organize trip data in a hierarchical JSON format within Firebase Realtime Database.
  - Structure example:
    ```json
    {
      "trips": {
        "userId1": {
          "tripId1": {
            "startTime": "2025-01-17T08:00:00Z",
            "endTime": "2025-01-17T09:00:00Z",
            "distance": 15.5,
            "fuelConsumption": 1.2
          },
          "tripId2": {
            // Trip details
          }
        },
        "userId2": {
          // User's trips
        }
      }
    }
    ```

- **Data Synchronization:**
  - Utilize Firebase's real-time synchronization to ensure that trip data is consistently updated across all client devices.
  - Implement listeners in the mobile application to handle real-time data updates.

- **Offline Support:**
  - Enable offline persistence in the mobile app to allow users to record trip data without an active internet connection.
  - Firebase will synchronize the offline data once the device reconnects to the internet.

**Security Considerations:**

- Define Firebase Realtime Database Security Rules to restrict access to trip data, ensuring that users can only read and write their own trip information.
  - Example rule:
    ```json
    {
      "rules": {
        "trips": {
          "$userId": {
            ".read": "$userId === auth.uid",
            ".write": "$userId === auth.uid"
          }
        }
      }
    }
    ```

#### **2. User Management and Authentication**

**Implementation:**

- **Firebase Authentication:**
  - Integrate Firebase Authentication to handle user sign-up, sign-in, and authentication state management.
  - Support multiple authentication methods, such as email/password and social media logins.

- **User Profiles:**
  - Store additional user information in a separate "users" collection in Firestore or Realtime Database.
  - Structure example:
    ```json
    {
      "users": {
        "userId1": {
          "displayName": "John Doe",
          "email": "johndoe@example.com",
          "profilePicture": "url_to_image"
        }
      }
    }
    ```

**Security Considerations:**

- Implement Firebase Authentication Security Rules to ensure that users can only access their own profile information.
  - Example rule:
    ```json
    {
      "rules": {
        "users": {
          "$userId": {
            ".read": "$userId === auth.uid",
            ".write": "$userId === auth.uid"
          }
        }
      }
    }
    ```

#### **3. Cloud Functions for Leaderboard Computation and Push Notifications**

**Implementation:**

- **Leaderboard Computation:**
  - Use Firebase Cloud Functions to calculate and update leaderboards based on trip data.
  - Trigger functions on specific events, such as the completion of a trip or periodic intervals.
  - Example function:
    ```javascript
    const functions = require('firebase-functions');
    const admin = require('firebase-admin');
    admin.initializeApp();

    exports.updateLeaderboard = functions.database.ref('/trips/{userId}/{tripId}')
      .onCreate(async (snapshot, context) => {
        const tripData = snapshot.val();
        const userId = context.params.userId;

        // Calculate score based on trip data
        const score = calculateScore(tripData);

        // Update user's total score in the leaderboard
        const leaderboardRef = admin.database().ref('/leaderboards/global');
        await leaderboardRef.child(userId).transaction(currentScore => {
          return (currentScore || 0) + score;
        });
      });
    ```

- **Push Notifications:**
  - Implement Cloud Functions to send push notifications to users for events like leaderboard position changes or new friend requests.
  - Use Firebase Cloud Messaging (FCM) to deliver notifications to client devices.
  - Example function:
    ```javascript
    exports.sendNotification = functions.database.ref('/notifications/{userId}/{notificationId}')
      .onCreate(async (snapshot, context) => {
        const notification = snapshot.val();
        const userId = context.params.userId;

        // Get the user's FCM token
        const userRef = admin.database().ref(`/users/${userId}`);
        const userSnapshot = await userRef.once('value');
        const fcmToken = userSnapshot.val().fcmToken;

        // Send notification
        const message = {
          notification: {
            title: notification.title,
            body: notification.body,
          },
          token: fcmToken,
        };

        await admin.messaging().send(message);
      });
    ```

**Security Considerations:**

- Ensure Cloud Functions have appropriate access controls and validate input data to prevent unauthorized operations.
- Use Firebase Security Rules to control access to notification data, ensuring that only intended recipients can read their notifications.

### Arduino Embeded Software
#### **1. OBD-II Protocol Handling**

**Hardware Interface:**
- **OBD-II Adapter:** Utilize an OBD-II adapter compatible with Arduino, such as the Freematics OBD-II Adapter. This adapter facilitates communication between the vehicle's OBD-II port and the Arduino via UART or I2C interfaces. 

**Implementation Steps:**
- **Library Integration:** Incorporate the Arduino OBD-II library to simplify interaction with the vehicle's OBD-II system. This library provides functions to initialize the OBD-II connection, query sensor data, and interpret responses.

- **Data Retrieval:** Implement periodic polling of essential parameters such as vehicle speed, engine RPM, and coolant temperature. For example:

  ```cpp
  #include <OBD.h>

  COBD obd;

  void setup() {
    Serial.begin(115200);
    if (obd.begin()) {
      Serial.println("OBD-II connection established.");
    } else {
      Serial.println("Failed to connect to OBD-II.");
    }
  }

  void loop() {
    int rpm;
    if (obd.readPID(PID_RPM, rpm)) {
      Serial.print("Engine RPM: ");
      Serial.println(rpm);
    }
    delay(1000); // Poll every second
  }
  ```

**Considerations:**
- **Compatibility:** Ensure the OBD-II adapter supports the vehicle's communication protocol (e.g., ISO 15765-4 CAN, ISO 9141-2).

- **Error Handling:** Implement robust error checking to handle scenarios where the vehicle may not support certain PIDs (Parameter IDs).

#### **2. GPS Data Acquisition**

**Hardware Interface:**
- **GPS Module:** Employ a GPS receiver module like the u-blox NEO-6M, which communicates with the Arduino via UART. This module provides real-time location data, including latitude, longitude, and speed.

**Implementation Steps:**
- **Library Integration:** Use the TinyGPS++ library to parse NMEA sentences received from the GPS module. This library simplifies extracting useful information such as location coordinates and time.

- **Data Parsing:** Set up a software serial connection to read data from the GPS module and parse it as follows:

  ```cpp
  #include <TinyGPS++.h>
  #include <SoftwareSerial.h>

  TinyGPSPlus gps;
  SoftwareSerial ss(4, 3); // RX, TX

  void setup() {
    Serial.begin(115200);
    ss.begin(9600);
  }

  void loop() {
    while (ss.available() > 0) {
      gps.encode(ss.read());
    }

    if (gps.location.isUpdated()) {
      Serial.print("Latitude: ");
      Serial.println(gps.location.lat(), 6);
      Serial.print("Longitude: ");
      Serial.println(gps.location.lng(), 6);
    }
  }
  ```

**Considerations:**
- **Antenna Placement:** Ensure the GPS antenna has a clear view of the sky for optimal satellite signal reception.

- **Data Validation:** Implement checks to confirm the validity of GPS data before usage, as initial readings may be inaccurate until a stable fix is obtained.

#### **3. BLE Communication for Data Transmission**

**Hardware Interface:**
- **BLE Module:** Integrate a BLE module like the HM-10, which allows wireless data transmission between the Arduino and the mobile application. This module communicates with the Arduino via UART.

**Implementation Steps:**
- **AT Command Configuration:** Configure the BLE module using AT commands to set parameters such as device name and baud rate. For instance:

  ```cpp
  void setup() {
    Serial.begin(9600); // HM-10 default baud rate
    Serial.println("AT+NAMEOBD_GPS_Logger");
    delay(1000);
    Serial.println("AT+BAUD4"); // Sets baud rate to 9600
  }
  ```

- **Data Transmission:** Send formatted OBD-II and GPS data over BLE to the mobile application:

  ```cpp
  void sendData(String data) {
    Serial.print(data); // Transmit data via BLE
  }

  void loop() {
    String data = String(gps.location.lat(), 6) + "," + 
                  String(gps.location.lng(), 6) + "," + 
                  String(rpm);
    sendData(data);
    delay(1000);
  }
  ```

**Considerations:**
- **Data Formatting:** Ensure data is formatted consistently to facilitate parsing on the mobile application side.

- **Connection Management:** Implement mechanisms to handle BLE connection status and reconnection attempts if the connection is lost.

#### **4. SD Card Data Logging**

**Hardware Interface:**
- **SD Card Module:** Use an SD card module connected via the SPI interface to store logged data for offline analysis.

**Implementation Steps:**
- **Library Integration:** Utilize the built-in SD library to manage file operations on the SD card.

- **Data Logging:** Open a file in write mode and append new data entries:

  ```cpp
  #include <SD.h>
  #include <SPI.h>

  const int chipSelect = 10;

  void setup() {
    Serial.begin(115200);
    if (!SD.begin(chipSelect)) {
      Serial.println("SD card initialization failed!");
      return;
    }
    Serial.println("SD card ready.");
  }

  void logData(String data) {
    File logFile = SD.open("datalog.txt", FILE_WRITE);
    if (logFile) {
      logFile.println(data);
      logFile.close();
    } else {
      Serial.println("Error opening datalog.txt");
    }
  }

  void loop() {
    String data = String(gps.location.lat(), 6) + "," + 
                  String(gps.location.lng(), 6) + "," + 
                  String(rpm);
    logData(data);
    delay(1000);
  }
  ```

 

---

## 4. Data Flow and Backend

### Data Acquisition
1. **Hardware Setup**

   - **Freematics ONE Device**: This Arduino-compatible device is designed for vehicle telematics and plugs directly into the vehicle's OBD-II port. It features an ATmega328p microcontroller, a CC2541 BLE module for wireless communication, and supports external GPS modules for geolocation data. 

   - **OBD-II Connection**: The device interfaces with the vehicle's Engine Control Unit (ECU) through the OBD-II port, allowing access to various vehicle parameters such as speed, engine RPM, and fuel levels. Ensure your vehicle is OBD-II compliant by locating the appropriate sticker under the hood. 

   - **GPS Integration**: For accurate geolocation data, connect an external GPS receiver to the Freematics ONE via the designated I/O socket. This setup enables the collection of real-time location data alongside vehicle diagnostics. 

2. **Firmware Development**

   - **Arduino Programming**: Develop custom firmware using the Arduino Integrated Development Environment (IDE). Freematics provides dedicated libraries and example sketches to facilitate communication with OBD-II and GPS modules. Download the necessary libraries and example sketches from the official Freematics repository. 

   - **Data Collection**: Implement routines within the firmware to periodically query the OBD-II interface for desired parameters and read GPS data from the connected receiver. Utilize the provided libraries to handle communication protocols and data parsing efficiently.

   - **BLE Communication**: Configure the CC2541 BLE module to establish a transparent serial connection with the mobile application. This involves setting up the BLE module in the firmware to advertise its presence and handle incoming connection requests. 

3. **Mobile Application Development**

   - **BLE Integration**: Develop a mobile application capable of scanning for and connecting to the Freematics ONE device over BLE. Once connected, the app should establish a serial communication channel to receive data streams from the device.

   - **Data Handling**: Implement functionality within the app to parse incoming data packets, which may include vehicle diagnostics and GPS coordinates. Ensure that the data is correctly interpreted and stored locally for further processing or immediate upload.

4. **Data Upload to Firebase**

   - **Firebase Setup**: Configure a Firebase project to handle incoming data. This includes setting up real-time databases or cloud storage solutions to accommodate the data structure being transmitted from the mobile application.

   - **API Integration**: Within the mobile application, integrate Firebase SDKs to facilitate seamless data transmission. Implement authentication mechanisms as required to secure data uploads.

   - **Data Transmission**: Upon receiving data from the Freematics ONE device, the mobile application should process and format the data appropriately before uploading it to Firebase. Implement error handling and data verification steps to ensure data integrity during transmission.

**Additional Considerations**

- **Power Management**: The Freematics ONE device supports low-power modes to prevent excessive drain on the vehicle's battery. Implement power management strategies in the firmware to enter low-power states when the vehicle is inactive. 

- **Data Logging**: For redundancy and offline scenarios, consider enabling data logging on the device using a microSD card. This ensures that data is not lost during periods without mobile connectivity. 

- **Firmware Updates**: Develop mechanisms to update the device firmware over BLE or through a USB connection to facilitate easy deployment of improvements and bug fixes.

### Data Storage

**1. microSD Card Storage**

- **Purpose**: The microSD card serves as local storage on the Freematics ONE device, capturing trip data such as OBD-II readings, GPS coordinates, and sensor information during a journey. This ensures data is retained even when the device is offline or not connected to a mobile application.

- **Hardware Integration**: The Freematics ONE features a microSD card slot under the side cover, connected to the ATmega328p microcontroller via the SPI interface. This setup allows for efficient data writing and retrieval using standard Arduino SD libraries. 

- **Firmware Development**:

  - **Initialization**: In your Arduino sketch, include the SD library and initialize the microSD card at the start of the trip. This involves setting up the SPI communication and verifying the card's presence.

  - **Data Logging**: During the trip, collect data from OBD-II, GPS, and sensors at defined intervals. Format this data into a structured format (e.g., CSV or JSON) and write it to the microSD card. Ensure each data entry is timestamped for accurate sequencing.

  - **File Management**: Create a new file for each trip, named uniquely (e.g., using the trip start timestamp). Properly close files after writing to prevent data corruption.

- **Post-Trip Data Transmission**: After completing a trip, establish a Bluetooth Low Energy (BLE) connection between the Freematics ONE device and the mobile application. Implement a protocol to transfer the stored trip data from the microSD card to the mobile app for further processing and upload to Firebase.

**2. Firebase NoSQL Database Structure**

Firebase Realtime Database is a cloud-hosted NoSQL database that stores data in JSON format, allowing for real-time synchronization across connected clients. 

- **Data Structure**:

  - **User Profiles**:

    - **Path**: `/users/{userId}`

    - **Schema**:

      ```json
      {
        "userId": {
          "authDetails": {
            "email": "user@example.com",
            "displayName": "User Name",
            "profilePicture": "url_to_image"
          },
          "vehicleConfigurations": {
            "vehicleId1": {
              "make": "Toyota",
              "model": "Corolla",
              "year": 2020,
              "vin": "1HGBH41JXMN109186"
            },
            "vehicleId2": {
              // Additional vehicle details
            }
          }
        }
      }
      ```

  - **Trip Data**:

    - **Path**: `/trips/{tripId}`

    - **Schema**:

      ```json
      {
        "tripId": {
          "userId": "userId",
          "vehicleId": "vehicleId1",
          "startTime": 1625247600,
          "endTime": 1625251200,
          "route": [
            {
              "timestamp": 1625247600,
              "location": {
                "latitude": 37.7749,
                "longitude": -122.4194
              },
              "speed": 60,
              "fuelConsumption": 8.5
            },
            // Additional route points
          ],
          "summary": {
            "totalDistance": 120.5,
            "averageSpeed": 65,
            "fuelUsed": 10.2
          }
        }
      }
      ```

  - **Leaderboards**:

    - **Path**: `/leaderboards/{leaderboardId}`

    - **Schema**:

      ```json
      {
        "leaderboardId": {
          "name": "Top Fuel Efficiency",
          "criteria": "fuelConsumption",
          "rankings": [
            {
              "userId": "userId1",
              "value": 5.6
            },
            {
              "userId": "userId2",
              "value": 6.1
            }
            // Additional rankings
          ]
        }
      }
      ```

- **Best Practices**:

  - **Data Denormalization**: In NoSQL databases like Firebase Realtime Database, it's common to denormalize data to optimize for read performance. This involves duplicating data across different parts of the database to reduce the need for complex queries. 

  - **Avoid Deep Nesting**: Limit the depth of nested data structures to prevent performance issues. Firebase recommends keeping the data structure as flat as possible to facilitate efficient queries and data retrieval. 

  - **Security Rules**: Implement Firebase Realtime Database Security Rules to control access to your data. Define rules that specify who can read or write to each part of your database, enhancing security and data integrity. 


### Data Processing

**1. Firebase Cloud Functions Setup**

- **Initialization**:

  - Ensure that you have the Firebase Command Line Interface (CLI) installed. If not, install it globally using npm:

    ```bash
    npm install -g firebase-tools
    ```

  - Initialize Cloud Functions in your Firebase project by navigating to your project directory and running:

    ```bash
    firebase init functions
    ```

  - Choose your preferred language (JavaScript or TypeScript) during initialization.

- **Dependencies**:

  - Navigate to the `functions` directory and install the Firebase Admin SDK:

    ```bash
    npm install firebase-admin
    ```

**2. Leaderboard Updates**

- **Data Structure**:

  - Store user scores in a Firestore collection named `scores`, where each document represents a user's score:

    ```json
    {
      "userId": "user123",
      "score": 1500,
      "timestamp": "2025-01-17T15:59:47Z"
    }
    ```

- **Function Implementation**:

  - Create a Cloud Function that triggers on document writes (create/update) in the `scores` collection:

    ```javascript
    const functions = require('firebase-functions');
    const admin = require('firebase-admin');
    admin.initializeApp();

    exports.updateLeaderboard = functions.firestore
      .document('scores/{userId}')
      .onWrite(async (change, context) => {
        const newValue = change.after.data();
        const userId = context.params.userId;

        // Fetch top N scores
        const topScoresSnapshot = await admin.firestore()
          .collection('leaderboard')
          .orderBy('score', 'desc')
          .limit(10)
          .get();

        let leaderboard = [];
        topScoresSnapshot.forEach(doc => {
          leaderboard.push({ userId: doc.id, ...doc.data() });
        });

        // Check if the new score qualifies for the leaderboard
        if (leaderboard.length < 10 || newValue.score > leaderboard[leaderboard.length - 1].score) {
          // Add or update the user's score in the leaderboard
          await admin.firestore().collection('leaderboard').doc(userId).set({
            score: newValue.score,
            timestamp: newValue.timestamp
          });
        }
      });
    ```

  - This function updates the leaderboard in real-time whenever a user's score is added or modified.

**3. Data Validation**

- **Security Rules**:

  - Implement Firebase Security Rules to enforce data validation at the database level:

    ```javascript
    service cloud.firestore {
      match /databases/{database}/documents {
        match /scores/{userId} {
          allow create: if request.resource.data.keys().hasAll(['score', 'timestamp']) &&
                          request.resource.data.score is int &&
                          request.resource.data.score >= 0 &&
                          request.resource.data.timestamp is timestamp;
          allow update: if request.resource.data.keys().hasAll(['score', 'timestamp']) &&
                          request.resource.data.score is int &&
                          request.resource.data.score >= 0 &&
                          request.resource.data.timestamp is timestamp;
          allow read: if true;
        }
      }
    }
    ```

  - These rules ensure that only valid data is written to the `scores` collection, enforcing the presence and types of required fields.

**4. Eco-Driving Scoring Algorithms**

- **Function Implementation**:

  - Develop a Cloud Function to calculate eco-driving scores based on trip data:

    ```javascript
    exports.calculateEcoScore = functions.firestore
      .document('trips/{tripId}')
      .onCreate(async (snap, context) => {
        const tripData = snap.data();
        const userId = tripData.userId;

        // Example parameters
        const averageSpeed = tripData.averageSpeed;
        const fuelConsumption = tripData.fuelConsumption;

        // Simple eco-driving score calculation
        let ecoScore = 100;
        if (averageSpeed > 80) {
          ecoScore -= (averageSpeed - 80) * 0.5;
        }
        if (fuelConsumption > 8) {
          ecoScore -= (fuelConsumption - 8) * 2;
        }
        ecoScore = Math.max(0, ecoScore);

        // Store the eco-score
        await admin.firestore().collection('ecoScores').doc(context.params.tripId).set({
          userId: userId,
          ecoScore: ecoScore,
          timestamp: tripData.timestamp
        });
      });
    ```

  - This function calculates an eco-driving score based on parameters like average speed and fuel consumption, and stores the result in the `ecoScores` collection.

**5. Deployment**

- Deploy the Cloud Functions using the Firebase CLI:

  ```bash
  firebase deploy --only functions
  ```

**6. Additional Considerations**

- **Performance Optimization**:

  - Utilize [Cloud Functions for Firebase 2nd Generation](https://firebase.google.com/docs/functions/2nd-gen-upgrade) to benefit from features like concurrency, which allows a single function instance to handle multiple requests simultaneously, reducing cold starts and improving performance.

- **Error Handling**:

  - Implement comprehensive error handling within your functions to manage exceptions and ensure reliability.

- **Testing**:

  - Use the Firebase Emulator Suite to test your functions locally before deploying them to production.

---

## 5. User Interface Design

### Application Features
- **Home Screen:** Displays trip summaries and current leaderboard position.
- **Pairing Screen:** Guides users through connecting the device to the app.
- **Trip History:** Visualizes historical driving data with graphs.
- **Leaderboard:** Displays friend group and global rankings.

### Design Principles
- Intuitive navigation.
- Minimalistic UI focused on key metrics.

---
## 6. Performance and Scalability

### Performance Goals

- **Application Load Time**: Aim for the app to load within 5 seconds to enhance user experience.
- **BLE Pairing Time**: Ensure Bluetooth Low Energy (BLE) devices pair within 10 seconds for seamless connectivity.
- **Real-Time Data Upload Latency**: Maintain data upload latency under 2 seconds to support real-time interactions.

### Scalability

Given the anticipated user base of up to 100 users, the scalability requirements are modest. Firebase's Realtime Database and Cloud Firestore are well-suited for small to medium-sized applications, offering sufficient capacity without the need for complex scaling strategies. Firebase's free tier can effectively support your prototype, providing essential services like hosting, authentication, and real-time databases without upfront costs. 

## 7. Security and Privacy

### Security Features

#### Data Encryption

**1. Data Encryption Between Flutter App and BLE Devices**

While BLE connections often have built-in encryption, it's essential to ensure that your specific implementation enforces this security. The `flutter_reactive_ble` package facilitates BLE operations in Flutter. To enhance security:

- **Pairing and Bonding**: Ensure that devices are properly paired and bonded, as this process establishes a trusted relationship and enables encryption.

- **Custom Encryption**: For sensitive data, consider implementing application-level encryption. This involves encrypting data before sending it over BLE and decrypting it upon receipt. Utilizing established encryption libraries in Dart can assist in this process.

**2. Data Encryption Between Flutter App and Firebase**

Firebase ensures data encryption in transit and at rest. However, for added security, especially with sensitive data, client-side encryption is advisable:

- **Client-Side Encryption**: Encrypt data within your Flutter app before uploading it to Firebase. This ensures that even if unauthorized access occurs, the data remains unintelligible without the decryption key. Implementing encryption libraries in Dart can facilitate this process.

- **Secure Key Management**: Safeguard your encryption keys by storing them securely, separate from the encrypted data. Avoid hardcoding keys within your application. Utilizing secure storage solutions, such as environment variables or secure key management services, is recommended.

**3. Firebase Security Measures**

Enhance your Firebase security by:

- **Security Rules**: Define precise Firebase Security Rules to control data access based on user authentication and authorization. This ensures that only authorized users can read or write specific data. 

- **Authentication**: Implement Firebase Authentication to verify user identities before granting data access. This adds an extra layer of security by ensuring that only authenticated users can interact with your Firebase data.

**4. Best Practices**

- **Regular Audits**: Periodically review and update your security protocols to address emerging threats and vulnerabilities.

- **Data Minimization**: Collect and store only the data necessary for your application's functionality, reducing the risk exposure in case of a security breach.

- **User Education**: Inform users about the importance of security practices, such as recognizing secure connections and understanding the significance of data encryption.


#### User Authentication
Utilize Firebase's built-in authentication methods, such as email/password and OAuth providers, to verify user identities. While two-factor authentication (2FA) adds an extra layer of security, it may be optional at this stage due to the limited user base.

### Privacy Considerations

- **GDPR Compliance**: As your app will handle personal data of users within the European Union, ensure compliance with the General Data Protection Regulation (GDPR). Key steps include:
  - **Data Minimization**: Collect only the data necessary for the app's functionality. 
  - **User Consent**: Obtain explicit consent from users before collecting their data, providing clear information on how it will be used. 
  - **Data Access and Deletion**: Allow users to access, correct, or request deletion of their personal data.
