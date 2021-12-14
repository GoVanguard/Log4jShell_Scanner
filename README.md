# log4jShell Scanner

This shell script scans a vulnerable web application that is using a version of apache-log4j < 2.15.0. GoVanguard clients may use this scanner to test a list of domains for the Log4jShell Common Vulnerability and Exposures (CVE)-2021-44228. It accepts a text file one domain, sub-domain, or domain branch per line no delimitation (commas, semicolons, etc.).

e.g.

example.com  
ads.example.com  
ads.example.com/please-no-more-ads.html  
ads.example.com/method  
ads.example.com/method?myQarg=userResponse  
ads.example.com/method?myQarg=userResponse&&myOtherArg=anotherResponse  

# TLDR
Note: If you obtain a payload from Huntress, then remove the $ from your payload. Your payload must point to a unique webpage from Huntress or you must generate your own custom payload. Logs are your vulnerable systems are kept for 30 minutes.
Aditionally, please ensure that you modify the domains.txt file in this repository and obtain a payload from the following link: [Huntress Payload Generator](https://log4shell.huntress.com/) before using this script.

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

Shout out to our peers at Huntress: Caleb Stewart, Jason Slagle, and John Hammond, who created this payload generator over the weekend. This too shall pass.

6. Update the domains.txt file with your end points. Examples are above and in the text file.
7. Run the script. Add additional flags as necessary.
```shell
python3 scanForLog4jVulnerability.py -f domains.txt -s http:// -p {jndi:ldap://log4shell.huntress.com:1389/967d1170-4733-4c07-bbd8-c3bc9233e1ba} -q -i -z -b
```
python3 scan


# Background

The Log4jShell vulnerability was initially discovered by Minecraft gaming enthusiasts during Thanksgiving Recess, which occurred sometime between 20-23 November 2021. A researcher with AliBaba's Cloud Security Team reported the vulnerability to Apache on 24 November 2021. MITRE assigned this vulnerability CVE-2021-44228 on 26 November 2021, which was still being used in the Minecraft gaming community. Unfortunately, The Apache Software Foundation did not prioritize mitigating the vulnerability during Thanksgiving Recess. It is very likely that their leadership, grantees, and the open source community of contributors at large were on holiday.

On Friday 9 December 2021, the GitHub user TangXiaFeng7 published the source code for the Minimum Viable Product (MVP) for this exploit online at 10:32AM 9 November 2021. Minutes after this publication hit the internet the exploit became weaponized. Since the Log4jShell vulnerability affects many server based software systems within the industry at the Application and Session layers, the impact that this exploit publication has on the industry is significant enough to motivate a rapid crowd-sourced solution. Initial commits that indicate The Apache Software Foundation's open source community was debugging the vulnerability hit the internet at 12:38PM 9 November 2021. Within eight hours of CVE-2021-44228 MVP hitting the internet, The Apache Software Foundation's team of open source developers fixed the vulnerability. The final pull request was accepted at 18:23 9 November 2021.

