# Testing

> “Program testing can be used to show the presence of bugs,
> but never to show their absence!”
>
> - Edsger W. Dijkstra

## Glossary

- Collaborator
  - Shared and/or mutable dependency (Database, FileSystem, API, Object, Atom)
- Stub (Query)
  - Predefined return value so you can test specific cases
- Mock (Command)
  - Verify collaborator's private implementation is called with specific
    parameters and certain amount of times
- London style (Mockist)
  - Isolate class from all collaborators
- Classical style
  - Isolate test from shared collaborators (Database)
- Degenerate cases
  - Handle bad/problematic inputs e.g.
    (nil, empty collection, string start with space)
- Triangulation
  - Add more examples to further exercise test case (Theory (xunit), tabular (midje))
- Black box
  - Call function without caring about implementation
- White box
  - Call Mocked function asserting is called and maybe with certain parameters.
- Unit
  - Test __small__ within process
  - Test you are building the thing correctly
- Acceptance
  - Test business requirements
  - Test you are building the right thing
- Integration
  - Test against 3rd party API

## Unit test

1. What are you testing?
1. What should it do?
1. What was the actual output?
1. What was the expected output?
1. How do you reproduce the failure?

### Constraints

1. Readable
   1. Write the test you want to read
   1. Names should be a clear scenario and expectation
   1. Gherkin is a good structure but don't limit yourself to it
      1. Given player 2 has 0 points
      1. When player 2 scores
      1. Then player 2 should have 15 points
   1. Delivery date before dispatch date is invalid
1. Verifies a ___small___ piece of code
   1. No definitive size like a class or function it's more an 'area of focus'
1. Quick
   1. Run in ms
1. Isolated, no two tests share global mutable state.
   1. No side effects
   1. No shared global state (Database) because of race conditions
   1. Use a Stub to replace mutable state (Database, File, Api)

## Acceptance (ATDD) / Behaviour (BDD)

Acceptance tests check software does what the business wants,
Units tests test edge cases (TDD).

- Acceptance tests make sure that you're building the right thing
- Unit tests make sure that you're building the thing right

## TDD

1. Write production code only to pass a failing unit test.
   1. Ensures you write test First
   1. Ensures the unit test is failing
1. Write no more of a unit test than sufficient to fail
   (compilation failures are failures).
1. Write no more production code than necessary to pass the one failing unit test.
   1. Only write more code to pass test

### TDD Benefits

- Acts a regression testing so you can refactor
- Ensures certain edge case (common business/error cases) are covered
- Acts as documentation
- Easier to write than Property Based
- Peak - Andres Ericsson
  - Specific goal
  - Fast feedback
  - Small Pomodoro sized task for better focus

### TDD Cons

- Crashing into barriers to end up where you need to go - Rich Hickey
- Transformation Priority Premise is a `PREMISE`
- Can't prove program is correct.
100% Test coverage doesn't mean program is correct
- Not as thorough as Property based test
  - Highlight bugs/edge cases you didn't think of
  - Diamond kata is difficult to test with example cases

## Order of test

. What test should I write?

1. Degenerate cases
    - nil, empty, 0, default, string starting with space, etc..
1. Simple
    - One element (Sorting function)
    - A row (Diamond kata)
    - All 0 (Bowling kata)
1. Complex
    - Handle new line `(wrap 1 "aa")` (word wrap)
    - Word is mid line break `(wrap 3 "a bb"` (word wrap)
    - B row (Diamond kata)
    - Strike (Bowling kata)

## How to handle Collaborators

- Query (Blackbox)
  - Stub shared collaborators (Database, File System)
- Command (Whitebox)
  - Spy on command to ensure it was called,
  called with expected parameters, and called correct amount of times

## How to write tests

1. Three laws of TDD
    1. Write production code only to pass a failing unit test
        1. Ensures you write test first
        1. Ensures the unit test is failing
    1. Write no more of a unit test than sufficient to fail
    (compilation failures are failures)
    1. Write no more production code than necessary to pass the one failing unit test.
        1. Only write more code to pass test
1. Assert first
    - Prioritize what you want to assert first.
    Then let errors lead creating the arrange, act, and code.
1. Zero, One, Many
    1. If collection, handle single element first then handle collection

## How should I write my code?

- Transformation Priority Premise
  - Apply transformations to production code
- Fake it til you make it (Triangulation)
  - Use basic implementations then add more and more logic the more tests
    you add (As the tests get more specific the code gets more generic)

## Example - Word wrap

1. Bad input returns empty string
    - `(wrap 1 nil) -> ""`
    - `(wrap 1 "") -> ""`
1. Space at start of string returns string without space
    - `(wrap 1 " a") -> "a"`
1. Input length is less than width so return input
    - `(wrap 1 "a") -> "a"`
1. Line split puts each string on to a new line
    - `(wrap 1 "a\nb") -> "a\nb"`
1. Line split mid word keeps word intact
    - `(wrap 3 "a bb") -> "a\nbb"`

## Example - Invert name

1. Bad input returns empty string
    - `(invert nil) -> ""`
    - `(invert "") -> ""`
1. Invert first and last name
    - `(invert "First Last") -> "Last, First"`
1. Ignore honorific
    - `(invert "Mr. First Last") -> "Last, First"`
1. Keep post nominal
    - `(invert "First Last Phd.") -> "Last, First Phd."`
