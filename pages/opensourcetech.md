# Open Source Technologies

[Back](../README.md)

### List of Contents

* [Kafka VS RabbitMq](#kafka-vs-rabbitmq)
* [Kafka](#kafka)
* [RabbitMq](#rabbitmq)
* [Redis](#redis)

## Kafka VS RabbitMq
|              | Kafka                      | RabbitMq                  |
| ------------ | -------------------------- | ------------------------- |
| Intuition    | Write log                  | Sends message             |
| Retention    | Delete after fixed time    | Delete after acked        |
| Payload      | Default 1MB                | No max                    |
| Priority     | Can't change               | Can use priority queue    |
| Ordering     | Perserved within partition | Perserved                 |
| Pull or push | Consumer pull              | Producer push             |
| Data         | High throughput            | Simpler                   |

* Kafka intuition: Producer write messages, consumer to read, consumer monitors the offset and commits offset so broker won't send the same message again to this partition. Message deleted after a fixed time.
* RabbitMq intuition: Producer sends message in batches via broker to consumer. Message deleted once consumer acked it.

* Kafka good for:
  * Big data, data stream processing
  * System activity, aduit
* RabbitMq good for:
  * Order, user requests
  * Connect microservices and legacy services

[Back To Top](#list-of-contents)

## Kafka

* **Producer**
  * Publish message to a topic, sync or aysnc.
  * Implemented in application.
* **Consumer**
  * Subscribe to a topic and pull messages.
  * Messages are stored via ZooKeeper
  * Implemented in application.
* **Broker**
  * Kafka server
* **Cluster**
* **Topic**
* **Partition**
  * Messages within a partition always arrives in order
* **Offset**
  * Position within a partition
  * The offset for the next new record, so Kafka won't send the committed records again for the same partition.
  * When commit job offset 5. Then previous 4, 3, 2 will also be committed.
* **Consumer group**

* Configurations
** **"Read once" application**: use auto commit.
** **"Process once" application**: use manual commit.

* Kafka stream

## RabbitMq
* **Queue**
  * Transmit the messages
* **Producer**
  * Sends messages, which have payload and label.
  * Implemented in application.
* **Consumer**
  * Subscribe to a queue, read in a loop, process then ack.
  * Implemented in application.
* **Exchange**
  * Route messages
* **Broker**
  * RabbitMq server
* **Binding**
  * Instruct exchange for how to route a message.

## Redis


[Back To Top](#list-of-contents)