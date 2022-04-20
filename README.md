# Moonshot Project
## What problem do I want to solve:
There are internet communities that spend their time digging up cold war concepts and experimental design. Those communities would jump at the opportunity to see how those concepts would have performed if pursued further<br>
Similarly, many communities discussing military hardware and doctrine wonder how different equipment and tactics could have performed when facing circumstances that they never had the opportunity to.<br>
Neither case has a good solution. At best, wargame simulations like [*Jane’s Fleet Command*](https://sonalystscombatsimulations.com/fleet_command/index.html) and [*Command Modern Operations*](https://www.matrixgames.com/game/command-modern-operations) allow for some testing but are limited in their choice of hardware and are wargame tactical simulators more than anything.

I am limiting myself to the cold war as more modern concepts, and prototypes are still largely classified and use technologies to which I could only guess the performances. I will not gear the simulation to handle anything older than the 40s, as I have to limit the project scope.

## Why I think it is interesting to solve:
It would be technically challenging as a moonshot project. The way I envision this simulation, I would have to make an AI that would change its tactic depending on what the user sets as its doctrine while also adapting itself to some of the wide variety of equipment that the user can create on either side of a battlefield.<br>
Another challenge I set for myself is to simulate things such as breakdown of communication and delays in command, which I have never seen simulated by an AI.<br>

Technical challenge aside, the project would be a great way to wargame abandoned concepts, tactics, and doctrines.

## How would I solve the challenge:
I would use Unity for most of the elements up to the simulation as it would save me time setting up the UI and the 3D model of the hardware that the user wants to test. After the user finished setting all the inputs, a script would run the simulation and send data to a tactical view so that the user can see in real-time what is happening. If I find that running the simulation takes too much time, I could make it so it runs entirely before the user can view the simulation in the tactical view.

I would likely need to write a custom physics engine to replace Unity's one with something more lightweight and controllable. The simulation would take place in Unity to use the 3D engine and built-in 3D-related function. I need a simplified physic system to run hundreds of units.

I would use [TACVIEW](https://www.tacview.net/) as the tactical viewer. This means that I would need to generate files in '[.acmi](https://www.tacview.net/documentation/acmi/en/)' or '[.csv](https://www.tacview.net/documentation/csv/en/)' and export the mesh of the vehicle in '.obj'. TACVIEW is not free of use, and if I want to distribute my software, I would need to purchase an enterprise license.
I think TACVIEW is the right tool as it is the most feature-rich flight data analysis tool available to the public, and pretty much every single feature would be useful in the case of this simulation.

To allow the user to set the location of the simulation anywhere in the world, I would like to provide a globe view that gets increasingly better texture when you zoom in. I would do this by sub-diving a sphere into many squares and changing the displayed texture to the squares closest to the camera's centre.

The AI would be divided into several sub-AI. For example, an AI would have command over units, and those units would have a commandAI of their own and smaller sub-units down to the individual aircraft/ship/etc...
#### AI case 1 : Machine learning
If I can get the program lightweight enough, I envision using Machine Learning or Q-learning and Neural Network to train the AI against itself. The AI could represent different tactics by changing the reward of actions. I will admit that I do know enough about ML yet to elaborate, but it is something to consider

#### AI case 2 : Tactical AI
If case 1 fails, I would need to code AI the traditional way. different tactics would probably result in different ways to generate the Influence map and pathfinding.<br>
On pathfinding: I think using Interactive-Deepening A* is the best way to go about it. The V.0 would likely mostly center on aircraft, but some things, like low flying and projectile avoidance, still need a robust pathfinding algorithm.
