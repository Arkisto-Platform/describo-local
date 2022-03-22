# describo-local

This repository is for setting up a local instance of Describo on your computer.

## Prerequsites

You must have Docker installed.

## Installation

It is not necessary to clone this repository.

To install describo-local run the following command in an empty directory:

```
curl --silent --output run-describo.sh https://raw.githubusercontent.com/Arkisto-Platform/describo-local/master/run-describo.sh && \
  chmod +x run-describo.sh && \
  ./run-describo.sh start
```

This will:

-   create a new sub directory `./describo-local`
-   create a script to start and stop Describo `./run-describo.sh`
-   Start Describo at <http://localhost>

```
Describo is now running at http://localhost (open up a browser and type that in).

Log in to the admin section with the password:
 - adminpass

When you're done, stop describo with:
 - $0 stop

Next time - start it up with:
- $0 start

To update describo do (whilst not running):
 - $0 update

This script will make your home directory accessible inside describo.

**STOP! THIS COMES WITH NO GUARANTEES THAT YOU WON'T LOSE YOUR DATA**
```

## Data

This script will make your home directory accessible inside describo.

**STOP! THIS COMES WITH NO GUARANTEES THAT YOU WON'T LOSE YOUR DATA**
