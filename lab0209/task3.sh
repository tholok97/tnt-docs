#!/bin/bash

if ls $1 >/dev/null; then 
  echo "Exist"
else
  echo "Does not exist"
fi
