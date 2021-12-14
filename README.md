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

Make sure to modify the last line of code below. It should contain the uuid4 that appears when you navigate to the following link: [Huntress Payload Generator](https://log4shell.huntress.com/)
```shell
sudo apt-get update
sudo apt-get install python3 python3-pip
python3 -m venv Log4jShell_Scanner 
cd Log4jShell_Scanner/
python3 -m pip install -r requirements.txt
source bin/activate
python3 scanForLog4jVulnerability.py -f domains.txt -s http:// -p {jndi:ldap://log4shell.huntress.com:1389/obtain-a-uuid4-from-huntress}
```

# Setup

1. Download the Lib4jShell_Scanner at the following link: [Lib4jShell_Scanner](https://github.com/GoVanguard/Log4jShell_Scanner)
1. Install Python.
```shell
sudo apt-get update
sudo apt-get install python3 python3-pip
```
2. Install a virtual environment encapsulating the Log4jShell_Scanner repository.
```shell
python3 -m venv Log4jShell_Scanner 
```
3. Install the dependent libraries.
```shell
cd Log4jShell_Scanner/
python3 -m pip install -r requirements.txt
```
4. Activate the virutal environment.
```shell
source bin/activate
```
5. Create a custom jndi payload or obtain a test payload. Huntress generates test payloads at the following link: [Huntress Payload Generator](https://log4shell.huntress.com/)  

Example from Huntress: {jndi:ldap://log4shell.huntress.com:1389/967d1170-4733-4c07-bbd8-c3bc9233e1ba}  

Shout out to our peers at Huntress: Created by @calebjstewart, Jason Slagle and @_JohnHammond.
This too shall pass.

6. 


# Background

The Log4jShell vulnerability was initially discovered by Minecraft gaming enthusiasts during Thanksgiving Recess, which occurred sometime between 20-23 November 2021. A researcher with AliBaba's Cloud Security Team reported the vulnerability to Apache on 24 November 2021. MITRE assigned this vulnerability CVE-2021-44228 on 26 November 2021, which was still being used in the Minecraft gaming community. Unfortunately, The Apache Software Foundation did not prioritize mitigating the vulnerability during Thanksgiving Recess. It is very likely that their leadership, grantees, and the open source community of contributors at large were on holiday.

On Friday 9 December 2021, the GitHub user TangXiaFeng7 published the source code for the Minimum Viable Product (MVP) for this exploit online at 10:32AM 9 November 2021. Minutes after this publication hit the internet the exploit became weaponized. Since the Log4jShell vulnerability affects many server based software systems within the industry at the Application and Session layers, the impact that this exploit publication has on the industry is significant enough to motivate a rapid crowd-sourced solution. Initial commits that indicate The Apache Software Foundation's open source community was debugging the vulnerability hit the internet at 12:38PM 9 November 2021. Within eight hours of CVE-2021-44228 MVP hitting the internet, The Apache Software Foundation's team of open source developers fixed the vulnerability. The final pull request was accepted at 18:23 9 November 2021.

This shell script scans a vulnerable web application that is using a version of apache-log4j < 2.15.0.
