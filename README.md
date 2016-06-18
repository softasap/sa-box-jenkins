Jenkins role
============

[![Build Status](https://travis-ci.org/softasap/sa-box-jankins.svg?branch=master)](https://travis-ci.org/softasap/sa-box-jenkins)

This is an Ansible role which provisions Jenkins.

The role has few options which can be used to modify the behaviour:

 - which version of java (Oracle JDK) should be available (if java is not already present)
   - default: version 8
 - which plugins should be installed
   - default: listed in `defaults/main.yml`
 - which users should be created
   - default: kept completely open to anonymous users
 - if a secure nginx site should be created (using self signed certs)
   - default: no nginx setup


Example of usage:

if defaults are good for you:

```
  roles:
    - role: jenkins
```

or overrides them:

```
  roles:
    - role: jenkins
      java_version: 8
      jenkins_plugins:
        - ghprb
        - slack
        - hipchat
        - workflow-aggregator
        - pipeline-stage-view
        - github-organization-folder
        - modernstatus
        - environment-script
        - rebuild
        - throttle-concurrents
        - s3
      jenkins_users:
        - name: "Admin"
          password: "321"
          email: "no-reply@localhost"
      setup_nginx_secure_site: true
```


## Why Jenkins
Nowadays continuous integration is an important part of the agile software development life cycle.
There are a number of tools on the market: Atlassian Bamboo, Jenkins, Jetbrains TeamCity.
In my opinion Jenkins has the most optimal product community and set of really useful plugins
that suits most of your software projects:  you can  build software, deploy software,  
websites, portals to various places, including AWS, DigitalOcean, bare metal servers
or to run unit tests. It can be integrated with communication tools of your choice, like Slack, HipChat or
email.

If you haven't had a chance to try Jenkins earlier, feel free to use this role to start with.
