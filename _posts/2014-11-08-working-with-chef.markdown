---
layout: post
title:  "Working with Chef"
date:   2014-11-08 10:44:00
category: devops
tags: [chef]
---
I am learning chef, so I do not have to know by heart all the steps I have to follow in order to get my applications up and running.

##Install chef in the target system
1. sudo su
2. apt-get install curl
3. Follow the steps described in http://gettingstartedwithchef.com/first-steps-with-chef.html

##Create a Chef cookbook
1. Create a Chef repository: it can contains multiple cookbooks
2. Install the cookbooks you need located in the community repos: `knife cookbook site download my-cookbook`

##Resources
Resources are actions that are provided by recipes.  You have to use resources when configuring a new
database, new user database, getting files from the web, or any other action that needs to be performed
when executing your default recipe.

##Attributes
You can define default attributes in two localtions: `my-attrs.json` and `your-cookbook/attributes/default.rb`.
The first file has to be passed when you execute chef-solo: `chef-solo -c solo.rb -j my-attrs.json`.  It seems
that is recommendable to store in this file only `passwords`.  The second location is much more for providing
default values which can be overriden in the `my-attrs.json` file.

##Templates
Nothing different here, templates are `erb` files which are going to be populated with speficic config data at
the moment the packages/dependencies are being installed.  They are usefull when configuring services that
required a config file.


I followed the first step with chef to learn about all these concepts.  The documentation is very good!  The chef
cookbook I created by following that guide is here [1](https://github.com/minostro/chef/tree/master/first-step-chef-cookbook).
