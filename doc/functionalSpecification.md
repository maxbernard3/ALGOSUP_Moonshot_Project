# Functional Specifications
year:
Find a good problem
build POC
find user

summer:
Rewrite your code with user feedback

Don't stop when you find competition
keep track of time (gogo google spread sheet)
Jira

## Table of content  

*
*
*

## Introduction

### Glossary

| Term used | Definition |
|---|---|
|  |  |

### Project Overview

<!--- Explain what is the moonshot -->
The moonshot is a multiple years long project. The project has to be related to computer science and need to be ambitious. A single student will have to define and execute the entire project.

### Project Definition

#### ➭ <ins>Vision</ins>

The project is to chart the real time MPG of a vehicle over a commute or busy section of road. Then to show the driver a comparison of his fuel consumption with that of other people using the system on the same route. With the objective to incentivize eco-driving through competition in a leaderboard.

#### ➭ <ins>Stakeholders</ins>

| Stakeholder | Might have/find an interest in... |
|---|---|
| Primary Stakeholder & Project Lead : Max BERNARD | Showcasing his ability to lead and execute a project<br> Getting a diploma|
| CEO at ALGOSUP : Franck Jeannin | Having student in the working world to promote ALGOSUP |

### Scope

#### ➭ <ins>In Scope</ins>

* Hardware to collect data

#### ➭ <ins>Out of Scope</ins>

* <ins>Neutral Scoring System :</ins>
A system that use an aggregation of data from the car, terrain, road conditions, car model etc... to give an ecodriving score based purely on the habits and behavior of the user. Independent of external bias like traffic or car model.<br>
This system would represent a significant time investment, comparable if not superior to the rest of the project. It would make the system much more fair and appealing for more people.<br>
Could be implemented latter but is too high effort for a V1.
<br>
* <ins>Apple CarPlay/Android Auto :</ins>
Integrating the software with either of those system would allow for the UI functionality to be accessed directly through the car's display infotainment system.<br>
This would only work on the most modern cars. And there aren't any feature that would benefits from being integrated directly in the car's infotainment system.<br>
Should not be implemented or considered for now.
<br>
* <ins>iOS application :</ins>
A version of the application that would work on iOS devices (iPhones). This could also mean publishing on the Apple App Store to make the app more easily available.<br>
This force the app to be compliant with Apple App Store Guidelines which is a constraining and expensive process. However in the EU, 3rd party application can be installed on iPhone, but this limit the customer base and makes the installation process harder. Still, iOS represent at least 30% of the market in most EU country and over 60% in Canada and the USA in 2024. as such it can't be ignored.<br>
Should be implemented as soon as possible but isn't necessary for a V1.
<br>
* <ins>Data collection for non OBD2 cars :</ins>
All vehicle made after 1996 in north America and 2001 in europe feature an OBD2 or EOBD port. Our system work using the OBD ports on a car, if a car didn't have said port an other solution would have to be made to receive the information necessary.<br>
North America and the EU would likely make the bulk of our user base. In those places, less than 10% of personal vehicle are older than the implementation of the mandatory OBD port laws. Beyond that, implementing a solution that works on older vehicle would be time consuming, expensive in material, require additional hardware, and may even require a specialist to instal the system on the vehicle.<br>
Such a system should not be implemented or worked on as it makes no economic sense.
<br>
* <ins>Website :</ins>
Having a website would make it platform agnostic as every computer or phone capable of running a web browser could have access to our Software.<br>
There are some drawbacks. The speed and responsiveness of website is significantly worse than that of a dedicated application. And there are limits to the data available to a website, especially in iOS which does not support Web Bluetooth API. The website could be used to display information without it being functional.<br>
The website is only marginally useful and shouldn't be implemented for now.
<br>
* <ins>Female side OBD2 port :</ins>
This mean that the hardware wouldn't block access to the car's diagnostic port by having a female side that retransmit the car's information as if there were no devices plugged in.<br>
The cost of such a system would be significant as it may as much as double the cost for each hardware devices. Some insurance companies require an OBD monitoring device, this is the only situation that can justify the bypass system.<br>
If insurance companies were to ask more frequently for OBD2 monitoring, this system could justify itself. As of now, it's too expensive and shouldn't be implemented.
<br>
* <ins>Custom Route :</ins>
Letting the user create his own route, instead of using the automated route creating system.<br>
This is interesting for user in more rural area for whom there might be little traffic to compare against. However such addition would require additional work on the UI and backend, while defeating the social and competitive aspect of the project. Indeed these custom route would likely see very few user and as such wouldn't create competitions.<br>
The effort necessary to implement the feature are too great, but it would become more relevant if the neutral scoring system is implemented latter as score could be compared between different route.
<br>


#### ➭ <ins>Deliverables</ins>

| Name | Type | Deadline | Link |
|---|---|---|---|
| Functional Specifications Document | Document (markdown) | 22/12/2024 | |
| Technical Specifications Document | Document (markdown) | 22/12/2024 | |
| POC | prototype hardware and server side code on Github | 22/12/2024 | |
| MVP | Application, finished hardware, scalable backend | |

### Project Plan

#### ➭ <ins>Milestones</ins>

| Milestone | Deadline|
|---|---|
| Functional Specifications V1 |  |
| Technical Specifications V1 |  |
| Proof Of Concept |  |
| Oral Presentation (1st Jury) |  |
| Market study | |
| Minimum Viable Product |  |
| Oral Presentation (2nd Jury) |  |

#### ➭ <ins>Dependencies</ins>

The POC requires some prior understanding of the target technologies before being developed, meaning that its development will probably start only after the technical specification are well underway.

The MVP requires the POC to be made first to estimate task difficulty and set objectives' viability. It's also a lower priority than the market study that should be conducted as soon as the POC is available.

The rest of the project depends on the first version of the functional specifications to be released.

#### ➭ <ins>Resources/Financial plan</ins>

There is an estimated 280 man-hours total to complete this project
=> 1 person

=> 300€ available to purchase hardware and software

=> 2 cars for testing

#### ➭ <ins>Assumptions/Constraints</ins>

| Assumptions |
|---|
| |

| Constraints |
|---|
| |

<!-- Functional Requirements -->

## Functional Requirements

### Personas Definition

#### ➭ <ins>Home Care Agency</ins>

**Name:** Sarah Thompson  
**Age:** 38  
**Role:** Fleet Manager  
**Company Size:** 50 employees, primarily home care aides  
**Goals:**  

* Reduce overall fuel costs for the agency.  
* Foster a sense of teamwork and friendly competition among employees.  
* Increase awareness of eco-driving practices.  

**Challenges:**  

* Limited budget for new technology.  
* Some employees may resist changes to their driving habits.  
* Need to balance efficiency with providing quality care to clients.  

**Motivations:**  

* Passionate about sustainability and reducing the company’s carbon footprint.  
* Wants to improve employee morale and engagement through friendly competition.  
* Interested in data to justify future investments in fuel-efficient vehicles.  

**Usage Scenario:**  
Sarah will review the leaderboard regularly to recognize top performers in fuel efficiency. She plans to hold monthly meetings to celebrate the achievements of the best drivers and encourage others to improve. She’ll also provide tips on eco-driving based on the data collected from the system.

#### ➭ <ins>Commuter</ins>

**Name:** David Kim  
**Age:** 30  
**Occupation:** Marketing Specialist  
**Commute Distance:** 20 miles each way  
**Commute Time:** 45 minutes during peak hours  
**Goals:**  

* Reduce fuel costs to save money for personal goals (e.g., travel).  
* Show off fuel savings to colleagues and encourage them to join the competition.  
* Find the most efficient routes to avoid traffic while saving fuel.  

**Challenges:**  

* Heavy traffic on the ring road can lead to unpredictable fuel consumption.  
* Sometimes feels guilty about driving, given the environmental impact.  
* Needs motivation to change driving habits, as current routes have become routine.  

**Motivations:**  

* Enjoys friendly competition and sharing achievements with peers.  
* Keen interest in technology and how it can optimize his daily life.  
* Aims to become a role model for eco-driving in his workplace.  

**Usage Scenario:**  
David will track his fuel consumption daily and compare it with his colleagues' stats on the leaderboard. He might adjust his driving style based on the feedback he receives and share tips on social media to inspire others.

### Use Cases Analysis

| **Use Case Number** | 00 |
|---------------------|--------|
| **Name** | View Personal Fuel Efficiency Data |
| **Description** | The driver can view their real-time fuel efficiency data and see historical comparisons for eco-driving improvements. |
| **Actor(s)** | Driver |
| **Pre-Conditions** | * The commuter’s car is equipped with the OBD2 fuel efficiency monitoring system. <br> * The system is connected to the mobile app for data display. <br> * The user is logged into the app and has permissions to view their data. |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The system displays the real-time fuel efficiency for the current trip.<br> 3. The user navigates to “Trip History” to view past trips and fuel consumption stats.<br> 4. The user selects a previous trip to see detailed data such as MPG and time spent idling.<br> 5. The app shows comparative data for similar routes taken by other drivers. |
| **Post-Conditions** | The user has viewed their real-time and historical fuel efficiency data, and can make adjustments to improve eco-driving if desired. |
| **Exit Criteria** | The user closes the app or navigates away from the fuel efficiency display. |
| **Notes & Issues** | * The app requires an internet connection to load comparative data. <br> * Data accuracy may vary depending on the OBD2 sensor. |


01. **Create an Account**  
   *Description:* Allows a new user to register with the app, providing basic information to set up an account for tracking and comparing fuel efficiency data.

02. **Login on the App**  
   *Description:* Enables a registered user to securely log in to access their account and personalized data on fuel efficiency and eco-driving competition.

03. **Install the OBD2 Monitoring Device**  
   *Description:* Guides the user through physically installing the OBD2 device in their vehicle to enable real-time fuel monitoring.

04. **Pair the Device**  
   *Description:* Allows the user to connect their OBD2 device to the app, synchronizing vehicle data with the app for tracking and analysis.

05. **Input Vehicle Information (fuel type and vehicle class)**  
   *Description:* The user inputs relevant vehicle details such as fuel type and class to improve the accuracy of efficiency calculations and comparisons.

06. **Create Friend Group**  
   *Description:* Enables a user to create a friend group where members can compare their fuel efficiency and compete on the leaderboard.

07. **Find Friend Group**  
   *Description:* Allows a user to search for and view existing friend groups to potentially join.

08. **Join Friend Group**  
   *Description:* Enables a user to join an existing friend group, giving them access to view and compete on that group’s leaderboard.

09. **View Leaderboard Position in Friends Group**  
   *Description:* Displays a user’s current ranking within their friend group based on fuel efficiency data.

10. **View Leaderboard Position on Route**  
    *Description:* Shows the user their position on a public leaderboard for a specific route, encouraging competition with others taking similar paths.

11. **Leave a Friend Group**  
    *Description:* Allows a user to leave a friend group they are a part of, removing them from that group’s leaderboard.

12. **Delete a Friend Group**  
    *Description:* Enables the creator of a friend group to delete it, which removes it from the app and eliminates any related leaderboard data.

13. **Delete an Account**  
    *Description:* Allows a user to permanently delete their account, erasing their personal data, vehicle data, and leaderboard history.

14. **Log Out of the App**  
    *Description:* Allows a logged-in user to securely log out of their account, ending their session on the app.


### Functional Analysis

## Feature

### Overview

## Non-Functional Requirements

### Costs

#### ➭ <ins>Capital Expenditures</ins>

##### <ins>Material</ins>
  
##### <ins>Software</ins>
  
##### <ins>Time Spent/Wages</ins>

* 250 man-hours

#### ➭ <ins>Operational Expenditures</ins>

##### <ins>Energies</ins>

* Cost of electricity for the hardware
* Cost of upkeep for the server
* Maintenance and service cost

### Reliability

* Not actually that important but should still be a concern

### Responsiveness/Performance

### Operability

* Should Run on all car with an OBDII port.
* Should support Android device running 7.1 Nougat or newer. Most phone have at most 5 year support. As the last Android 7.1 phone was released in 2018, the number of phone running older version of android should be minimal.
  
### Recovery

* What happen when it broke (could I ask money to fix a purposefully shity system a la McDonald's ice cream machine?)

### Delivery

* As an application on android available through Play Store
* An hardware that plug into the car

### Maintainability

* Commented and Documented code

### Security
