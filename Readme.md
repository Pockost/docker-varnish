#Docker varnish container

Based on Debian Jessie

##Usage

* Simple
```
docker run pockost/varnish
```

* Add parameters
```
docker run pockost/varnish --P /var/run/varnish.pid
```

##Ports

Port 6081 and 6082 are exposed.
