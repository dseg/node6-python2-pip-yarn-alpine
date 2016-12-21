FROM mhart/alpine-node:7
# Bash is required for use with BitBucket Pipelines.
RUN\
 apk add --no-cache git python py-pip bash zip findutils &&\
 pip install boto3==1.3.0 &&\
 npm i -g yarn webpack@1.14.0 typescript &&\
 rm -rf /tmp/npm*
ENTRYPOINT ["/bin/bash"]
