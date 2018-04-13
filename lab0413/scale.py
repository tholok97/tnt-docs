#!/usr/bin/python3.5

# while true; do uptime; sleep 10; clear; done
# watch -n 10 uptime
# 

import subprocess
import argparse
import math

VERBOSE = 0
DEBUG = 0

IP = "10.212.136.82"
USER = "someuser"
PASSWORD = "password"

RATE_PER_SERVER = 3 #hvor mange koblinger pr sec tåler webservern? (3 er veldig lavt).

MAX_SERVERS = 4 #antall servere (tak (cap)).
MIN_SERVERS = 1 #unngå at antall servere skaleres ned til 0.

#ARGUMENTS
#----------------
parser = argparse.ArgumentParser(prog="script2.py") #prog er det som står i "USAGE"-meldingen.
parser.add_argument('-v', '--verbose', dest="verbose", help='Turn verbosity on', default=False, action="store_true")
parser.add_argument('-d', '--debug', dest="debug", help='Turn debug_messages on', default=False, action="store_true")
#HAPROXY autentisering:
parser.add_argument('-i', '--ip', dest="ip", help='IP address of haproxy server', default=IP)
parser.add_argument('-u', '--user', dest="user", help='Username for HAproxy authentication',default=USER)
parser.add_argument('-p', '--password', dest="password", help='Password for HAproxy authentication', default=PASSWORD)

arguments = parser.parse_args()

VERBOSE = arguments.verbose
DEBUG = arguments.debug
IP = arguments.ip
USER = arguments.user
PASSWORD = arguments.password

#METHODS
#-------------
def verbose(text):
  if VERBOSE:
    print (text)

def debug(text):
  if DEBUG:
    print (text)

def get_rate(user, password, ip):
  # Kjører kommando curl -s http://username:password@ip:1936/;csv og lagrer i output.
  output = subprocess.check_output(["curl", "-s", "http://" + USER + ":" + PASSWORD + "@" + IP + ":" + "1936/\\;csv"]) #Inneholder all utskrift fra kommando (curl i dette tilfellet).'
  output = str(output)
  #Må gå gjennom output linje for linje.
  for line in output.split('\\n'):
    if "bookface" in line:
      stats_array = line.split(',')
      total_sessions = stats_array[4]
      return float(total_sessions)

#Alternativ get_rate:
#  def get_rate_alt(user, password, ip):
#    return 3.0

def get_workers():
  # docker service ls | grep bookface_web | awk '{print $4}' | sed -e 's/.*\///g'
  output = subprocess.check_output(['sudo docker service ls | grep bookface | awk \'{print $4}\' | sed -e \'s/.*\///g\''], shell=True, executable='/bin/bash')
  output.rstrip()      #Fjerner newline.
  return float(output)  

#def get_workers_alt():
#  return float(2)
  
def scale(current, goal):
  verbose("Scaling from " + str(current) + " servers to " + str(goal) + " servers")
  output = subprocess.check_output(['sudo docker service scale bookface=' + str(goal)], shell=True, executable='/bin/bash')
  

# Hva skal skje i scriptet?

# 1) Get current rate.
current_rate = get_rate(USER, PASSWORD, IP)
verbose("Current rate " + str(current_rate))

# 2) Get number of workers.
current_workers = get_workers()
verbose("Current workers " + str(current_workers))

# 3) Calculate the current needed capacity.
needed_capacity = math.ceil(current_rate / RATE_PER_SERVER)
verbose("We need " + str(needed_capacity) + " to handle this rate")

if needed_capacity < MIN_SERVERS:
  verbose("Adjusting needed capacity to minimum: " + str(MIN_SERVERS))
  needed_capacity = MIN_SERVERS
elif needed_capacity  > MIN_SERVERS:
  verbose("Adjusting needed capacity to maximum" + str(MAX_SERVERS))
  needed_capacity = MAX_SERVERS

# 4) Compare current needed with actual capacity and take action: reduce or increase or do nothing.
if needed_capacity > current_workers:
  verbose("We need to increase the number of servers from " + str(current_workers) + " to " + str(needed_capacity))
  scale(int(current_workers), int(needed_capacity))
elif needed_capacity < current_workers:
  verbose("We need to decrease the number of server from " + str(current_workers) + " to " + str(needed_capacity))
  scale(int(current_workers), int(needed_capacity))
else:
  verbose("Current worker is adequate. No action needed")
















