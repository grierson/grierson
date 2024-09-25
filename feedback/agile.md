# TL;DR Agile

- Work in small steps so you can course-correct and prevent unnecessary work
- Determine the value of the work first. Is it even worth doing?
  - If it is, what does success look like, and how do we measure it?
    - Where are you currently?
    - Where do you want to be?
- Drop anything that gets in the way of productivity.
- Take pride in your work.

# Continuously delivering small value

> Our highest priority is to satisfy the customer through early and continuous delivery of valuable software.
>
> - Agile Manifesto

> Best value comes from small, value-focused features delivered frequently.
>
> - The nature of software development

> Deliver as fast as possible
>
> - Lean Software Development

## Take small steps to avoid the Sunk-cost fallacy

> the phenomenon whereby a person is reluctant to abandon a strategy or course
> of action because they have invested heavily in it, even when it is clear that
> abandonment would be more beneficial.
>
> - Sunk-cost fallacy

If you have a one-month plan but find out after a week that demand has changed,
or you've learned more about the problem and realised the plan is wrong. Do you
continue?

Avoid planning large amounts of work together as it prevents reacting to change,
or if you abandon the plan, then you've wasted time planning it in the first
place. Instead, work in smaller increments.

- (Agile) Responding to change over following a plan
- (XP) Embracing change - Respond to customer demand

## Fail fast, Fail often

You release a month's work with many new features only to receive negative
feedback. Which features are valuable? It's difficult to decipher from all the
noise on the release.

Or maybe the first feature you worked on is the problem, and all the other
features you created stemmed from that, so everything needs to be reworked.

If we delivered frequently in smaller steps and received feedback, then we can
course-correct to avoid unnecessary work, measure the value, and avoid extensive
upfront planning.

## Evidence driven

> If you don't know where you are going, you might wind up someplace else
>
> - Yogi Berra

Not having a goal or working on features that don't provide feedback on your
progress towards a goal is aimless.

Only work on features that verify hypotheses, so progress via small experiments
that test assumptions and use the results to direct you towards your goal.

- Impact Mapping
- (Lean) Improvement kata
- (Lean) A3 Process
- (Rich Hickey) - Father Wattson's questions
  - Where are you at?
  - Where are you going?
  - What do you know?
  - What do you need to know?

## Small steps guided by evidence

Mapping these two traits into a quadrant chart creates a value map. On the X
axis is the size of the experiment and the amount of effort required to achieve
it. The bigger the experiment, the more risk, as it might be a wrong assumption,
causing wasted effort and resources. On the Y axis is how much the task aligns
with your goals and how much accurate feedback you expect to receive from
completing the work.

If a hypothesis is valuable towards our goal but not broken down into smaller
experiments, making it a more significant risk, or we have an experiment with no
data to support our goals, we should avoid it. Prioritize work with low-risk but
high data towards your goals.

```mermaid
%%{init: {"themeVariables": {
"quadrant1Fill": "#FFB54C",
"quadrant2Fill": "#8CD47E",
"quadrant3Fill": "#FFB54C",
"quadrant4Fill": "#FF6961"
}}}%%
quadrantChart
    title First Tesla Car
    x-axis Low Risk --> High Risk
    y-axis Low Feeback --> High Feedback
    quadrant-1 Maybe
    quadrant-2 Yes
    quadrant-3 Maybe
    quadrant-4 No
    Sports convertible: [0.2, 0.8]
    Mass Sedan: [0.8, 0.8]
    Motorbike: [0.2, 0.3]
    Some strawman example: [0.8, 0.3]
```

If you were Elon Musk in the early 2000s and wanted to build an electric car
company, what type of car would you choose first?

- Strawman

  - Some strawman example.

- Motorbike

  - Manufacturing motorcycles would be less complicated and more affordable than
    car production, allowing Tesla to start manufacturing. However, the target
    audience is car drivers; manufacturing motorcycles isn't creating accurate
    data towards the goal of electric cars.

- Mass produce Sedan

  - Tesla could have started with a mass-produced Sedan car as it's the most
    popular type in the USA; however, that requires mass-producing cars when
    they haven't even built one. And they are competing in a market with
    companies with solid footholds.

- Sports car
  - Instead, Tesla manufactured a small batch of Sports cars (Roadster),
    allowing Tesla to start manufacturing on a smaller scale and aim at a
    smaller target market with less competition.

## Waste (Lean)

Drop or improve any activities or resources that don't add value—measure to
determine the value and determine if it needs improvement or dropping
altogether.

Examples:

- Delay from dependencies - Why is it delayed? Can we prevent it in future?
- Extra features implemented that don't help towards hypothesis
- Abandoned work from bad planning
- Defects - Rushed work to meet a deadline but now the tech debt is back
- Relearning
- Handoffs
- Context switching

Principles:

- (Lean) Eliminate waste
- (Lean) Optimise the Whole
- (Agile) At regular intervals, the team reflects on how to become more
  effective, then tunes and adjusts its behavior accordingly.
- (Agile) Simplicity--the art of maximizing the amount of work not done--is
  essential.

Tools:

- Value Stream Mapping so you can identify inefficiencies
- Kanban
  - Visualise workflow
  - Tracks lead time on tickets and helps identify how it can be optimised
  - Limits unfinished work and Context-switching
  - Helps identify bottlenecks to eliminate waste

## Decide as late as possible (Lean)

Don't make decisions when you don't need to. Instead, wait as late as possible
so that you can make the most educated decision.

- (Agile) Welcome changing requirements, even late in development. Agile
  processes harness change for the customer's competitive advantage.
- (Lean) Defer Commitment Make decisions as late as possible to make more
  informed choices
- (XP) Embrace Change

## Quality (XP)

Technical debt will creep back up as a bigger problem

- (XP) Quality work
- (Lean) Build Quality In
- (Agile) Continuous attention to technical excellence and good design enhances
  agility.
- (Agile) Working software is the primary measure of progress.
- (Agile) Agile processes promote sustainable development. The sponsors,
  developers, and users should be able to maintain a constant pace indefinitely.

- Feedback loops

  - Pair Programming
  - Test Driven Development
  - Continuous Delivery
  - Review customer feedback

- Mistake proofing
  - Infrastructure as code
  - Component tests

## Communication (XP)

- (XP) Communication. Everyone on a team works jointly at every stage of the
  project.
- (Agile) Business people and developers must work together daily throughout the
  project.
- (Agile) The most efficient and effective method of conveying information to
  and within a development team is face-to-face conversation.

## Respect (XP)

- (Lean) Respect People - A positive and collaborative work environment improves
  productivity
- (Agile) Build projects around motivated individuals. Give them the environment
  and support they need, and trust them to get the job done.
