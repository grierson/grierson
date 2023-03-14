# Observability

Observability lets you inspect your system so you can see what is happening
so that you can

* See why an error occured
* Find bottlenecks within your system

* Metrics - Measure frequence
  * Endpoint request rate
  * Endpoint failure rate
  * CPU utilisation
* Logs - Sequence of events so you can workout what happened
  * 2021-02-23T13:26:23 - INFO - GET "/"
  * 2021-02-23T13:26:30 - ERROR - POST "/buy"
* Trace - Benchemark how long request took and see journey of request
  * Measures request (Span) from beginning to end (Including sub traces)
  * Create system map so you can see what services make calls to what endpoints
