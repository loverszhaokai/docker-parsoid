# Containerized MediaWiki parsoid service

This repo contains [Docker](https://docs.docker.com/) container to run the [Parsoid](https://www.mediawiki.org/wiki/Parsoid) application.

It is a part of [Containerized Mediawiki install](https://github.com/pastakhov/compose-mediawiki-ubuntu) project.

## Settings

- `PARSOID_DOMAIN_{domain}` defines uri and domain for parsoid service. The '{domain}' word should be the same as `MW_REST_DOMAIN` parameter in MediaWiki web container. You can specify any number of such variables (by the number of domains for the service)
- `PARSOID_NUM_WORKERS` defines the number of worker processes to the parsoid service. Set to `0` to run everything in a single process without clustering. Use `ncpu` to run as many workers as there are CPU units.
- `PARSOID_LOGGING_LEVEL` by default `info`

### Examples ###

The environment variable `PARSOID_DOMAIN_web=http://web/w/api.php` creates config contains:
```
mwApis:
  -
    uri: 'http://web/w/api.php'
    domain: 'web'
```

## how to run

**The domain must be the same as mediawiki**

```
$wgVirtualRestConfig['modules']['parsoid'] = array(
    // URL to the Parsoid instance
    // Use port 8142 if you use the Debian package
    'url' => 'http://10.0.20.29:8081',
    // Parsoid "domain", see below (optional)
    'domain' => '10.0.20.29',
    // Parsoid "prefix", see below (optional)
    'prefix' => '10.0.20.29',
    'forwardCookies' => false,
    'restbaseCompat' => null
);
```

one wiki
```
docker run -it -p 8081:8000 -e PARSOID_API_1=http://xxx:8080/w/api.php -e PARSOID_DOMAIN_1=xxx loverszhaokai/parsoid:0.9.0
```

more wiki
```
docker run -it -p 8081:8000 -e PARSOID_API_1=http://xxx:8080/w/api.php -e PARSOID_DOMAIN_1=xxx -e PARSOID_API_2=http://yyy:8081/w/api.php -e PARSOID_DOMAIN_2=yyy  loverszhaokai/parsoid:0.9.0
```
