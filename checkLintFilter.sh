#!/bin/bash

## C0103, C0209 and C0301 are bullshit. Deal with it.
python3 -m pylint -d C0103 -d C0209 -d C0301 scanForLog4jVulnerability.py
