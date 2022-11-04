= Micro services

`The microservices architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanism`

Microservice::
Performs one capability (shopping cart, user profile) or technical capability (Auth, Notifications)

Lightweight mechanism::
Queues (Kafka), HTTP (HATEOS)

== Why

* Independently deployable
** MVP - Can deliver services incrementally
** Scale - Some services will require more instances than others
** Can fix/update one service independently without impacting others

