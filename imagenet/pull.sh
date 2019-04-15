#!/bin/bash

git pull origin master

sbatch densenet_experiment.sh
sbatch inception_experiment.sh
