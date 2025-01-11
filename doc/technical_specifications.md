# Technical Specifications

## Overview

This document outlines the technical architecture, hardware, software, and methodologies to implement the project defined in the functional specifications.

---

## Table of Contents
1. Introduction
2. Hardware Specifications
3. Software Architecture
4. Data Flow and Backend
5. User Interface Design
6. Performance and Scalability
7. Security and Privacy
8. Assumptions and Constraints

---

## 1. Introduction

This document defines the technical requirements for developing a real-time MPG monitoring and eco-driving incentive platform. The system includes:
- BLE-enabled STM32 hardware with GPS for real-time data capture.
- Firebase backend for data storage and analytics.
- A Flutter-based mobile app for Android (iOS planned for future iterations).

---

## 2. Hardware Specifications

### Components
1. **Microcontroller:** STM32 microcontroller with integrated Bluetooth Low Energy (BLE) for wireless communication with the mobile app.
2. **GPS Module:** Provides geolocation data to augment trip metrics and segment urban vs. highway driving.
3. **OBD2 Interface:** Connects to the vehicle's OBD2 port for data acquisition (e.g., fuel flow, RPM, speed).
4. **Power Source:** Powered through the vehicle’s OBD2 port (12V-24V power supply).

### Design Considerations
- **Device Enclosure:** Compact and durable casing to withstand vehicle vibrations and temperature variations.
- **Power Management:** Optimized to consume minimal power when idle or during long trips.

---

## 3. Software Architecture

### Mobile Application
- **Framework:** Flutter (cross-platform).
- **Core Features:**
  - User Authentication via Firebase.
  - Device pairing via Bluetooth.
  - Real-time data visualization.
  - Leaderboard and friend group management.

### Backend
- **Platform:** Firebase (NoSQL Database).
- **Core Features:**
  - Real-time database for trip data storage.
  - User management and authentication.
  - Cloud Functions for leaderboard computation and push notifications.

### STM32 Firmware
- **Programming Environment:** STM32CubeIDE.
- **Functions:**
  - OBD2 protocol handling.
  - GPS data acquisition.
  - BLE communication for data transmission to the app.

---

## 4. Data Flow and Backend

### Data Acquisition
- OBD2 and GPS data are read and transmitted to the mobile app via BLE.
- Data is then uploaded to Firebase for processing.

### Data Storage
- **Firebase NoSQL Database:**
  - User Profiles: Auth details, vehicle configurations.
  - Trip Data: Route, fuel consumption, speed, etc.
  - Leaderboards: Aggregated and computed rankings.

### Data Processing
- **Cloud Functions:** Handle leaderboard updates, data validation, and eco-driving scoring algorithms.

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
- App load time: <5 seconds.
- BLE pairing time: <10 seconds.
- Real-time data upload latency: <2 seconds.

### Scalability
- Backend must handle up to 10,000 active users.
- Firebase auto-scaling ensures smooth operation during peak usage.

---

## 7. Security and Privacy

### Security Features
- End-to-End Encryption for BLE and Firebase data transfer.
- User authentication with 2FA.
- GDPR compliance for user data.

### Privacy Considerations
- Anonymized leaderboard data.
- User-controlled data sharing settings.

---

## 8. Assumptions and Constraints

### Assumptions
- Vehicles are OBD2-compliant.
- Users have modern Android smartphones with Bluetooth support.

### Constraints
- Hardware budget limited to €300.
- App restricted to Android in initial release.