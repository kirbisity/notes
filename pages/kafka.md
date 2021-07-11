# Kafka

[Back](../README.md)

### List of Contents

* [Concepts](#concepts)
* [Configurations](#configurations)
* [Kafka stream](#kafka-stream)

## Concepts

* **Producer**
* **Consumer**
* **Broker**
* **Cluster**
* **Topic**
* **Partition**
  * Messages within a partition always arrives in order
* **Offset**
  * When commit job offset 5. Then previous 4, 3, 2 will also be committed. Cannot commit arbitrary number.
* **Consumer group**

[Back To Top](#list-of-contents)

## Configurations

* **"Read once" application**: use auto commit.
* **"Process once" application**: use manual commit.

[Back To Top](#list-of-contents)

## Kafka stream

[Back To Top](#list-of-contents)