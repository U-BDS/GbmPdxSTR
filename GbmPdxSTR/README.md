# App-specific documentation

## Launching the app from a personal computer
This app can be launched with the Docker image created from the Dockerfile in this repo. Git clone this repo, and perform the following steps:


```bash
cd GbmPdxSTR

docker run -d --rm --user shiny -p 3838:3838 -v `pwd`:/srv/shiny-server/ -v `pwd`/shiny_app_logs:/var/log/shiny-server uabbds/gbmpdxstr:0.1.0
```
Then go to `http://localhost:3838/` from your browser.

The Docker Hub link to the image repository is <https://hub.docker.com/r/uabbds/gbmpdxstr/tags>

## cloud.rc
This app will be hosted in cloud.rc to aid in development and collaboration with the PI and other members involved. Ask Dr. Lara Ianov for the URL of the app in cloud.rc while the project is in the initial development phase.

Some brief instructions:

1. Launch an instance through Terraform - coordinate with Austyn for now and more details to come

2. The following steps will be implemented with Ansible in the near future but for now they are:

    * ssh into instance
    * install docker
    * git clone this repository
    * `cd GbmPdxSTR`
    * `chmod 777 shiny_app_logs`
    * Start the container. Note the following use `--restart always` instead of `--rm`:

```bash
sudo docker run -d --restart always --user shiny -p 3838:3838 -v `pwd`:/srv/shiny-server/ -v `pwd`/shiny_app_logs:/var/log/shiny-server uabbds/gbmpdxstr:0.1.0
```
