#!/bin/bash
service ssh start
service proftpd start

apachectl -D FOREGROUND