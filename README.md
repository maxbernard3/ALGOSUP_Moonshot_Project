# Moonshot Project
## What problem do I want to solve:
There are communities on the internet which spends their times digging up cold war concept and experimental design. Those communities would jump at the opportunity to test ‘what if the concept had been pushed further’.<br>
Similarly many communities about military hardware and doctrine wonder how different equipment and tactics could have performed when facing circumstances that they never had the opportunity to.<br>
Neither case has a good solution. At best wargame simulation like *Jane’s Fleet Command* and *Command Modern Operations* allow for some testing but are limited in there choice of hardware and are tactical simulator more than anything.

I am limiting myself to the cold war as more modern concepts and prototypes are still largely classified and use technologies to which I could only guess the performances of. I won't gear the simulation to handle anything older than the 40s either as I have to limit its scope.

## Why I think it is interesting to solve:
It would be technically challenging as a moonshot project. The way I envision this simulation, I would have to make an AI that would change its tactic depending on what the user set as its doctrine, while also adapting itself to some of the crazy hardware that could be created on either side of a battlefield.<br>
Another challenge I set for myself, is having a way to simulate things such as breakdown of communication and delays in command which I have never seen simulated by an AI.<br>

Outside of it being technically challenging it would provide a testing ground for all of those concepts and cold war ideas.

## How would I solve the challenge:
I would use Unity for most of the elements up to the simulation as it would save me time setting up the UI and the 3D model of the hardware that the user wants to test. Once all of those inputs are set a script would run the simulation and send data to a tactical view so that the user can see in real-time what is happening. If I find that running the simulation takes too much time I could make it so the simulation runs completely and then can be viewed in the tactical view.

I would likely need to write a custom physic engine instead of using unity's one. The simulation would take place in unity, to make use of the 3D engine and built in fonction. But to simulate undreds of vehicle I think a very simplyfied phisic system is needed. I also need very fine controle over the behavior of physic.

I would use [TACVIEW](https://www.tacview.net/) as the tactical viewer. This means that I would need to generate files in ‘[.acmi](https://www.tacview.net/documentation/acmi/en/)’ or '[.csv](https://www.tacview.net/documentation/csv/en/)' and export the mesh of the vehicle in ‘.obj’. TACVIEW is not free of use and if I want to distribute my software I would need to purchase an enterprise license.
I think TACVIEW is the right tool as it is the most feature-rich flight data analysis tool available and pretty much every single feature would be useful in the case of this simulation.

To allow the user to set the location of the simulation on the world I would like to provide a globe view that gets increasingly better texture when you zoom in. I would do this by sub-diving a sphere into many squares and changing the displayed texture to the square closer to the camera’s centre.

The AI would be divided into several sub AI. An AI would have command over units, those units would have a command AI of their own and smaller sub-units all the way down to the individual aircraft/ship/etc...
#### AI case 1 : Machine learning
If I can get the program lightweight enough I envision using Machine Learning and Neural Network to train the AI against itself. The AI could represent different tactics by changing the reward of actions. I will admit that I do know enough about ML yet to make this too serious, but it is something to consider

#### AI case 2 : Tactical AI
If case 1 won't go as planned I would need to code AI the traditional way. diferent tactics would probably simply result in diferent way to generate the Influence map and and the path finding.<br>
On pathfinding : I think that in this case using Interactive-Deepening A* is the best way to go about it. The V.0 would likely mostly center on aircraft, but a number of thing, like low flying, still need a robust path finding algorithm.
