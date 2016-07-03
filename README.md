# kingsreach-slackin

Slackin implementation for King's Reach.

## Release

Build this locally and push to quay.io

    docker login quay.io
    docker build -t quay.io/kingsreach/slackin .
    docker push quay.io/kingsreach/slackin

Now `build/jenkins.sh` will use that image.
