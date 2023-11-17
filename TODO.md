# To do

- render icons
  - coffee machine
    - fixed
    - broken
  - oat milk
    - full
    - empty
  - on speaker
    - turn up
  - on spillage
    - clean
  - on crack
    - tape
- add customers
  - render a professional in random position in the seating area
  - render a vegan in random position in the counter area
  - render an old person in random position in the counter area
  - work out how to spawn randomly to create a challenge that's doable but not
    hackable/easy (i.e. can't just wait until near the end to throw everyone
    out). Perhaps only one customer derenders per action, and you keep getting
    new customers at random intervals until 16:55? Will it feel fair if you get
    one at 16:55 one time and not another?
- derender customer on signals:
  - coffee machine broken: one professional
  - oat milk drunk: one vegan
  - speaker blasted: one old person
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
- render credits on score screen
- add other sound effects
- add music

## Stretch goals

- make original scene a tutorial level then add another level with customemrs
  randomly spawning until 17:00
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
    - on input, send signal and render crack in random spot
  - on oat milk
    - on input, send signal and render spillage in random spot
  - on spillage
    - if input > N seconds, derender
  - on crack
    - if input > N seconds, derender
- track fixables (stuff left to fix/clean up)
