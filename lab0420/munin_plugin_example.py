# Plugins lie in all munin-nodes at /etc/munin/plugins

import subprocess
import math

VERBOSE = 0
DEBUG = 0

IP = "10.212.136.82"
USER = "someuser"
PASSWORD = "password"

RATE_PER_SERVER = 3 #hvor mange koblinger pr sec tåler webservern? (3 er veldig lavt).

MAX_SERVERS = 4 #antall servere (tak (cap)).
MIN_SERVERS = 1 #unngå at antall servere skaleres ned til 0.


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


# 1) Get current rate.
current_rate = get_rate(USER, PASSWORD, IP)
verbose("Current rate " + str(current_rate))

# 2) Get number of workers.
current_workers = get_workers()
verbose("Current workers " + str(current_workers))


