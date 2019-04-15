#!/bin/bash

sbatch alexnet_experiment.sh
sbatch vgg16_experiment.sh
sbatch resnet18_experiment.sh
sbatch densenet_experiment.sh
sbatch inception_experiment.sh