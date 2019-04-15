#!/bin/bash

sbatch alexnet_experiment.sh p40
sbatch vgg16_experiment.sh p40
sbatch resnet18_experiment.sh p40 
sbatch densenet_experiment.sh p40
#sbatch inception_experiment.sh p40
