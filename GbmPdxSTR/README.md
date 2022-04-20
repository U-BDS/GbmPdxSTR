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
