#!/bin/bash
set GPU = %1
#SBATCH --verbose
#SBATCH --job-name=expCloudML
#SBATCH --mem=100GB
#SBATCH --output=out.inception_4_0.01_%GPU%_full.%j

##SBATCH --time=100:00:00
##SBATCH--gres=gpu:1

#SBATCH --mem=250GB
#SBATCH --nodes=1
#SBATCH --cpus-per-task=28
#SBATCH --exclusive
#SBATCH --time=00:60:00
#SBATCH --gres=gpu:%GPU%:4
##SBATCH --gres=gpu:%GPU%:4
#SBATCH --reservation=chung

# module load pytorch/python2.7/0.3.0_4
# module load pytorch/python3.6/0.3.0_4

# conda activate base
module load python3/intel/3.6.3 cuda/9.0.176 nccl/cuda9.0/2.4.2

source ~/pytorch_env/py3.6.3/bin/activate

echo "inception_4_0.01_%GPU%_full"
nvprof --timeout 300 --output-profile inception_4_0.01_%GPU%_full_%p.nvvp --csv --print-summary python main.py --arch inception_v3 -b 4 --epochs 1 --lr 0.01 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --timeout 300 --kernels "convolve" --metrics gld_efficiency --csv --print-summary python main.py --arch inception_v3 -b 8 --epochs 1 --lr 0.01 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --timeout 300 --output-profile inception_64_0.01_%GPU%_full_%p_mem.nvvp --csv --track-memory-allocations on --print-summary python main.py --arch inception_v3 -b 64 --epochs 1 --lr 0.01 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small


# nvprof --timeout 900 --csv --metric gld_efficiency python main.py --arch alexnet -b 16 --epochs 1 --lr 0.01 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --timeout 300 --csv --cpu-profiling on --print-summary python main.py --arch alexnet -b 16 --epochs 1 --lr 0.01 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --timeout 1800 --csv --track-memory-allocations on --cpu-profiling on --print-summary python main.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# nvprof --timeout 1800 --output-profile alexnet_16_0.001_small_%GPU%_timeout_%p.nvvp --csv --log-file alexnet_16_0.001_small_%GPU%_timeout_%p.log --track-memory-allocations on --cpu-profiling on --print-summary python main.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small


# echo "alexnet_16_0.001_%GPU%_full"
# nvprof --timeout 1800 --output-profile alexnet_16_0.001_small_%GPU%_timeout_%p.nvvp --csv --log-file alexnet_16_0.001_small_%GPU%_timeout_%p.log --track-memory-allocations on --cpu-profiling on --print-summary python main.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
# # nvprof --output-profile alexnet_16_0.001_small_%GPU%_wotimeout_%p.nvvp --csv --log-file alexnet_16_0.001_small_%GPU%_wotimeout_%p.log --track-memory-allocations on --cpu-profiling on --print-summary python main.py --arch alexnet -b 16 --epochs 1 --lr 0.001 /beegfs/work/courses/2019-CSCI-GA-3033-025/imagenet_pytorch_small
