# Testing overview

## Glossary

* Collaborator
  * Shared and/or mutable dependency (Database, FileSystem, API, Object, Atom)
* Stub (Query)
  * Hard coded return value in order to test specific case without calling directly
* Mock (Command)
  * Verify collaborator is called with specific parameters and the amount of times
* London style
  * Isolate class from all collaborators so that you are only testing that class

* Classical style (Black box) - Isolating tests from others
  * If multiple tests only Query the Database - OK
  * If one test mutates a database causing race conditions - BAD
  * If a set-up function restores the database before each unit test - OK

* Degenerate cases
  * Handle bad/problematic/edge case inputs (nil, empty collection)

* Triangulation
  * Add more examples to further exercise test case (Theory (xunit), tabular (midje))

## Unit size

> Unit tests test individual units (modules, functions, classes) in isolation
>
> -- <cite>Test Driven Development By Example</cite>

> Test against a class through its public interface.
>
> -- <cite>Xunit patterns</cite>

> Object-oriented design tends to treat a class as the unit,
> procedural or functional approaches might consider a single function as a unit.
> But really it's a situational thing. - Martin Fowler
>
> -- <cite>Martin Fowler</cite>

Unit has no definitive size like a class or function it's
more an 'area of focus' but they do have some constraints.

* Verifies a small piece of code (also known as a unit),
* Quick, milliseconds
* Isolated, no two tests share global mutable state.
  * London/Mockist - Mock all dependencies.
  * Classical - Only stub Shared state

To Handle shared mutable state (Database, File, Api) in both
Classical and Mockist then use Stub for expected value

## Acceptance (ATDD) / Behaviour (BDD)

Acceptance tests check software does what the business wants,
Units tests test edge cases (TDD).

* Acceptance tests make sure that you're building the right thing
* Unit tests make sure that you're building the thing right

## Integration

Talks to real DB

## Functional / End 2 End / UI testing

Test the system from a user level by automating interacting with the software.

## Black vs White box

* Black box => Call function without caring how it works
* White box => Call function with Mock asserting mock function is called.
