#!/bin/bash

LAST_BUILD=$(curl -s http://drone.ndc2018.niklasmh.no/api/repos/niklasmh/drone-vs-jenkins-demo/builds/latest -H "Authorization: Bearer $DRONE_TOKEN" | awk '{split($0,a,":"); split(a[3],b,","); print b[1]}')

curl -X POST http://drone.ndc2018.niklasmh.no/api/repos/niklasmh/drone-vs-jenkins-demo/builds/$LAST_BUILD \
  -H "Authorization: Bearer $DRONE_TOKEN"

echo Restarted build $LAST_BUILD!
