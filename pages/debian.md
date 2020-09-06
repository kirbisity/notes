# Debian

[Back](../README.md)

[https://www.debian.org/doc/debian-policy/index.html](https://www.debian.org/doc/debian-policy/index.html)

[https://wiki.debian.org/DependencyHell](https://wiki.debian.org/DependencyHell)


### List of Contents

* [Concepts](#concepts)
* [Commands](#commands)
* [Debian Package](#debian-package)
* [Dpkg Steps of Deployment](#dpkg-steps-of-deployment)
* [Dpkg Change Requests](#dpkg-change-requests)

## Concepts

* An application is Self-contained if:

  * Static linked executable
  * Dynamically linked shared objects are deployeed alongside executable

* An application is Relocatable if:

  * Application can be moved to a different install location.

* Distribution series

  ```
  [my-unstable-custom] -> [my-unstable] -> [unstable]
   predecessor             successor
                           predecessor      successor
  ```

  * Branching of another distribution
  * Branching controls which distribution is successor
  * Successor has package versions greater equal to predecessor
  * Changes made in the predecessors will automatically follow into the successors.

* Snapshot

  * A successful build

[Back To Top](#list-of-contents)

## Commands

- `dpkg -I <package.deb>`  or `dpkg-deb -I <package.deb>. `  View all information and dependency of a package.

[Back To Top](#list-of-contents)

## Debian Package

* Binary package vs Source package
  * Binary package is an all-in-one compiled binary. Execuatables are binary package.
  * Source package contain source code for a library and need to be built.
* Package name
  * Each package must have a unique name within the Debian archive.
  * Defined in `control` file, appear in `.deb` file
* Maintainer
  * One email representing one person or a mailing list

* `Build-Depends`

  * List packages required for building the source package.
  * Declares relationships between source and binary packages.
  * If building needs a compiler, the compiler need to be specified as a build-time dependency
  * Only list direct dependencies. No need to list dependencies of a build-time dependency.

* `Depends`

  * List packages required for the package to function.
  * Takes effect only when a package is to be configured.
  * A package will not be configured unless all of the packages listed in its `Depends` field have been correctly configured. i.e. The packages under `Depends` would be installed first then the target package. 

* Dependencies

  * Should not have dependency for `Essential` packages.

* Direct, indirect and transitive dependencies.

  * Example Used

  * ```
    Package: foo
    Depends: flubber
    
    Package: flubber
    Depends: blub | plim
    
    Package: blub
    Conflicts: plim
    
    Package: plim
    ```

    A direct dependency of the binary package `foo` is the binary package `flubber`. 
    An indirect dependency of the binary package `foo` is the binary package `blub`.

  * Installation Set

    * An installation set of packages that satisfies all dependency requirements.
    * There are two for the sample. {`foo`, `flubber`, `blub`} and  {`foo`, `flubber` ,`plim`}.

  * Dependency Closure

    * A set of packages created by recursively following all dependencies.
    * A superset of all installation sets.
    * For the example: `foo`, `flubber`, `blub `, `plim`.

  * Strong Dependencies

    * Packages that are part of every installation set.
    * For the example: `foo` and `flubber`

* Dependencies on shared libraries

  * Must have dependency for shared libraries required by a dynamically-linked executable.
  * Dependency on shared libraries should have an exact version.
  * Shared library need to have a symbols file. (e.g. need to have `.h` at build time even if there is `.so`)

  [Back To Top](#list-of-contents)

  ## Steps of Deployment

  1. Development change pushed to dev repo.
  2. Source package published to prod repo. 
     - Cannot change existing version once in prod repo.
  3. Source package promoted to distribution. 
     - New changes cannot break other dpkgs, unless force merge and do bulk promotion.
  4. Binary package built in distribution.
  5. Binary package deployed.

  [Back To Top](#list-of-contents)

  ## Change Requests

  - Promotion
    - Causes of promotion failures, the distribution will not change if failed.
      - Package validation (not a dpkg)
      - Compiler/Linker errors
      - Failes extrernal validation (extvalling) (robo trunk failure)
      - Dependent package is broken by the change.
    - Policies
      - Open, package owner may promote (unstable)
      - Closed, distribution owner may promote (stable)
      - Sweep (e.g robo trunk)
      - Delayed Promotion
  - Removal
  - Rebuild, rarely used
  - Downgrade, better promote a new version reverting the change
  - Cancel running change request

  ```
  dpkg-change-request --distribution=unstable --promotr packageA=0.0.1 packageB=0.0.6
  dpkg-distroyer
  ```

  [Back To Top](#list-of-contents)

  ## Steps of Deployment

  1. Development change pushed to dev repo.
  2. Source package published to prod repo. 
     - Cannot change existing version once in prod repo.
  3. Source package promoted to distribution. 
     - New changes cannot break other dpkgs, unless force merge and do bulk promotion.
  4. Binary package built in distribution.
  5. Binary package deployed.

  [Back To Top](#list-of-contents)

  ## Change Requests

  - Promotion
    - Causes of promotion failures, the distribution will not change if failed.
      - Package validation (not a dpkg)
      - Compiler/Linker errors
      - Failes extrernal validation (extvalling) (robo trunk failure)
      - Dependent package is broken by the change.
    - Policies
      - Open, package owner may promote (unstable)
      - Closed, distribution owner may promote (stable)
      - Sweep (e.g robo trunk)
      - Delayed Promotion
  - Removal
  - Rebuild, rarely used
  - Downgrade, better promote a new version reverting the change
  - Cancel running change request

  ```
  dpkg-change-request --distribution=unstable --promotr packageA=0.0.1 packageB=0.0.6
  dpkg-distroyer
  ```

  [Back To Top](#list-of-contents)

[Back To Top](#list-of-contents)

## Dpkg Steps of Deployment

1. Development change pushed to dev repo.
2. Source package published to prod repo. 
   * Cannot change existing version once in prod repo.
3. Source package promoted to distribution. 
   * New changes cannot break other dpkgs, unless force merge and do bulk promotion.
4. Binary package built in distribution.
5. Binary package deployed.

[Back To Top](#list-of-contents)

## Dpkg Change Requests

- Promotion
  - Causes of promotion failures, the distribution will not change if failed.
    - Package validation (not a dpkg)
    - Compiler/Linker errors
    - Failes extrernal validation (extvalling) (robo trunk failure)
    - Dependent package is broken by the change.
  - Policies
    - Open, package owner may promote (unstable)
    - Closed, distribution owner may promote (stable)
    - Sweep (e.g robo trunk)
    - Delayed Promotion
- Removal
- Rebuild, rarely used
- Downgrade, better promote a new version reverting the change
- Cancel running change request

```shell
dpkg-change-request --distribution=unstable --promotr packageA=0.0.1 packageB=0.0.6
dpkg-distroyer
```

[Back To Top](#list-of-contents)