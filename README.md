CMPE297_ASSIGNMENT2
===================

CMPE297 ASSIGNMENT2

[cxia@oc6831665801 sample-app]$ vmc info
VMware's Cloud Application Platform

target: https://api.cloudfoundry.com
  version: 0.999
  support: http://support.cloudfoundry.com

user: xia3883@gmail.com
[cxia@oc6831665801 sample-app]$ vmc push --runtime ruby19
Name> Hello

Instances> [cxia@oc6831665801 sample-app]$ 
[cxia@oc6831665801 sample-app]$ ls
config.ru  Gemfile  Gemfile.lock  Hello.rb  vendor
[cxia@oc6831665801 sample-app]$ vmc -v
vmc 0.4.2
[cxia@oc6831665801 sample-app]$ vmc push --runtime ruby19
Name> Hello

Instances> 2

1: sinatra
2: other
Framework> sinatra

1: 64M
2: 128M
3: 256M
4: 512M
5: 1G
6: 2G
Memory Limit> 128M

Creating Hello... OK

1: Hello.cloudfoundry.com
2: none
URL> cmpe297-chun-hello.cloudfoundry.com

Updating Hello... OK

Create services for application?> n

Bind other services to application?> n

Save configuration?> y

Saving to manifest.yml... OK
Uploading Hello... OK
Using manifest file manifest.yml

Starting Hello... OK
Checking Hello... OK
[cxia@oc6831665801 sample-app]$ 
[cxia@oc6831665801 sample-app]$ vmc stats Hello
Using manifest file manifest.yml

Getting stats for Hello... OK

instance   cpu               memory          disk      
#0         0.2% of 4 cores   27.5M of 128M   6.0M of 2G
#1         0.2% of 4 cores   27.3M of 128M   6.0M of 2G
[cxia@oc6831665801 sample-app]$ vmc push Hello --instances 4 --memory 64
Using manifest file manifest.yml

Uploading Hello... OK
Changes:
  memory: 128 -> 64
  instances: 2 -> 4
Updating Hello... OK
Stopping Hello... OK

Starting Hello... OK
Checking Hello... OK