# Debugging

Having the right mindset

* There is always a logical explanation
* Being stuck is only tempory
* Timebox
* Priortise
  * An unlikey bug with little consequence doesn't need to be fixed right away

![Sherlock Holmes](./resources/sherlock-holmes.png)

```mermaid
flowchart LR
    Failure -->|Why?| Hypothesis
    Hypothesis -->|Suggests| Experiment
    Experiment -->|Produces| Analysis
    Analysis -->|Falsified?/Needs refinement| Hypothesis
    Analysis -->|Something is wrong| Failure
    Analysis -->|Actual cause| Theory
```

## Failure

Something isn't working as expected.

### :fire: !!! __STATE THE PROBLEM__ !!! :fire: #1

> If you don't know where you are going, you might wind up someplace else

<img align="right" src="./resources/writing.png">

1. Steps taken
2. What was expected
3. What actually happend

### Challenge understanding

<img align="right" src="./resources/rubber-duck.png">

* Write down your understanding and improve as you go along
  * Does you explanation cover every point?
* __Iterative process__ - Progressively ask less stupid questions
* __Feynman technique__ - Teach problem to finds the gaps in your understanding

### Sequence of events

<img align="right" src="./resources/sequence.png">

* :fire: Write down the sequence of events that lead to bug
* Analyse the evidence
  * Get screen recording/screenshot
  * Analyse the logs
  * Check the database/event feed/queue
* Draw it
  * Flowchart
  * Network
  * State
  * Sequence (Backed with logs)
  * Graphviz
* Read the stacktrace __carefully!!!__
* Check recent commits (Git bisect:fire:)

### Observation

<img align="right" src="./resources/identify.png">

* What do we know? (Constraints, Facts)
* What do we need to know?
  * What is `x`?
  * Does `y` work how I expect?

### Reproduce the bug

<img align="right" src="./resources/bug-report.png">

* Reproducing the bug means you can control each variable while you experiment
* Create a smaller program with the same bug so you have less variables
and a quicker feedback loop

#### Skepticism

<img align="right" src="./resources/question.png">

* "There were no footmarks" - Man
* "Meaing that you saw none?" - Sherlock

"Error occurs on Cassandra but not H2"

Write a test that performs the problem query against both databases so
have no other dependencies.

The problem was actually a miscommunication problem,
reproducing the issue showed the problem occured on both databases

#### Instrument

<img align="right" src="./resources/pressure.png">

Just like gauges in mechanical systems, add instrumentation to
your system so you can see whats happening

* REPL
* Print statements
* Logging
* Tracing

```clojure
(defn n 24)

(defn foo
      [n]
      (cond #p (> n 40) #p (+ n 20)
            #p (> n 20) #p (- (first n) 20)
            :else #p 0))

(foo n)

;; (> n 40) -> false
;; (+ n 20) -> 44
;; (> n 20) -> true
;; (- (first n) 20) -> Exception
;; 0 -> 0
```

### Research

<img align="right" src="./resources/user-guide.png">

* RTFM
* Google
* Retrace from the line that failed and work backwards on what may have led
to the cause
* Compare with a working example from the project docs

#### Example

```clojure
(def partial-join (partial (clojure.string/join ",")))

(partial-join ["foo" "bar"])
; => Exception!
```

String join docs

```text
(join coll) (join separator coll)

Returns a string of all elements in coll, as returned by (seq coll),
 separated by an optional separator.
```

## Hypothesis (Cause)

A proposed explanation made on the basis of __limited eviedence__ as
a __starting point__ for further investigation

Cause mapping (N whys). More than one reason why something happened.

```mermaid
flowchart LR
    ts[Titanic sank] --> wfh[Water filled hull]
    wfh --> oih[Opening in hull]
    oih --> hppaas[Hull plates pulled apart at seams]
    hppaas --> wr[Weak Rivets]
    hppaas --> shi[Ship hit iceberg]
    shi --> lsil[Lookout saw iceberg late]
    shi --> sti[Ship turn ineffective]
```

An event preceding an effect without which the effect would not have occurred

<img align="right" src="./resources/think.png">

* :fire: Write down your hypothesises
* Include silly ideas
* Use deductive reasoning to remove bad hypothesises
* "Eliminate all other factors, and the one which remains must be the truth" - The Sign of Four
* Priortise by likeliness
* Think of tests to prove or disprove hypothesis
* Hammock time
* Only move foward when you have enough data

### Example

```clojure
(def partial-join (partial (clojure.string/join ",")))

(partial-join ["foo" "bar"])
; => Exception!
```

* `string/join` doesn't do what I want
* `partial` doesn't do what I want
* `def` doesn't do what I want

## Experiment

1. Reproducible
2. Driven by hypothesis
3. Small
4. Change only one thing

<img align="right" src="./resources/experiment.png">

* :fire: __Write down your experiments__ :fire:
  * What variable did you test?
  * What did you expect? What was the actual result?
  * Why the experiment makes sense?
* Short feedback loop
  * Unit test
  * Try good and bad inputs to demonstrate defect

## Analysis

1. Understand all the outputs
   1. Don't know the output? How do you know if it's related to the problem or not
2. Suspect correlations
   1. Bug in the last 5 lines
3. Use good tools (More outputs)
   1. Debuggers, Logging, Print, Metrics

<img align="right" src="./resources/report.png">

* IF experiment supports hypothesis
* THEN refine hypothesis or diagnose
* ELSE reject hypothesis

## Theory (Diagnosis)

<img align="right" src="./resources/lightbulb.png">

* A hypothesis offering valid predictions that can be observed
* Blog/tell a friend what you learned
* Does theory cover all of you problems
* Take a break

## Tools

* Debugger
* Profilers - perf
* Tracers - strace
* Network spy - ngrep

## Resources

* [Sherlock Holmes, Consulting Developer - Stuart Halloway](https://www.youtube.com/watch?v=OUZZKtypink&ab_channel=ClojureTV)
* [Debugging with the Scienific Method](https://www.youtube.com/watch?v=FihU5JxmnBg&ab_channel=ClojureTV)
* [Hammock Driven Development](https://www.youtube.com/watch?v=f84n5oFoZBc&ab_channel=ClojureTV)
* [Running with Scissors](https://www.youtube.com/watch?v=Qx0-pViyIDU&ab_channel=StrangeLoopConference)
* [REPL DEBUGGING: NO STACKTRACE REQUIRED](http://blog.cognitect.com/blog/2017/6/5/repl-debugging-no-stacktrace-required)
* [Clojure from the ground up: debugging](https://aphyr.com/posts/319-clojure-from-the-ground-up-debugging)

## Attribute

* <a href="https://www.flaticon.com/free-icons/duck" title="duck icons">Duck icons created by Freepik - Flaticon</a>
* <a href="https://www.flaticon.com/free-icons/sherlock" title="sherlock icons">Sherlock icons created by Freepik - Flaticon</a>
* <a href="https://www.flaticon.com/free-icons/identify" title="identify icons">Identify icons created by Eucalyp - Flaticon</a>
* <a href="https://www.flaticon.com/free-icons/sequence" title="sequence icons">Sequence icons created by Freepik - Flaticon</a>
* <a href="https://www.flaticon.com/free-icons/experiment" title="experiment icons">Experiment icons created by Freepik - Flaticon</a>
* <a href="https://www.flaticon.com/free-icons/bug" title="bug icons">Bug icons created by Freepik - Flaticon</a>
* <a href="https://www.flaticon.com/free-icons/question" title="question icons">Question icons created by Freepik - Flaticon</a>
