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

  - create a new sub directory `./describo-local` 
  - create a script to start and stop Describo `run-describo.sh`
  - Start Describo at <http://localhost> 
    Log in with:
     - username: admin
     - password: admin

    The folder available inside describo is in the describo-local directory:
     -  ./describo-local/data/admin

    You can copy files and folders into there and then annotate them inside describo.

    When you're done, stop describo with:
     - `./run-describo.sh stop`

    Next time - start it up with:
    - `./run-describo.sh start`

    To update describo do (whilst not running):
     - `./run-describo.sh` update







## For the adventurous

**STOP! THIS COMES WITH NO GUARANTEES THAT YOU WON'T LOSE YOUR DATA**

You can mount into the environment some other folder you have access to by editing the file
`describo-local/.env` and putting in the path to the folder you want access to. Be sure to use a
fully qualified path docker is configured to mount as a volume.

Be sure to stop describo before editing this file and then start it up when you're done.
