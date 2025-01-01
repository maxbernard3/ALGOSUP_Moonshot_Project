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
| Technical Specifications Document | Document (markdown) | 01/02/2025 | |
| POC | prototype hardware and server side code on Github | 03/03/2025 | |
| MVP | Application, finished hardware, scalable backend | 30/05/2025 |

### Project Plan

#### ➭ <ins>Milestones</ins>

| Milestone | Deadline|
|---|---|
| Functional Specifications V1 | 22/12/2024 |
| Technical Specifications V1 | 01/02/2025 |
| Proof Of Concept | 03/03/2025 |
| Oral Presentation (1st Jury) | 16/06/2025 |
| Market study |06/04/2025 |
| Minimum Viable Product | 30/05/2025 |
| Oral Presentation (2nd Jury) | 12/09/2025 |

#### ➭ <ins>Dependencies</ins>

The POC requires some prior understanding of the target technologies before being developed, meaning that its development will probably start only after the technical specification are well underway.

The MVP requires the POC to be made first to estimate task difficulty and set objectives' viability. It's also a lower priority than the market study that should be conducted as soon as the POC is available.

The rest of the project depends on the first version of the functional specifications to be released.

#### ➭ <ins>Resources/Financial plan</ins>

There is an estimated 280 man-hours total to complete this project
=> 1 person

=> 300€ available to purchase hardware and software :
    - Electronic support for the hardware
    - OBD2 scanner
    - Server renting
    - Deployment on Appstore

=> 2 cars for testing
    - Peugeot 405 (No OBD port)
    - Dacia Duster

#### ➭ <ins>Assumptions/Constraints</ins>

| Assumptions | |
|---| --- |
| Vehicle Compatibility |  The project assumes that the vast majority of users will have vehicles equipped with OBD2 or EOBD ports (post-1996 in North America, post-2001 in Europe). This means the majority of cars will be able to participate without additional hardware |
| User Adoption | Assumes that there is a sufficient user base interested in the eco-driving leaderboard, with enough competition to create value. |
| Minimal Regulation | Assumes that no major legal or regulatory hurdles will arise around the collection and use of vehicle data, particularly regarding user privacy and data protection. |

| Constraints | |
|---| --- |
| Limited Testing Vehicles | The project has access to only two cars for testing. This limits the diversity of vehicle models for testing the system and gathering data across different types of vehicles. |
| Budget Limitation | The project is constrained by a 300€ budget, which limits the scope of hardware and software purchases (e.g., OBD2 scanners, server rental). This budget may need to be optimized to balance between hardware, software, and operational costs. |

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
| **Notes & Issues**
 | * The app requires an internet connection to validate and create accounts. |

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

#### ➭ <ins>Fuel Efficiency Monitoring</ins>

- **Data Capture**  
  - Captures vehicle data through the OBD2 device, recording metrics such as fuel consumption, mileage, idling time, RPM, and other essential parameters directly from the vehicle.  
  - Logs all collected data for post-trip analysis without providing live feedback during the drive.

- **Data Presentation**  
  - Displays trip summaries with specific statistics: total fuel consumed, average miles per gallon (MPG), distance traveled, time spent idling, and time spent driving actively (cruising, accelerating).  
  - Enables users to compare historical trip data, identifying trends and patterns in fuel efficiency over days, weeks, and months.

- **Personalization**  
  - Allows users to input vehicle-specific parameters, specifying the fuel type (petrol, diesel, hybrid-diesel) and vehicle classification (SUV, sedan, coupe, hatchback, van) for accurate calculation and tailored feedback.  
  - Segments data into urban and highway driving to provide precise insights into fuel usage in different contexts.

#### ➭ <ins>Leaderboard</ins>

- **Scope of Leaderboards**  
  - Global leaderboard ranks users based on MPG or eco-driving scores for specific routes shared among multiple participants.  
  - Private leaderboards for friend groups allow users to engage in competition within their networks.

- **Visibility and Access**  
  - Provides a detailed ranking system showing the user's position, total participants, and relative performance compared to others.  
  - Displays the names of friends on global leaderboards while anonymizing other users for privacy.

- **Granularity**  
  - Organizes rankings by metrics such as fuel efficiency, carbon dioxide emissions reduction, and total cost savings.  
  - Allows users to filter leaderboard data by time periods: daily, weekly, or monthly.

- **Social Integration**  
  - Enables users to share leaderboard rankings, milestones, and achievements directly within friend groups or on external platforms.  
  - Supports the creation and management of multiple friend groups, each with its own leaderboard for diverse competitive opportunities.

#### ➭ <ins>Eco-Driving Insights</ins>

- **Feedback and Reports**  
  - Provides post-trip analysis identifying specific driving behaviors: harsh braking, rapid acceleration, extended idling, and suboptimal RPM management.  
  - Offers targeted recommendations for improving eco-driving based on the behaviors highlighted in the analysis.

- **Metrics and Scoring**  
  - Presents detailed eco-driving metrics, measuring driving smoothness, RPM consistency, and energy efficiency.  
  - Assigns an eco-driving score for each trip, enabling users to benchmark and track performance improvements over time.

- **Educational Content**  
  - Delivers structured knowledge on eco-driving practices, specifying techniques like maintaining steady speeds, minimizing idle times, and optimizing route selection.  
  - Explains the measurable impact of eco-driving habits on reducing fuel consumption and environmental impact, with a focus on tangible outcomes.

- **Long-Term Benefits**  
  - Tracks performance trends over time, reinforcing positive behaviors with visual indicators of progress.  
  - Links fuel savings to direct financial benefits and environmental impact reduction to motivate sustained eco-driving practices.

### Fuel Efficiency Monitoring

#### ➭ <ins>Data Capture</ins>

The system collects vehicle data using the On-Board Diagnostics II (OBD2) interface and GPS, focusing on metrics necessary for evaluating fuel efficiency and driving behavior.

- **OBD2 Data**:
  - **Fuel Consumption**: Captures real-time fuel usage data, including cumulative fuel consumed during the trip.
  - **Vehicle Speed**: Provides real-time speed readings.
  - **Engine RPM**: Monitors engine revolutions per minute to assess engine performance and load.
  - **Throttle Position**: Records throttle input to analyze driving style.
  - **Idle Time**: Tracks engine runtime when the vehicle is stationary.
  - **Diagnostic Trouble Codes (DTCs)**: Identifies engine or system issues that might impact fuel efficiency.

- **GPS Data**:
  - **Distance Traveled**: Calculates trip distance based on GPS coordinates.
  - **Route Information**: Logs the path taken, distinguishing between urban and highway driving conditions.
  - **Speed Profiles**: Maps speed data against geolocation for route-specific analysis.

- **Data Logging**:
  - Metrics are recorded continuously throughout the trip at regular intervals for balanced detail and storage efficiency.
  - Trip data is stored locally on the user’s device until it is uploaded to a central server for analysis.

- **Constraints**:
  - Data collection is limited to parameters accessible via the OBD2 interface and GPS. Additional hardware integrations, such as fuel flow sensors, are not included.
  - Real-time feedback is excluded; the focus is on post-trip analysis to simplify processing and enhance usability.
  - All collected data is anonymized and encrypted for privacy and security during storage and transmission.

#### ➭ <ins>Data Presentation</ins>

The system provides users with detailed and clear insights into their fuel efficiency and driving behavior. All trip data is visualized directly within the application in a structured and interactive format designed for straightforward interpretation and analysis.

- **Metrics Displayed**:
  - **Total Fuel Consumed**: The volume of fuel used during the trip.
  - **Fuel Efficiency**:
    - Expressed in multiple units to meet regional standards:
      - Miles per gallon (MPG, US and UK).
      - Kilometers per liter (km/L).
      - Liters per 100 kilometers (L/100 km).
  - **Distance Traveled**: The total distance covered during the trip.
  - **Driving Time**:
    - Time spent idling (engine running while the vehicle is stationary).
    - Time spent actively driving, divided into cruising and accelerating.
  - **Cruising Analysis**:
    - Defined as maintaining a deviation of less than 5 km/h over a period of 60 seconds.
    - Displays total cruising time and the percentage of the trip spent cruising.

- **Data Visualization on the Application**:
  - **Graphs and Charts**:
    - **Fuel Efficiency Over Time**: A line graph displays fuel efficiency in MPG, km/L, and L/100 km at intervals along the trip.
    - **Time Allocation**:
      - A pie chart divides total trip time into idling, cruising, and accelerating phases.
    - **Historical Trends**:
      - Bar charts and line graphs show changes in fuel efficiency over daily, weekly, and monthly periods.
    - **Comparative Analysis**:
      - Overlayed graphs present fuel efficiency and speed to correlate driving behavior with efficiency outcomes.
  - **Highlights and Summaries**:
    - A dashboard within the application displays key metrics, including average fuel efficiency, total fuel consumed, and driving time distribution.
    - Performance indicators use a fixed color scheme to categorize results into efficiency tiers.
  - **Route-Specific Insights**:
    - A map overlay in the application displays fuel efficiency data along the route.
    - Segments of the route are color-coded to represent efficiency levels based on fuel consumption rates.

- **Historical Data Comparison**:
  - Users view aggregated statistics over specific timeframes, including daily, weekly, and monthly averages, within the application.
  - Trends and patterns in fuel efficiency are displayed chronologically to monitor changes over time.
  - Similar routes or conditions are compared directly within the application to evaluate performance differences.

- **User Accessibility**:
  - All metrics are displayed with standardized labels and fixed unit conversions to ensure clarity and uniformity.
  - Visualizations are interactive within the application, with zoom and focus options to highlight specific sections of a trip or detailed timeframes in historical data.

#### ➭ <ins>Personalization</ins>

The system enables users to input vehicle-specific details and segment driving data into urban and highway categories for tailored insights into fuel efficiency. By default, data is presented as a combined overview, with the option to view segmented details if desired.

- **Vehicle Information Input**:
  - Users can provide their vehicle details through a guided interface in the application, ensuring accurate data processing and personalized feedback.
  - **Parameters Collected**:
    - **Fuel Type**: Petrol, diesel, hybrid-petrol, hybrid-diesel.
    - **Vehicle Classification**: SUV, sedan, coupe, hatchback, van.
  - **User Interface**:
    - A dedicated section within the app labeled “Vehicle Information” guides users through the process of entering these details.
    - Dropdown menus or selection tiles are provided for fuel type and vehicle classification.
    - A confirmation screen displays the selected inputs for verification before saving.

- **Urban and Highway Segmentation**:
  - The system segments trip data into urban and highway categories for context-specific insights into fuel consumption patterns.
  - **Segmentation Criteria**:
    - Urban zones are identified using GPS-based geofencing, where specific zones are labeled as urban.
    - Any area not labeled as urban is categorized as highway driving.
  - **Data Presentation**:
    - By default, all trip data is displayed as a combined overview.
    - Users have the option to enable segmented views, displaying separate metrics for urban and highway driving.
    - Segmented trip summaries and fuel efficiency metrics can be viewed for urban and highway contexts over daily, weekly, and monthly timeframes.

- **Data Utilization**:
  - The input data and segmented trip details enable the system to:
    - Tailor feedback to the vehicle’s fuel type and classification.
    - Provide precise insights into fuel usage and driving performance for urban and highway conditions.
    - Allow users to decide whether to focus on combined or segmented views, enhancing usability and customization.

## Non-Functional Requirements

### Costs

##### <ins>Material</ins>

- hardware : Cost of the OBD2 scanner, sensors, cables, and the device that plugs into the car's OBD2 port. Additional materials for building prototypes, testing equipment, and device encasing.

  
##### <ins>Software</ins>

- Development Tools: Software licenses for development tools, IDEs, and testing environments (e.g., Android Studio, any paid libraries).
- Server and Hosting: Hosting costs for the backend - - infrastructure (e.g., cloud servers, database hosting).
- App Store Fees: Costs for publishing on the Google Play Store (e.g., annual developer registration fees).
  
##### <ins>Time Spent</ins>

* 280 man-hours: Total time estimate for development and testing (including hardware and software tasks).

#### ➭ <ins>Operational Expenditures</ins>

* Cost of electricity for the device: Estimate for how much power the device will consume when connected to the car’s OBD2 port and running. This is usually a low amount but should be tracked for long-term sustainability.
* Cost of upkeep for the server: Ongoing costs for server usage to handle data from all users (this includes cloud service subscriptions or dedicated hosting for the backend).
* Maintenance and service cost: Any cost associated with maintaining the hardware, including the replacement of defective components.
* Cost of RMA: Return merchandise authorization costs for hardware that has failed. This can include shipping, processing, and replacements.

### Reliability

- Device Reliability:
    - The device should have a self-checking mechanism to ensure it's functioning correctly and will attempt to restart if an issue is detected.
    - The hardware should be designed to last under various car environmental conditions (e.g., temperature fluctuations, vibration).
    - Ideally, the device should have a modular design to allow for easy replacement of parts in case of failure.
- Software Reliability:
    - There should be robust error-handling routines in place to recover from unexpected crashes or issues without affecting the user experience.
    - Regular updates and patches should be part of the software lifecycle to ensure long-term reliability.
    - Automated tests should be set up for key parts of the software (e.g., data collection, leaderboard calculations) to ensure they are functioning correctly.

### Responsiveness/Performance

- **App Performance:** The application should load quickly (within 5 seconds), process data in real time, and update the user interface smoothly.
- **Data Sync:** When the device collects data, it should sync with the server efficiently, and any delays should be communicated clearly to the user (e.g., "Data syncing...").
- **Efficiency:** The app should not drain the phone's battery excessively during operation. Power consumption should be optimized, especially during long trips.

### Operability

- **Compatibility:** The software should support Android 7.1 and newer devices, ensuring that it can run on a wide range of phones, especially considering that most devices will be relatively recent. Older versions should be excluded, and support for newer Android versions should be evaluated in future updates.
- **Ease of Use:** The user interface (UI) should be intuitive and easy to navigate. A first-time user should be able to understand how to use the app in less than 5 minutes.
- **Car Compatibility:** The device should be designed to plug and work with any vehicle equipped with an OBD2 port. This includes ensuring compatibility with various car makes and models and providing clear troubleshooting guides for common issues.
  
### Recovery

#### ➭ <ins>Hardware failure</ins>

- **Failure Detection:** The device should continuously monitor its health (e.g., power supply, communication with the OBD2 port). If an issue is detected, it should immediately notify the user.
- **Data Integrity:** Any data collected during a session should be discarded if a hardware issue occurs, as retaining inaccurate data would compromise the results.
- **LED Error Codes:** The device's LED indicator should flash red with specific error codes to help the user understand the nature of the problem. For example, a flashing pattern might indicate a communication failure with the OBD2 port.
- **RMA Process:** If the device cannot recover from an error or reboot successfully, the user should be guided to send the device for a replacement through a simple RMA process. The manufacturer should offer easy-to-follow return instructions.

#### ➭ <ins>Software failure</ins>

- **Application Recovery:** If the app crashes, it should attempt to restart automatically. If the crash happens during an active session, any data from that session should be discarded to avoid corrupted information.
- **Error Reporting:** The app should prompt the user with an error message explaining the failure and give them the option to report the issue (e.g., send logs to the support team).

### Delivery

- **Android App Delivery:** The app should be made available for download on the Google Play Store for devices running Android 7.1 Nougat or newer. The app should also comply with Play Store policies (e.g., user privacy, data handling).
- **Hardware Delivery:** The hardware should be sold in a robust, easy-to-package form that’s ready for shipping or in-car installation. It should be user-friendly with clear instructions for use and installation.

### Maintainability

- **Code Quality:** The codebase should be well-structured, with comprehensive comments and documentation for each module or function. This is critical for future updates, debugging, or handing over the project to new developers.
- **Modularity:** The software should be modular to allow for easy future updates (e.g., adding new vehicle compatibility, integrating additional features like custom routes or improved scoring systems).
- **Documentation:** Detailed documentation should be maintained for both the hardware and software components. This includes setup guides, user manuals, troubleshooting steps, and API documentation.

### Security

- **User Authentication:** Implement two-factor authentication (2FA) for users to access their profiles securely. This could be through SMS or an authenticator app.
- **Device Pairing Security:** When a new device is paired with an account, the app should send an alert to the user’s phone/email to confirm that they initiated the connection. This can help prevent unauthorized access.
- **Data Encryption:** All sensitive user data, including driving statistics and personal information, should be encrypted during transmission (e.g., SSL/TLS) and at rest (e.g., database encryption).
- **Data Privacy:** Ensure compliance with GDPR and other relevant data privacy regulations, especially considering the app will be collecting data related to driving behavior and vehicle performance.
