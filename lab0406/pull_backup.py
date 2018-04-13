#!/usr/bin/python

import os
import shutil
import argparse

VERBOSE = 0
DEBUG = 0

ITERATIONS = 7
BACKUP_FOLDER = "/backups/"
CONFIG = "/etc/backup.conf"

SCP_USER = "ubuntu@"

###########################################
# Extra stuff
parser = argparse.ArgumentParser(prog='pull_backup.py')
parser.add_argument('-v','--verbose',dest="verbose",help='Turn verbosity on',default=False,action="store_true")
parser.add_argument('-d','--debug',dest="debug",help='Turn debug_messages on',default=False,action="store_true")
parser.add_argument('-c','--config',dest="config", help='What config file to use', metavar="FILE",default=CONFIG)
parser.add_argument('-i','--iterations',dest="iterations",type=int, help='How many backup iterations to do', metavar="N",default=7)
parser.add_argument('-b','--backup-directory',dest="backup_folder", help="Where to keep the backup files", metavar="FOLDER",default=BACKUP_FOLDER)
arguments = parser.parse_args()

VERBOSE = arguments.verbose
DEBUG = arguments.debug
ITERATIONS = arguments.iterations
BACKUP_FOLDER = arguments.backup_folder
CONFIG = str(arguments.config)
##########################################

def verbose(text):
    if VERBOSE :
        print text 
    
def debug(text):
    if DEBUG :
        print text
    
verbose("Opening config file: " + CONFIG);
with open(CONFIG) as config:
    for line in config:
        verbose("Read line: " + line)
        configlist = line.split(":")
        pathlist = configlist[1].split(",")
        verbose("host: " + configlist[0] )
        host = configlist[0]
        
        # step 0: Check there is a backup folder
        host_backup_path = BACKUP_FOLDER + host
        if not os.path.isdir(host_backup_path):
            verbose("Creating backup folder " + host_backup_path)
            os.makedirs(host_backup_path)
        
        # Step 1: remove the oldest folder
        if os.path.isdir(host_backup_path + "." + str(ITERATIONS)):
            verbose("Deleting oldest version of backup directories")
            shutil.rmtree(host_backup_path + "." + str(ITERATIONS))
            
        # step 2: move the other folders up
        for i in range((ITERATIONS - 1),0,-1):
            debug("Checking if " + str(i) + "th folder exists")
            if os.path.isdir(host_backup_path + "." + str(i)):
                verbose("Moving " + host_backup_path + " from " + str(i) + " to " + str(i + 1))
                shutil.move(host_backup_path + "." + str(i),host_backup_path + "." + str(i + 1))
                
            
        # step 3: cp -al the current folder

        # shutil.copytree(host_backup_path, host_backup_path + ".1", copy_function=os.link)
        verbose("Copying main folder with hard links")
        os.system("cp -al " +  host_backup_path + " " + host_backup_path + ".1")

        # step 4: sync the current folder
        verbose("Synchronizing folders")
        for folder in pathlist:
            folder = folder.rstrip()
            verbose("-> " + folder)
            if not os.path.isdir(host_backup_path + folder):
                os.makedirs(host_backup_path + folder)
            
            verbose_rsync = "v" if VERBOSE else ""    
            os.system("rsync -a" + verbose_rsync + " --delete " + SCP_USER + host + ":" + folder + " " + host_backup_path + folder)
        

        
        
    
