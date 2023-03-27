# GBM PDX STR Similarity Search Tool

This web tool provides users with the ability to search for Short Tandem Repeat (STR) similarity between your sample (query) to the glioblastoma (GBM) patient-derived xenograft (PDX) tumors present at UAB. This tool is inspired by the [Cellosaurus CLASTR search tool](https://web.expasy.org/cellosaurus-str-search/).

# App website

__You may use the app by visiting the following URL: <https://gliomamodels.com/>__

If you encounter any issues, please open an issue in this git repository describing the issue you encountered.

____
## Launching the app from a personal computer

__While we encourage most users to visit the URL above to use the app__, the app may also be launched from a personal computer with the following two steps:

1. Git clone this repository (latest commit in the main branch) and navigate to the repository directory
2. Launch the app's Docker container:

```bash
# ensure you are in the app's git repository
docker run -d --rm --user shiny -p 3838:3838 -v `pwd`:/srv/shiny-server/ -v `pwd`/shiny_app_logs:/var/log/shiny-server uabbds/gbmpdxstr:latest
```

Then go to `http://localhost:3838/` from your browser.

The Docker Hub link to the image repository is <https://hub.docker.com/r/uabbds/gbmpdxstr>. If you encounter a persmission issue with the `shiny_app_logs` directory, simply run `chmod 777 shiny_app_logs` prior to starting the Docker container

# Credits

The GBM PDX STR Similarity Search Tool was written by [Dr. Lara Ianov](https://github.com/lianov).

The app was written with support of [Dr. Chris Willey](https://scholars.uab.edu/display/cwilley), UAB and funding from the NIH U01 CA223976 grant.

Aid with web-hosting was provided by [Austyn Trull](https://github.com/atrull314). We would like to thank the UAB Research Computing group for the UAB cloud resources being used to host this application.

Lastly, Dr. Lara Ianov and Austyn Trull are members of the [UAB Biological Data Science core](https://www.uab.edu/cores/ircp/bds). The core facility RRID is `RRID:SCR_021766`.

# Citation

If this application benefits your work, we kindly ask to acknowledge the app by including the following DOI: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7776216.svg)](https://doi.org/10.5281/zenodo.7776216)
