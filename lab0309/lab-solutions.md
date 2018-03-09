# Lab solutions for 09-02

NB! Needs beautyfixes.

## 1
Made new Harbor account on 10.212.136.160:

  Username: TnT
  Email: trondhth@stud.ntnu.no
  First and last name: Tango November Tango
  Password: dynamittH4rry

Made a new private project called "docker"

## 2
On both docker VM and manager VM:

  curl http://10.212.136.140/harbor.crt > /usr/local/share/ca-certificates/harbor.crt
  update-ca-certificates
  service docker restart

Logged in to Harbor via shell with 'docker login 10.212.136.160'

bookfaceimage can now be pulled down to manager VM.

Uploaded bookfaceimage to harbor with 'docker tag bookfaceimage 10.212.136.160/docker/bookfaceimage:latest \
docker push 10.212.136.160/docker/bookfaceimage:latest'
It works!

## 3
*TBA*

## 4
*TBA*

## 5
*TBA*
