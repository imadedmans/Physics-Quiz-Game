extends Node

@export var questionsString := "@EASY QUESTIONS
According to the 1st law of motion, An object with balanced forces will...
What is the second law of motion?
What is the third law of motion?
Vectors have both...
What is an example of a scalar?
How is work done calculated?

@MEDIUM QUESTIONS
The normal force is always...
Which of these is NOT a way of detecting radiation?
What causes resistance in a current?
Choose one correct statement about the moment of inertia
Which one of these variables is NOT involved in buoyancy force?

@HARD QUESTIONS
According to Ohm's law, current is proportional to voltage provided...
What is true about Newton's laws of gravity?
What happens on the centripetal force of an object that moves in a circle uniformly?
Which of these SUVAT equations is correct?"

@export var answersString := "@EASY QUESTIONS
remain stationary|move uniformly|remain stationary or move uniformly|accelerate|3
F = mass * net velocty|F = mass x acceleration|Force is always constant|WRONG|2
every action has an different reaction|gravational force is derived from orbital speed|the rate of change of velocity is acceleration|every action has an equal, opposite reaction|4
direction and magnitude|position and magnitude|position and rotation|distance and force|1
force|momentum|velocity|work|4
velocity x distance|Force x distance|Force x acceleration|time * force|2

@MEDIUM QUESTIONS
upwards in the direction of gravity|downwards in the direction of gravity|parellel to the surface|upwards perpendicular to the surface|4
Geiger-Muller counter|photographic tape|silver coating|cloud chamber|3
ban na.|strength of the potential difference provided|the internal temperature of current|collisions between negative electrons and position ions|4
All shapes of objects have the same motion of inertia|A farther mass from the centre gives a larger moment of inertia|An object has to be linearly accelerated|apple|2
mass of fluid|volume submerged in fluid|density of fluid|gravity|1

@HARD QUESTIONS
Resistance is kept low|temperature remains low|temperature remains constant|resistance remains constant|3
used for the equation of GPE|Cannot predict the motion of a satellite|i give up! honestly!|It explains why gravity exists|it involves the nature of magnetism|1
Work done is directly proportional to mass|Work done is equal to grav. Field strength|Work done is zero|Work done is always negative|3
v = u + as|0.5a = t^2 + 2vs|s = ut + v|v^2 = u^2 + 2as|4"

@export var responsesString := "@POSITIVE RESPONSES
That's correct!
Great!
Good job!
You've done me proud, boy! or girl, or whoever you are...

@NEGATIVE RESPONSES MID
That's incorrect!
Hey man. bad.
That, unfortunately, isn't the correct answer

@TIME OUT
You know these questions don't last forever!
C'mon! Put up an effort at least!

@NEGATIVE RESPONSES HARD
Woah! Hey! Are you trying to light my fuse?!
I'm not shaking! You're shaking!
I'm on the edge here y'know!

@DEATH
I not being paid enough for this!
Just when I got this suit cleaned...
I think there may be some room for improvement

@VICTORY
Looks like you got to the end! Well done!
Yes this is what my hand looks like, don't ask.
You reached the end! Time to see the results!"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
