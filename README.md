# Profesia - Embulk

This repository cointains test of Embulk for Profesia.

### Requirements

* Docker
* Docker-compose

## Installing

### 1. Testing MySQL (optional)

If you do not have your testing version of MySQL you can easily create your own Dockerized version with some example data:
```
docker-compose up -d --force-recreate
```

Check everything is running and there is no error in logs:
```
docker-compose logs
```

### 2. Build Embulk image

Build your own Embulk image. Only MySQL and BigQuery plugins are installed:

```
docker build --no-cache -t profesia-embulk .
```

### 3. Try to export data from MySQL to CSV

This works only if you made step 1. Otherwise you need to change environmental variables:
```
docker run --net=host --rm -v $(pwd):/work -e URI='localhost' -e PORT='3306' -e USER='profesia' -e PASSWORD='profesia123' -e DATABASE='profesia' -e TABLE='jmena' profesia-embulk run mysql2bq.yml.liquid -l info
```

### 3. MySQL to BigQuery

Create your own service account with appropriate rights. Change necessary variables (inside []) and run:
```
docker run --net=host --rm -v $(pwd):/work -e URI='localhost' -e PORT='3306' -e USER='profesia' -e PASSWORD='profesia123' -e DATABASE='profesia' -e TABLE='jmena' -e BQ_PROJECT='[your_bq_project]' -e BQ_DATASET='test' -e BQ_TABLE='jmena' -e GCS_BUCKET='[your_bucket_name]' -e SERVICE_EMAIL='[your_service_email]' -e P12_KEYFILE='[your_p12_file]' profesia-embulk run mysql2csv.yml.liquid -l info
```
Probably for authorization is better to use json.