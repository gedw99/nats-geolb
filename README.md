# nats-geolb

Nats Jetstream can provide geo load balancing.

This repo provide golang tooling to use it and also manage it.

## Use case

3 data centers ( London, Amsterdam, Dallas ) with 3 Nats Servers in each is a decent setup

Client is nats.go as wasm in a browsr as a serive worker

Data is html, json and video. Video stremaing over nats using web soc ket works very well.

Servers run Nats Server embedded to make upgrades easier.

Load Balancers and Proxies are none. This is the point.

Contaiers are docker.

Hosting is Fly.io, so that we have fast cycling of the servers to simukaet failure modes. NOTE: check is we can turn off the AnyCast aspects of fly.io geo routing to the nearest server and also turn it on. This is a critical aspect to this.

DNS is a standard basic one with no Geo DNS or anythign special. We dont need BGP or anycast is the whole point.


## Operations

Syndia NATS is used as back channel plane to send messages to servers and clients in order to orchestrate everything, whilst servers and clients are in flux. This allows the flexibility and resilence needed.

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





