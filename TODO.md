# To do

- add player collision detection
  - on coffee machine
    - render icon? (or will this show all the time to indicate state?)
  - on oat milk
    <!-- - render input prompt: "Q" to drink -->
    - on input, render vomit in random spot and send signal
  - on speaker
    - render icon? (or will this show all the time to indicate state?)
    - on input, render crack in random spot
  - on vomit
    <!-- - render input prompt: "E" to clean -->
    - if input > N seconds, derender
  - on crack
    <!-- - render input prompt: "E" to tape/fix -->
    - if input > N seconds, derender (or switch to taped state if a taped sprite
      is available)
- add customers
  - render a professional in the seating area
  - render a vegan in the counter area
  - render an old person in the counter area
- derender customers on signals:
  - coffee machine broken: professional(s)
  - oat milk drunk: vegan(s)
  - speaker turned on: old person
- show speech before derendering customers:
  - professional: "I can't work without cofee!"
  - vegan: "Where are your vegan options!?"
  - old person: "**muffled discontent**"
- show result if success or time reaches 17:30
  - success condition: no customers, no breakages
  - score:
    - success at 17:00: 3 stars ("Lock the doors, let's have a kiki!")
    - success before 17:10: 2 stars ("Business as usual")
    - success before 17:30: 1 star ("I'm going to be late for the gym :'(")
    - no success at 17:30: 0 stars ("We don't pay overtime! Get out of here!")
  - stop main input/physics processes, take restart/return to menu input

## Stretch goals

- add other sound effects
- make original scene a tutorial level then add another level with customemrs
  randomly spawning until 17:00
- add music
- add more levels with increasing customer spawn rate
- add slider challenge to fix problems
- add option to serve customer in queue which takes longer than 'breaking' and
  fixing (or the other options remove all customers by type, whereas serving
  removes one customer)
- stop attracting customers by type based if coffee machine broken, no oat milk,
  or speaker on; fix to start attracting them again (but what's the aim of
  attracting them?)
- add cooldown on breaking things
- add slow time accessibility option
- add coyote time
- add variable jump height

## Done

- add floors and steps with collision detection (one way for steps)
- add player with movement physics
- add counter and tables
- add coffee machine, oat milk, and speaker with collision detection
- add jump buffering
- add 1 hour timer
- add title screen
- add jump sound effect
- add player collision detection
  - on coffee machine
    - in working state, on input, switch to broken state and send signal
    - in broken state, if input > N seconds, switch to working state
  - on speaker
    - on input, send signal
