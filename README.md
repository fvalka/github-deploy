# github-deploy
Docker image for deploying a directory to a GitHub branch.

This Dockerimage can be used for deploying local files, which haven't been git versioned yet, into an existing git branch. 
While merging with the existing git branch the local changes will be given precedence. 

## Usage

To run a simple deploy into the master branch the following command can be used. 
```
docker run --rm -e ACCESS_TOKEN=<GITHUB TOKEN> -e REPO=<username>/<reponame> -v $(pwd):/var/data fvalka/github-deploy:latest
```

The folder which should be deployed has to be mounted into /var/data or into the current WORKDIR if the WORKDIR is overwritten. 

During the deployment the local folder will not be changed. The files will be copied into the Docker container. Therefore depending on your deployment into memory
which might be a limitation with very large files. 

### Settings

Those are the settings supported by the Docker image:
* mandatory: `ACCESS_TOKEN` for setting the GitHub access token, can be any type of token with the right permissions 
* mandatory: `REPO` the repository which the deployment should push to. In the format: `githubUser/repo`
* optional: `BRANCH` the branch to be deployed into. Defaults to `master`
* optional: `GIT_USER` the git username to use for the commit
* optional: `GIT_EMAIL` the git email address to use for the commit
