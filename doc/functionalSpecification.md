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
All vehicle made after 1996 in north America and 2001 in europe feature an OBD2 or EOBD port. The system work using the OBD ports on a car, if a car didn't have said port an other solution would have to be made to receive the information necessary.<br>
North America and the EU would likely make the bulk of the user base. In those places, less than 10% of personal vehicle are older than the implementation of the mandatory OBD port laws. Beyond that, implementing a solution that works on older vehicle would be time consuming, expensive in material, require additional hardware, and may even require a specialist to instal the system on the vehicle.<br>
Such a system should not be implemented or worked on as it makes no economic sense.
<br>
* <ins>Website :</ins>
Having a website would make it platform agnostic as every computer or phone capable of running a web browser could have access to the Software.<br>
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

* Passionate about sustainability and reducing the company's carbon footprint.  
* Wants to improve employee morale and engagement through friendly competition.  
* Interested in data to justify future investments in fuel-efficient vehicles.  

**Usage Scenario:**  
Sarah will review the leaderboard regularly to recognize top performers in fuel efficiency. She plans to hold monthly meetings to celebrate the achievements of the best drivers and encourage others to improve. She'll also provide tips on eco-driving based on the data collected from the system.

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
| **Name** | Create an Account |
| **Description** | Allows a new user to register with the app, providing basic information to set up an account for the application |
| **Actor(s)** | End User |
| **Pre-Conditions** | * The user has a Android smartphone with the application installed on it. <br> * The user either has a Google account or a valid Email. |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user chose to create an account when prompted.<br> 3. The user enter their information  (display name, email, password)  or login with Google.<br> 4.The user click on the confirmation email they have received |
| **Post-Conditions** | * The user has created and verified an account and is automatically signed into the application.<br> * The user is redirected to the home screen. |
| **Exit Criteria** | The user closes the app, returns to the login prompt, or does not validate the email within the required timeframe. |
| **Notes & Issues** | * The app requires an internet connection to validate and create accounts. |

| **Use Case Number** | 01 |
|---------------------|--------|
| **Name** | Login on the App |
| **Description** | Enables a registered user to securely log in to access their account and personalized data on fuel efficiency and eco-driving competition. |
| **Actor(s)** | End User |
| **Pre-Conditions** | * The user has a Android smartphone with the application installed on it. <br>* The user has created an account on the mobile app |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user chose to login to an existing account when prompted.<br> 3. The user enter their information  (email, password)  or login with Google. |
| **Post-Conditions** | * The user is redirected to the home screen. |
| **Exit Criteria** | The user closes the app, returns to the login prompt, inputs invalid login information. |
| **Notes & Issues** | * The app requires an internet connection to validate the information |

| **Use Case Number** | 02 |
|---------------------|--------|
| **Name** | Install the OBD2 Monitoring Device |
| **Description** | The user is physically installing the OBD2 device in their vehicle to enable real-time fuel monitoring. |
| **Actor(s)** | Driver |
| **Pre-Conditions** | * The user has a vehicle with an OBD2 port<br> * The user has the fuel flow monitoring hardware part of the system |
| **Flow of Events** | 1. The user find the OBD2 port in their cars (in the vehicle's users manual)<br> 2. The user plug the OBD2 device in the port with the vehicle turned off<br> 3. the User turn on the vehicle on (but not the engine) to check that the installation worked |
| **Post-Conditions** | A LED on the OBD2 Device indicate that the device was installed as intended |
| **Exit Criteria** | The user cannot instal the device or the indicator led doesn't show as expected |
| **Notes & Issues** | * The user may struggle to find the OBD2 port<br>* Some cars may not turn one without also turning on the engine |

| **Use Case Number** | 03 |
|---------------------|--------|
| **Name** | Pair the Device |
| **Description** |Allows the user to connect their OBD2 device to the app, synchronizing vehicle data with the app. |
| **Actor(s)** | Driver |
| **Pre-Conditions** | * The commuter's car is equipped with the OBD2 monitoring system. <br> * The user is logged into the app. <br> * The user's phone Bluetooth is on and the app has permission to use it|
| **Flow of Events** | 1. The user press the button on the OBD2 device until the LED start blinking faster<br> 2. The user opens the mobile app.<br> 3. The user navigates to "Pairing" where the phone will look to connect with the device.<br>4. The user has to allow the pairing between the app and the device when prompted. <br>5. The application will show a successful pairing message and the device led will stay on without blinking.|
| **Post-Conditions** | The device was paired successfully and will now find the user's phone on it's own in the future |
| **Exit Criteria** | The application cannot find the device or the user cancel the pairing by either refusing it or exiting the app. |
| **Notes & Issues** | The process of pairing can not be made entirely automatically for security reason. |

| **Use Case Number** | 04 |
|---------------------|--------|
| **Name** | Input Vehicle Information (fuel type and vehicle class) |
| **Description** | The user inputs relevant vehicle details such as fuel type and class to improve the accuracy of efficiency calculations and comparisons. |
| **Actor(s)** | Driver |
| **Pre-Conditions** | * The user is logged into the app |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user navigates to "Vehicle Information" to input their vehicle class (SUV, Coupe, Sedan...) and fuel (Diesel, Petrol, Hybrid-Diesel...)<br> 3. The user confirm his impute |
| **Post-Conditions** | The user has given their vehicle data and can now get better tracking. They are redirected to the home screen |
| **Exit Criteria** | The user closes the app or navigates away from the Vehicle Information page. |
| **Notes & Issues** | * The app requires an internet connection to upload new information <br> * This work on trust and a user could input anything |

| **Use Case Number** | 05 |
|---------------------|--------|
| **Name** | Create Friend Group |
| **Description** | Enables a user to create a friend group where members can compare their fuel efficiency and compete on the leaderboard. |
| **Actor(s)** | End user |
| **Pre-Conditions** | * The user is logged into the app |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user navigates to "Friend Group" where they can see all the group they are part off<br> 3. The user press the button to create a new group.<br> 4. The user is prompted to give a "Group Name" and (optionally) to select the person they want to invite to a new group among their existing friends.<br> 6. The group is created and it's member can share the invitation to this group by pressing the share icon.
| **Post-Conditions** | The user is on the "group screen" and can see the leaderboard of the group |
| **Exit Criteria** | The user closes the app or navigates away from the group creation page. |
| **Notes & Issues** | * The app requires an internet connection to upload new information |

| **Use Case Number** | 06 |
|---------------------|--------|
| **Name** | Join Friend Group |
| **Description** | Enables a user to join an existing friend group, giving them access to view and compete on that group's leaderboard |
| **Actor(s)** | End user |
| **Pre-Conditions** | * The user is logged into the app <br> * The user has an invitation to a friend group (sent by someone already in the group) |
| **Flow of Events** | 1. The user click on the invitation link and if prompted, select to open the link with the app<br> 2. The user is redirected to the application and is asked if they want to join the group <br> 3. Upon accepting the user is redirected to the group page and is now part of that group and it's leaderboard |
| **Post-Conditions** | The user is on the "group screen" and can see the leaderboard of the group |
| **Exit Criteria** | The user closes the app or does not accept to join the group when prompted. |
| **Notes & Issues** | * The app requires an internet connection to load comparative data.<br> * A group could be deleted between it's creation and the user accepting the invitation |

| **Use Case Number** | 07 |
|---------------------|--------|
| **Name** | View Leaderboard Position in Friends Group |
| **Description** | Displays a user's current ranking within their friend group based on fuel efficiency data.|
| **Actor(s)** | End user |
| **Pre-Conditions** | * The user is logged into the app <br> * The user is part of a friend group |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user navigates to "Friend Groups" to view all the group he is part off.<br> 3. The user selects a group to see the leaderboard and all the members within. <br> 4. the user type a name in the search bar and the leaderboard scroll to that name to show their information and rank<br> 5. Alternatively the user can scroll on the leaderboard to see different people and their ranking.|
| **Post-Conditions** | The user is on the "friend group" screen and can see the position of anyone in the leaderboard |
| **Exit Criteria** | The user closes the app or navigates out of the Group's page|
| **Notes & Issues** | * The app requires an internet connection to load comparative data. |

| **Use Case Number** | 08 |
|---------------------|--------|
| **Name** | View Leaderboard Position on Route |
| **Description** | Shows the user their position on a public leaderboard for a specific route, encouraging competition with others taking similar paths. |
| **Actor(s)** | Driver |
| **Pre-Conditions** | * The user is logged into the app <br> * The user has driven at least one route |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user navigates to "Route Leaderboard" to view all the route he is part off.<br> 3. The user selects a route to see the leaderboard, only their friend will have their name visible. <br> 4. the user type a name in the search bar and the leaderboard scroll to that name to show their information and rank <br> 5. Alternatively the user can scroll on the leaderboard to see different people and their ranking. |
| **Post-Conditions** | The user is on the "route group" screen and can see the position of anyone in the leaderboard |
| **Exit Criteria** | The user closes the app or navigates out of the Group's screen|
| **Notes & Issues** | * The app requires an internet connection to load comparative data. |

| **Use Case Number** | 09 |
|---------------------|--------|
| **Name** | View Personal Fuel Efficiency Data |
| **Description** | The driver can view their real-time fuel efficiency data and see historical comparisons for eco-driving improvements. |
| **Actor(s)** | Driver |
| **Pre-Conditions** | * The user's car is equipped with the OBD2 monitoring system. <br> * The OBD2 device is connected to the mobile app. <br> * The user is logged into the app |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user navigates to "Trip History" to view past trips and fuel consumption stats.<br> 3. The user selects a previous trip to see detailed data such as MPG and time spent idling. |
| **Post-Conditions** | The user has viewed their historical fuel efficiency data, and can make adjustments to improve eco-driving if desired. |
| **Exit Criteria** | The user closes the app or navigates away from the fuel efficiency display. |
| **Notes & Issues** | * The app requires an internet connection to load comparative data. <br> * Data accuracy may vary depending on the OBD2 sensor. |

| **Use Case Number** | 10 |
|---------------------|--------|
| **Name** | Leave a Friend Group |
| **Description** | Allows a user to leave a friend group they are a part of, removing them from that group's leaderboard. |
| **Actor(s)** | End user |
| **Pre-Conditions** | * The user is logged into the app <br> * The user is part of a friend group |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user navigates to "Friend Groups" to view all the group he is part off.<br> 3. The user selects a group to see the leaderboard and all the members within. <br>4. The user select to leave the group by selecting the "Quit Group" option in the hamburger menu.<br> 5. The user is asked to confirm wether or not they want to leave.
| **Post-Conditions** | The user is on the home page and has left the friend group. They can no longer see that group nor can they be seen by the members of the group |
| **Exit Criteria** | The user closes the app or cancel the action when asked to confirm to leave the group. |
| **Notes & Issues** | * The app requires an internet connection to load comparative data. |

| **Use Case Number** | 11 |
|---------------------|--------|
| **Name** | Delete a Friend Group |
| **Description** | Enables the creator of a friend group to delete it, which removes it from the app and eliminates any related leaderboard data. |
| **Actor(s)** | Creator of a group |
| **Pre-Conditions** | * The user is logged into the app <br> * The has created a friend group |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user navigates to "Friend Groups" to view all the group he is part off.<br> 3. The user selects a group they created to see the leaderboard and all the members within. <br>4. The user select to delete the group by selecting the "Delete Group" option in the hamburger menu.<br> 5. The user is asked to confirm wether or not they want to delete.
| **Post-Conditions** | The user is on the home page and the group no longer exist and can't be seen by any of it's member anymore. |
| **Exit Criteria** | The user closes the app or cancel the action when asked to confirm to delete the group. |
| **Notes & Issues** | * The app requires an internet connection to load comparative data. |

| **Use Case Number** | 12 |
|---------------------|--------|
| **Name** | Log Out of the App |
| **Description** | Allows a logged-in user to log out of their account, ending their session on the app. |
| **Actor(s)** | End user |
| **Pre-Conditions** | * The user is logged into the app |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user click on the hamburger menu<br> 3. The user selects to Logout<br> 5. The user is asked to confirm wether or not they want to log out.
| **Post-Conditions** | The user is on the splash screen and logged out of the application |
| **Exit Criteria** | The user closes the app or cancel the action when asked to confirm to log out |
| **Notes & Issues** |  * The app requires an internet connection to upload new information |

| **Use Case Number** | 13 |
|---------------------|--------|
| **Name** | Delete an Account |
| **Description** | Allows a user to permanently delete their account, erasing their personal data, vehicle data, and leaderboard history. |
| **Actor(s)** | End user |
| **Pre-Conditions** | * The user is logged into the app |
| **Flow of Events** | 1. The user opens the mobile app.<br> 2. The user click on the hamburger menu<br> 3. The user selects to Delete the account<br> 5. The user is asked to confirm wether or not they want to Delete the account.
| **Post-Conditions** | The user is on the splash screen and the account and all it's associated data have been deleted. |
| **Exit Criteria** | The user closes the app or cancel the action when asked to confirm to delete the account |
| **Notes & Issues** |  * The app requires an internet connection to upload new information |


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

* Cost of electricity for the device
* Cost of upkeep for the server
* Maintenance and service cost
* Cost of RMA

### Reliability

* The device should be designed in a way to return to it's default working state after a issue to limit RMA
* Software should have test to ensure reliable operation

### Responsiveness/Performance

### Operability

* Should Run on all car with an OBDII port.
* Should support Android device running 7.1 Nougat or newer. Most phone have at most 5 year support. As the last Android 7.1 phone was released in 2018, the number of phone running older version of android should be minimal.
  
### Recovery

#### ➭ <ins>Hardware failure</ins>

- The application should detect and inform the user of an issue with the hardware. 
- Any data collected as long as the failure isn't resolved should be discarded.
- The device's LED should flash RED with an error code if applicable
- If a restart of the device did not solve the issue it should be sent for RMA

#### ➭ <ins>Software failure</ins>

- The application try to restart itself
- All data collected during the trip in progress is discarded

### Delivery

* As an application on Android 7.1 and newer available through Play Store.
* A encased Device that plug into the car OBD2 port.

### Maintainability

* Commented and Documented code

### Security

* 2FA
* Warning to the user when someone else pair their device with a new account
