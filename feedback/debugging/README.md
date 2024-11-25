# Debugging

- (Rich Hickey) - Father Wattson's questions
  - Where are you at?
  - Where are you going?
  - What do you know?
  - What do you need to know?
- Apply the scientific method in small steps
  - Write down your experiments and results
- Breakdown and simplify the problem.

## Mindset

![Sherlock Holmes](/resources/sherlock-holmes.png)

- Being stuck is only temporary
  - There is always a logical explanation
- Iterative process
  - Progressively ask less stupid questions
- Time box
  - Avoid wasting hours in a rabbit hole
- Prioritise
  - An unlikely bug with little consequence doesn't need to be fixed right away

### Steps

```mermaid
flowchart LR
    Failure -->|Why?| Hypothesis
    Hypothesis -->|Suggests| Experiment
    Experiment -->|Produces| Observation
    Observation -->|Falsified?/Needs refinement| Hypothesis
    Observation -->|Something is wrong| Failure
    Observation -->|Actual cause| Theory
```

## 1. Failure

Something isn't working as expected.

### 🔥🔥🔥 STATE THE PROBLEM 🔥🔥🔥

> If you don't know where you are going, you might wind up someplace else.
>
> - Yogi Berra

![Writing](/resources/writing.png)

- Feynman technique (Rubber duck method)
  - Explain the problem (Write it down, Talk to rubber duck)
  - Improve your explanation as you go along
  - Does your explanation cover every point?
  - Where are you at?
  - Where are you going?
- Deductive reasoning (Suduku)
  - I can solve this smaller problem which will help with this bigger problem
  - What do we know? (Constraints, Facts)
  - What do we need to know?
    - What is `x`?
    - Does `y` work how I expect?

### Skepticism

Be skeptical of what's presented to you

```text
"There were no footmarks" - Man
"Meaing that you saw none?" - Sherlock

- The Return of Sherlock Holmes
```

> "The error occurs on Cassandra but not H2"
>
> - Someone

Don't take their word for it, **test it**!
Test the problem happens on both databases where you find it happens on both
and it was a miscommunication issue all along.

### Sequence of events

![Sequence](/resources/sequence.png)

- 🔥 Map the sequence of events that lead to bug
  - Draw it
    - Sequence (Backed with logs)
    - Network
    - State
- What did you/they expect compared to what happened?
  - Analyse the evidence
    - Get a screen recording/screenshot.
    - Read the logs/stack trace **carefully!!!**
    - Check the database/event feed/queue
- Check recent commits (Git bisect)

### Can you reproduce the bug?

- Reproducing the bug means you can control each variable while you experiment
- Create a smaller program with the same bug so you have fewer variables and a
  quicker feedback loop

### Print statements

![Pressure](/resources/pressure.png)

Just like gauges in mechanical systems, add instrumentation to
your system so you can see what happening

```clojure
;; Example using weavejester/hashp

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

;; Of the 4 expressions we've tested we've narrowed it down to one.
;; Simplifing the problem
;; (- (first n) 20) -> Exception
```

Or better yet just evaluate each expression in the REPL

### Research

![User guide](/resources/user-guide.png)

- RTFM
- Google
- Retrace from the line that failed and work backward on what may have led
  to the cause
- Compare with a working example from the project docs

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

Only passing `","` `to Clojure`.`string/join` uses the single arity function

## 2. Hypothesis (Cause)

A proposed explanation made based on **limited evidence** as
a **starting point** for further investigation

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

![Think](/resources/think.png)

- 🔥 Write down your hypothesises
- Include silly ideas
- Prioritise
- Hammock time
- Only move forward when you have enough data

### Hypothesis Example

```clojure
(def partial-join (partial (clojure.string/join ",")))

(partial-join ["foo" "bar"])
; => Exception!
```

- `string/join` doesn't do what I want
- `partial` doesn't do what I want
- `def` doesn't do what I want

## 3. Experiment

1. Reproducible
2. Driven by hypothesis
3. Small
4. Change only one thing

![Experiment](/resources/experiment.png)

- 🔥 **Write down your experiments**
  - What variable did you test?
  - What did you expect? What was the actual result?
  - Why does the experiment make sense?
- Short feedback loop
  - REPL
  - Unit test
  - Try good and bad inputs to demonstrate the defect

## 4. Observation

![Report](/resources/report.png)

- Understand all the outputs
  - Don't know the output? How do you know if it's related to the problem or not
- Use good tools (More outputs)
  - Debuggers, Logging, Print, Metrics

```markdown
IF EXPERIMENT supports HYPOTHESIS
THEN refine the HYPOTHESIS or DIAGNOSE
ELSE reject HYPOTHESIS
```

## 5. Theory (Diagnosis)

![Lightbulb](/resources/lightbulb.png)

- A hypothesis offering valid predictions that can be observed
- Blog/tell a friend what you learned
- Does theory cover all of your problems
- Take a break

# Tools

- Debugger
- Profilers - perf
- Tracers - strace
- Network spy - ngrep

## Resources

- [Design in Practice - Rich Hickey](https://youtu.be/c5QF2HjHLSE?si=JKrXAgNi3q_ZEMcc)
- [Debugging with the Scientific Method - Stuart Halloway](https://www.youtube.com/watch?v=FihU5JxmnBg&ab_channel=ClojureTV)
- [Sherlock Holmes, Consulting Developer - Stuart Halloway](https://www.youtube.com/watch?v=OUZZKtypink&ab_channel=ClojureTV)
- [Hammock Driven Development](https://www.youtube.com/watch?v=f84n5oFoZBc&ab_channel=ClojureTV)
- [Running with Scissors](https://www.youtube.com/watch?v=Qx0-pViyIDU&ab_channel=StrangeLoopConference)
- [REPL DEBUGGING: NO STACKTRACE REQUIRED](http://blog.cognitect.com/blog/2017/6/5/repl-debugging-no-stacktrace-required)
- [The Pocket Guide to Debugging](https://wizardzines.com/zines/debugging-guide/)
- [ByteByteGo - Debugging Like A Pro](https://blog.bytebytego.com/p/ep48-debugging-like-a-pro)
- [Clojure from the ground up: debugging](https://aphyr.com/posts/319-clojure-from-the-ground-up-debugging)

## Credits

- [Sherlock icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/sherlock)
- [Writing icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/writing)
- [Sequence icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/sequence)
- [Pressure icons created by surang - Flaticon](https://www.flaticon.com/free-icons/pressure)
- [Guideline icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/guideline)
- [Think icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/think)
- [Experiment icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/experiment)
- [Report icons created by catkuro - Flaticon](https://www.flaticon.com/free-icons/report)
- [Idea icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/idea)
