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

## B) Introduction

### 1) Glossary

| Term used | Definition |
|---|---|
|  |  |

### 2) Project Overview

<!--- Explain what is the moonshot -->
The moonshot is a multiple years long project. The project has to be related to computer science and need to be ambitious. A single student will have to define and execute the entire project.

### 3) Project Definition

#### ➭ <ins>Vision</ins>

The project is to chart the real time MPG of a vehicle over a commute or busy section of road. Then to show the driver a comparison of his fuel consumption with that of other people using the system on the same route. With the objective to incentivize eco-driving through competition.

#### ➭ <ins>Stakeholders</ins>

| Stakeholder | Might have/find an interest in... |
|---|---|
| Primary Stakeholder & Project Lead : Max BERNARD | Showcasing his ability to lead and execute a project<br> Getting a diploma|
| CEO at ALGOSUP : Franck Jeannin | Having student in the working world to promote ALGOSUP |

### 4) Scope

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

### 5) Project Plan

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

## C) Functional Requirements

### 1) Personas Definition

* <ins>Home care agency :</ins>
The company is looking to encourage it's employee to use less fuel for economic reason. They want to purchase the hardware both to monitor who uses the most fuel but also to create competition amongst the drivers.<br>Most of the employee use the same routes frequently and these employee drive all day longs.
<br>
* <ins>Commuter :</ins>
A person commuting every day between his house in the suburbs and his office on the other side of town. They takes the busy ring road around the city they want to show off to their colleagues how much fuel they are saving by taking this road.<br>



### 2) Use Cases Analysis

| Use Case Number | Name | Description | Actor(s) | Pre-Conditions | Flow of Events | Post-Conditions | Exit Criteria | Notes & Issues |
|---|---|---|---|---|---|---|---|---|
| 1 |  | | | | | | |- |

### 3) Functional Analysis

## D) Feature

### 1) Overview

## E) Non-Functional Requirements

### 1) Costs

#### ➭ <ins>Capital Expenditures</ins>

##### <ins>Material</ins>
  
##### <ins>Software</ins>
  
##### <ins>Time Spent/Wages</ins>

* ??? man-hours

#### ➭ <ins>Operational Expenditures</ins>

##### <ins>Energies</ins>

* Cost of electricity for the hardware
* Cost of upkeep for the server
* Maintenance and service cost

### 2) Reliability

* Not actually that important but should still be a concern

### 3) Responsiveness/Performance

### 4) Operability

* Should Run on all car with an OBDII port
* Should support Android device
  
### 5) Recovery

* What happen when it broke (could I ask money to fix a purposefully shity system a la McDonald's ice cream machine?)

### 6) Delivery

* As an application on android available through Play Store
* An hardware that plug into the car

### 7) Maintainability

* Commented and Documented code

### 8) Security
