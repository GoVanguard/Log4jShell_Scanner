# log4jShell Scanner

The source code in this repository provides GoVanguard clients with a shell application that scans a list of domains for the Log4jShell Common Vulnerability and Exposures (CVE)-2021-44228. It accepts a text file one domain, sub-domain, or domain branch per line no delimitation (commas, semicolons, etc.).

e.g.

example.com
ads.example.com
ads.example.com/please-no-more-ads.html
ads.example.com/method
ads.example.com/method?myQarg=userResponse
ads.example.com/method?myQarg=userResponse&&myOtherArg=anotherResponse

# TLDR

Setup

1. Download the Lib4jShell_Scanner at the following link: [Lib4jShell_Scanner](https://github.com/GoVanguard/Log4jShell_Scanner)
1. Install Python.
```shell
sudo apt-get update
sudo apt-get install python3.10 python3-pip
```
2. Install a virtual environment.
```shell
python3 -m venv 
```

# Introduction and Background

The Log4jShell vulnerability was initially discovered by Minecraft gaming enthusiasts during Thanksgiving Recess, which occurred sometime between 20-23 November 2021. A researcher with AliBaba's Cloud Security Team reported the vulnerability to Apache on 24 November 2021. MITRE assigned this vulnerability CVE-2021-44228 on 26 November 2021, which was still being used in the Minecraft gaming community. Unfortunately, The Apache Software Foundation did not prioritize mitigating the vulnerability during Thanksgiving Recess. It is very likely that their leadership, grantees, and the open source community of contributors at large were on holiday.

On Friday 9 December 2021, the GitHub user TangXiaFeng7 published the source code for the Minimum Viable Product (MVP) for this exploit online at 10:32AM 9 November 2021. Minutes after this publication hit the internet the exploit became weaponized. Since the Log4jShell vulnerability affects many server based software systems within the industry at the Application and Session layers, the impact that this exploit publication has on the industry is significant enough to motivate a rapid crowd-sourced solution. Initial commits that indicate The Apache Software Foundation's open source community was debugging the vulnerability hit the internet at 12:38PM 9 November 2021. Within eight hours of CVE-2021-44228 MVP hitting the internet, The Apache Software Foundation's team of open source developers fixed the vulnerability. The final pull request was accepted at 18:23 9 November 2021.

This shell script creates a vulnerable web application that uses apache-log4j-2.12.1 from the pull request published on 2020-07-03.

# Setup

Setup requires a bash shell. On Windows this can be accomplished with the Windows Subsystem for Linux, GitBash, Anaconda, miniconda, or any other virtual bash environment that you feel comfortable using and is not connected to other resources within your corporate network. This bash script should run on Mac and Linux requiring only super user permission.

```shell
sudo bash runIt.sh
```

# Teardown
Teardown has the same requirements as setup and you must remember to stop this service. If you do not stop this service, then your compartmentalized system is sill vulnerable to CVE-2021-44228.

```shell
sudo bash stopIt.sh
```


