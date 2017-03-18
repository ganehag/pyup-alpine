# PyUp on Alpine Linux

## What is PyUp
A tool to update all your project's requirement files with on GitHub.

## What is this?
A Docker image to run PyUp using CRONd

## How to use it
This version of PyUp supports GitLab using the fork from `LearntEmail/pyup`.
At the time of writing this support has not yet been merged into mainline.

## Example config
The only thing required is a crontab file for `root`. This file then needs to
be mounted under `/var/spool/cron/crontabs`. So that the file 
`/var/spool/cron/crontabs/root` exists. In this file you specify each command
and when to run it.

```bash
# m h dom mon dow  command
  0 0 *   *   *    pyup --provider gitlab --repo USER/REPO --user-token XXXXXXXXXXXXX@https://gitlab.com
```

With one new line for each repo. Information about how and where to get the
user token for GitLab can be found if you search online for `gitlab private token`. The
procedure of how to get the GitHub token can be found in the PyUp repo 
[here](https://github.com/pyupio/pyup).

## Example

> $ docker run -d --name pyup-checker ganehag/pyup-alpine:latest

Once the container is running you start with performing an initial request. This will pack
all of the changes into a single merge request. It is *highly* recommended that you ensure
these updates to `requirements.txt` still produces a working software, then accepts the
merge request before letting the container run on its own. Otherwise you will get multiple
merge request for each change once the software runs.

To run this **initial** step you simple append `--initial` to each of the commands from
the cron file. You can either do this by entering the container:

> $ docker exec -it pyup-checker ash

Or calling from outside docker.

> $ docker exec -it pyup-checker pyup --provider gitlab --repo USER/REPO \
>   --user-token XXXXX@https://git.noda.se --initial
