# Docker

[Back](../README.md)

### List of Contents

* [Concepts](#concepts)

## Concepts

* **image**: Template for creating a container.
  * An image can be based on another image with additional customization.
* `Dockerfile`: Recipe for building an image.
  -  When Docker executes `Dockerfile` commands, it produces an image.
  - Installs build dependencies, development tools not in the base image and configure the environment.
  - Each instruction in `Dockerfile` creates a layer in the image. When you change the `Dockerfile` and rebuild the image, only those layers changed are rebuilt.
* **container**: Runnable instance of an image.
  * When docker engine runs an image, you get a container which is a process/service.
* **docker-compose**: Define and run multi-container applications. Define network, how containers communicate. The container is called `service` in docker-compose.
* `docker-compose.yaml`:  Configures docker-compose.
  * What image to use for a container.
  * The volumes mapped in a container.
  * Environment or runtime argument when bringing up the container.

[Back To Top](#list-of-contents)

