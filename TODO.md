# To do

## Stretch goals

- add music
- speed time up if winnable state and no customers left to spawn
- show speech before derendering customers:
  - professional: "I can't work without cofee!"
  - vegan: "Where are your vegan options!?"
  - old person: "**muffled discontent**"
- make customers move at different speeds
- make original scene a tutorial level then add another level with customemrs
  randomly spawning until 17:00
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
- add customers
  - render customers in a queue on the ground floor using a predefined pattern
    (order and intervals)
- derender customer on signals:
  - coffee machine broken: one professional
  - oat milk drunk: one vegan
  - speaker blasted: one old person
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
- add other sound effects
- show result if success or time reaches 17:30
  - success condition: no customers, no breakages
  - score:
    - success at 17:00: 3 star
    - success before 17:10: 2 stars
    - success before 17:30: 1 star
    - no success at 17:30: 0 stars
- add more levels with increasing customer spawn rate
- add day to level
- add controls testing screen
- render credits on score screen
