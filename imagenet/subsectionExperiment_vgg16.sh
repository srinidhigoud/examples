#!/bin/bash

#SBATCH --verbose
#SBATCH --job-name=subExpCloudML
#SBATCH --mem=100GB
#SBATCH --output=out.vgg16_32_0.01_p40_loss_only.%j

##SBATCH --time=100:00:00
#SBATCH--gres=gpu:1

#SBATCH --mem=250GB
#SBATCH --nodes=1
#SBATCH --cpus-per-task=28
#SBATCH --exclusive
#SBATCH --time=00:60:00
##SBATCH --gres=gpu:p40:4
#SBATCH --gres=gpu:p40:4
#SBATCH --reservation=chung

# module load pytorch/python2.7/0.3.0_4
# module load pytorch/python3.6/0.3.0_4

# conda activate base
module load python3/intel/3.6.3 cuda/9.0.176 nccl/cuda9.0/2.4.2

source ~/pytorch_env/py3.6.3/bin/activate
echo "vgg16_32_0.01_p40_loss_only"
nvprof --timeout 300 --csv --profile-from-start off --print-summary python subsectionMain.py --arch vgg16 -b 32 --epochs 1 --lr 0.01 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --profile-from-start off --timeout 100 --metric gld_efficiency python subsectionMain.py -a alexnet -b 16 --epochs 1 --lr 0.01 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --timeout 1800 --csv --profile-from-start off --track-memory-allocations on --cpu-profiling on --print-summary python subsectionMain.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --timeout 1800 --output-profile alexnet_loss_only_16_0.001_small_p40_%p.nvvp --csv --log-file alexnet_loss_only_16_0.001_small_p40_%p.log --profile-from-start off --track-memory-allocations on --cpu-profiling on --print-summary python subsectionMain.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small


# source ~/pytorch_env/py3.6.3/bin/activate
# echo "alexnet_16_0.001_p40_loss_only"
# nvprof --timeout 1800 --output-profile alexnet_loss_only_16_0.001_small_p40_%p.nvvp --csv --log-file alexnet_loss_only_16_0.001_small_p40_%p.log --profile-from-start off --track-memory-allocations on --cpu-profiling on --print-summary python subsectionMain.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# # nvprof --output-profile alexnet_loss_only_16_0.001_small_p40_%p.nvvp --csv --log-file alexnet_loss_only_16_0.001_small_p40_%p.log --profile-from-start off --track-memory-allocations on --cpu-profiling on --print-summary python subsectionMain.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
