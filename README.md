# nats-geolb

This repo provides golang tooling around Nats Jetstream tooling.

- geo load balancing. https://docs.nats.io/running-a-nats-service/environment#load-balancers
- Upgrading of servers and clients.
- Failure mode detection and remediation
- Telemtry.
- Test harness
- Ops Data collection.
- Ops Data viusualisation.


## Use case

3 data centers ( London, Amsterdam, Dallas ) with 3 Nats Servers in each is a decent setup

Client is nats.go as wasm in a browsr as a serive worker.

User Data is html, json and video. web sockets based.

Servers run Nats Server docker.

Load Balancers and Proxies are none. This is the whole point of what NATS Geo Loading balancing advantgaes.

Contaiers are docker.  https://docs.nats.io/running-a-nats-service/nats_docker

Hosting is Fly.io. https://fly.io geo routing to the nearest server toggling to be tested

Hosting is Vultur. https://www.vultr.com geo routing ( any cast ) can be toggles also.

DNS is Google. https://en.wikipedia.org/wiki/Google_Public_DNS does anycast DNS. Needed for NATs Clients intiial connection phase.

DNS is Cloudflare. https://www.cloudflare.com/en-gb/learning/dns/what-is-anycast-dns/ to be tested.


## Operations

Syndia NATS is used as back channel plane to send messages to servers and clients in order to orchestrate everything, whilst servers and clients are in flux. This allows the flexibility and resilence needed.

All the systems listed in the Use case above has APIS that we exploit via the Operations back channel so that we can collect data that match up and compatre use case strategies with real data.

## Failure modes

Scnarios to test:

1. Upgrading Server in a various patterns / strategies. One per data center at a time, so clients still work.
2. Data center complete outage. Clients should reconnect to closed other data center.
3. Data center partial outage, so simulate flapping.
4. Clients scaling up and down in different regions.


## Telemetry

Backblaze S3 in Dallas. 

A Web based Test harness for each client and server.

A Web base Test Harness for the Syndia back channel apps system.

## Back channel tooling

Fly.io cli can be orchestrated by NATS Syndia. We do NOT want syndia to do any Geo load balacning but do explicit connections when driving thigs so that we do not get hysterics.

We can then drive the clients and servers in different ways

## Back channel data collection

We need to collect data and feed it to the HTML Web GUI.





