# To do

- update key tutorial per design
- switch order of intro and tutorial
- add 0 stars sad sound effect
- add retry option (retry or continue options with arrow and interact selection)
- add level select
- add music
- speed time up if winnable state and no customers left to spawn
- semi-randomise character types (make sure you don't just get one type, and
  maybe make sure you get at least one of each type)
- show speech before derendering customers:
  - professional: "I can't work without cofee!"
  - vegan: "Where are your vegan options!?"
  - old person: "**muffled discontent**"
- make customers move at different speeds
- add slider challenge to fix problems
- add clock graphic
- add slow time accessibility option
- rename customer spawner queue manager given it manages movement until they
  leave the queue?

## Done

### Post-jam

- add intro scene with details about gameplay and customers
- shift queue end to left of counter, or left end of counter

### Jam

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
- add title

## Icebox

- add option to serve customer in queue which takes longer than 'breaking' and
  fixing (or the other options remove all customers by type, whereas serving
  removes one customer)
- stop attracting customers by type based if coffee machine broken, no oat milk,
  or speaker on; fix to start attracting them again (but what's the aim of
  attracting them?)
- add cooldown on breaking things
- add coyote time? probably not relevant given the current level design doesn't
  have any platforms you could fall off but still need to jump
- add variable jump height? also probably not useful given there are just four
  jump spots of rouhgly equal height
