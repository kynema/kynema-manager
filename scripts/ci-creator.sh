#!/bin/bash

source ${KYNEMA_MANAGER}/start.sh
spack-start
spack clean -a
nice ./deploy.py --name e4s-build
