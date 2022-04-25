# Moonshot Project
## What problem do I want to solve:
There are internet communities that spend their time digging up cold war concepts and experimental design. People wonder how those concepts could have performed if pushed further.

My Aim is to make a simulation environment to wargame abandoned concepts, tactics, and doctrines without dealing with the logistic of an actual wargame.
I am limiting myself to the cold war as more modern concepts, and prototypes are still largely classified and use technologies to which I could only guess the performances. I will not gear the simulation to handle anything older than the 40s, as I have to limit the project scope.

## Why I think it is interesting to solve:
It would be technically challenging as a moonshot project. The way I envision this simulation, I would have to make an AI that would change its tactic depending on what the user sets as its doctrine while also adapting itself to some of the wide variety of equipment that the user can create on either side of a battlefield.<br>
Another challenge I set for myself is to simulate things such as breakdown of communication and delays in command, which I have never seen simulated by an AI.<br>

There are currently no good solutions for simulating fictional equipments and tactics. At best, wargame simulations like [*Jane’s Fleet Command*](https://sonalystscombatsimulations.com/fleet_command/index.html) and [*Command Modern Operations*](https://www.matrixgames.com/game/command-modern-operations) allow for some testing but are limited in their choice of hardware and are wargame tactical simulators ill suited to be a testing ground for new equipment.

## How would I solve the challenge:
I would use Unity for most of the elements up to the simulation as it would save me time setting up the UI and the 3D model of the hardware that the user wants to test. After the user finished setting all the inputs, a script would run the simulation and send data to a tactical view so that the user can see in real-time what is happening. If I find that running the simulation takes too much time, I could make it so it runs entirely before the user can view the simulation in the tactical view.

I would use [TACVIEW](https://www.tacview.net/) as the tactical viewer. This means that I would need to generate files in '[.acmi](https://www.tacview.net/documentation/acmi/en/)' or '[.csv](https://www.tacview.net/documentation/csv/en/)' and export the mesh of the vehicle in '.obj'. TACVIEW is not free of use, and if I want to distribute my software, I would need to purchase an enterprise license.
I think TACVIEW is the right tool as it is the most feature-rich flight data analysis tool available to the public, and pretty much every single feature would be useful in the case of this simulation.

Although I would like to let the user choose its position anywhere in the world, this appears to be infeasible. Instead, I would create a handful of maps by hand using topographic SRTM data, USGS's Earth Explorer, and manually add forested and urban areas.

I would divide the AI into several sub-AI. So, an AI would have command over units, and those units would have a commandAI of their own and smaller sub-units down to the individual aircraft/ship/etc... This is so far the best way I have found of simulating the effect of electronic warfare. E.g., commanders could turn off their radio because of [ECOM](https://www.globalsecurity.org/military/library/policy/navy/nrtc/14226_ch3.pdf) and having delayed or outdated objectives.
#### AI case 1 : Machine learning
If I can get the program lightweight enough, I envision using Machine Learning or Q-learning and Neural Network to train the AI against itself. The AI could represent different tactics by changing the reward of actions. I will admit that I do know enough about ML yet to elaborate, but it is something to consider

#### AI case 2 : Tactical AI
If case 1 fails, I would need to code AI the traditional way. different tactics would probably result in different ways to generate the Influence map and pathfinding.<br>
On pathfinding: I think using Interactive-Deepening A* is the best way to go about it. The V.0 would likely mostly center on aircraft, but some things, like low flying and projectile avoidance, still need a robust pathfinding algorithm.
