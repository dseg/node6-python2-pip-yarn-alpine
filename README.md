# A lightweight (150M) Docker image useful for buliding webpack-based JavaScript/Typescript project.

I'm using [Bitbucket Pipelines](https://confluence.atlassian.com/bitbucket/bitbucket-pipelines-792496469.html) for building and testing SPA applications made with React.js.
There are [official docker images by Atlassian](https://confluence.atlassian.com/bitbucket/use-docker-images-as-build-environments-in-bitbucket-pipelines-792298897.html), but that aren't suitable for my use-case by some reasons.

There is the official 'node' image but which doesn't contains the pip command and the boto3 module. 
(I tried to install that on-the fly, by adding few lines to bitbucket-pipelines.yml,  but it took very long time than I guessed)

+ After successful build, I want to upload it to Amazon S3 ( Python and the boto3 module required.)
+ The zip command required to package.

So I created this custom docker image.
It's lightweight(48MB compressed), and contains following packages.

+ node ~~6.9.1~~ 7.4.0
+ npm ~~3.10.9~~ 4.0.5
+ yarn ~~0.16.1~~ 0.18.1
+ webpack ~~1.13.2~~ 1.14.0
+ typescript 2.0.10
+ git 2.8.3
+ zip 5.3.0
+ python 2.7.12
+ pip 8.1.2
+ boto3 1.3.0 (Required for uploading packages to Amazon S3)
+ bash 4.3.42
+ findutils 4.6.0

I think it's useful as base image of your Bitbucket Pipelines CI.

Example:
bitbucket-pipeline.yml
```yaml
# You can specify a custom docker image from Docker Hub as your build environment.
image: dseg/node6-python2-pip-yarn-alpine

pipelines:
  branches:
    master:
      - step:
          script: # Modify the commands below to build your repository.
            - yarn install # prepare for build
	    - yarn run build
            - cd dist
            - zip -r /tmp/artifact.zip * # Package up the application for deployment
            - python deploy-scripts/codedeploy_deploy.py staging # Upload the package to Amazon S3
```
