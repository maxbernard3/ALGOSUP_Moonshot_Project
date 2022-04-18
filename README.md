# Moonshot Project
## What problem do I want to solve:
There are communities on the internet which spends their times digging up cold war concept and experimental design. Those communities would jump at the opportunity to test ‘what if the concept had been pushed further’.<br>
Similarly many communities about military hardware and doctrine wonder how different equipment and tactics could have performed when facing circumstances that they never had the opportunity to.<br>
Neither case has a good solution. At best wargame simulation like *Jane’s Fleet Command* and *Command Modern Operations* allow for some testing but are limited in there choice of hardware and are tactical simulator more than anything.

I am limiting  myself to cold war as more modern concept and prototype are still largely clasified and use technologie to wich I could only guess the performances of. I won't gear the simulation to handle anything older than the 40s either as I have to limit the scope of the project.

## Why I think it is interesting to solve:
It would be technically challenging as a moonshot project. The way I envision this simulation, I would have to make an AI that would change its tactic depending on what the user set as its doctrine, while also adapting itself to some of the crazy hardware that could be created on either side of a battlefield.<br>
Another challenge I set for myself, is having a way to simulate things such as breakdown of communication and delays in command which I have never seen simulated by an AI.<br>

Outside of it being technically challenging it would provide a testing ground for all of those concepts and cold war ideas.

## How would I solve the challenge:
I would use Unity for most of the elements up to the simulation as it would save me time setting up the UI and the 3D model of the hardware that the user wants to test. Once all of those inputs are set a script would run the simulation and send data to a tactical view so that the user can see in real-time what is happening. If I find that running the simulation takes too much time I could make it so the simulation runs completely and then can be viewed in the tactical view.

I would likely need to write a custom physic engine instead of using unity's one. The simulation would take place in unity, to make use of the 3D engine and built in fonction. But to simulate undreds of vehicle I think a very simplyfied phisic system is needed. I also need very fine controle over the behavior of physic.

I would use [TACVIEW](https://www.tacview.net/) as the tactical viewer. This means that I would need to generate files in ‘.acmi’ and export the mesh of the vehicle in ‘.obj’. TACVIEW is not free of use and if I was to distribute my software I would need to purchase an enterprise license.
I want to use TACVIEW as it is the most feature-rich flight data analysis tool available and pretty much every single feature would be useful in the case of this simulation.

To allow the user to set the location of the simulation on the world I would like to provide a globe view that gets increasingly better texture when you zoom in. I would do this by sub-diving a sphere into many squares and changing the displayed texture to the square closer to the camera’s centre.

The AI would be divided into two. A CommandAI that gives objectives to other Command AI repeating all the way down to UnitAI. This would allow for simulation of things like electronic warfare or breakdown of communication as not all commands would be capable of communicating with all units at a given time.<br>
The CommandAI would be hard coded to give objective to smaller based on the information it has at a given time, the objective it has, and the kind of role the AI expect its unit or subcommand to succeed in. The user would only set the objective for the highest commandAI.<br>
The UnitAI would also be hard codded, this time deciding how to behave itself based on what the hardware’s sensors can see, what was its last objective, and a bit more emotions. The emotion would be something simple. Like an isolated unit being more prone to retreating even against orders.
