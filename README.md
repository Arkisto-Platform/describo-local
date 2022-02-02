# describo-local

This repository is for setting up a local instance of Describo on your computer.

Run the following command:

```
curl --silent --output run-describo.sh https://raw.githubusercontent.com/Arkisto-Platform/describo-local/master/run-describo.sh && \
  chmod +x run-describo.sh && \
  ./run-describo.sh start
```

## For the adventurous

**STOP! THIS COMES WITH NO GUARANTEES THAT YOU WON'T LOSE YOUR DATA**

You can mount into the environment some other folder you have access to by editing the file
`describo-local/.env` and putting in the path to the folder you want access to. Be sure to use a
fully qualified path docker is configured to mount as a volume.

Be sure to stop describo before editing this file and then start it up when you're done.
