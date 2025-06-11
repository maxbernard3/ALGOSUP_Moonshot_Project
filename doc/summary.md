# Real-Time Fuel Monitoring Application: Project Report

## Presentation of the Project

This project is a real-time fuel monitoring application designed to interface with a vehicle's OBD2 port via a scanner. It retrieves driving data—such as fuel consumption, distance, and driving behavior metrics—which are transmitted to a central database. A mobile application then presents this information to the user in the form of personalized driving statistics.

In addition to self-monitoring, users can engage with a global leaderboard or compare their performance with friends or colleagues. The goal of the project is to encourage more eco-friendly driving habits through gamification and competitive features.

This project combines embedded systems development, mobile application design, and real-time data analysis with a strong emphasis on usability and ecological impact.

---

## Software Analysis and Specifications

> 🔗 [See full analysis and specifications document](functionalSpecification.md)

---

## Software Architecture Choices

> 🔗 [See detailed software architecture document](technical_specifications.md)

---

## Choice of Algorithms

This project does not rely heavily on complex algorithms. The focus is on delivering a practical and efficient solution, using algorithms only where necessary.

One area where algorithmic thinking becomes relevant is in normalizing fuel efficiency data across different vehicle types and road conditions. This is achieved using a weighted average of relevant metrics. The weights will be tuned through post-release data collection and statistical analysis.

---

## Expected and Implemented Changes – Project Steering and Management

Several key evolutions have occurred or are planned during the project's lifecycle:

- **Mobile App Rewrite in Kotlin**: The initial Flutter implementation was limited by inadequate access to the Bluetooth API. Rewriting the app in Kotlin enables full native support for Bluetooth communication, eliminating the need for workaround solutions that previously required frequent manual user intervention.
  
- **Embedded App Migration to RTOS (Zephyr)**: To support consistent and real-time data transmission from the OBD2 scanner, the embedded system is being transitioned to run on a Real-Time Operating System (likely Zephyr). This will allow Bluetooth packets to be sent continuously throughout a trip, rather than only at the start and end, and will significantly improve data collection speed and reliability.

- **Fuel Efficiency Normalization Algorithm**: An ongoing area of development is the creation of a system to fairly compare fuel efficiency across different vehicles and conditions. The approach uses a weighted average of factors such as vehicle type, speed, terrain, and traffic, in order to make driving behavior the most relevant factor in a user's leaderboard score. Tuning this model will require iterative calibration against real-world data collected after release.

---
