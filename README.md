# cypress-included-demo
Demo of dockerfile for cypress included, showing issue with arbitrary user ID

Arbitrary UID is required to permit running on eg openshift, where UID is allocated from a pool.

Experiment in the following way:

```
$ docker build . -t cypress-demo

# Run as root
$ docker run -it -u 0:0 cypress-demo cypress run > 0.log

# Run as non-root user
$ docker run -it -u 1000:0 cypress-demo cypress run > 1000.log

# Run as another non-root user
$ docker run -it -u 1001:0 cypress-demo cypress run > 1001.log
```
