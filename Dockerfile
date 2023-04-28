FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04

# declare the image name
ENV IMG_NAME=11.2.2-cudnn8-devel-ubuntu20.04 \
    # declare what jaxlib tag to use
    # if a CI/CD system is expected to pass in these arguments
    # the dockerfile should be modified accordingly
    # JAXLIB_VERSION=0.1.62
    JAXLIB_VERSION=0.3.22

# install python3-pip
RUN apt update && apt install python3-pip -y

# install dependencies via pip
# tried cudnn 82, no joy. trying 805 as it's the only other one.
RUN pip3 install numpy scipy six wheel jaxlib==${JAXLIB_VERSION}+cuda11.cudnn805 -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

# this specific one works. 0.1.6x did not, neither did 0.3. Haven't tried many others.
# RUN pip3 install "jax[cuda112]==0.1.77"
RUN pip3 install "jax[cuda112]==0.3.22"
RUN pip3 install jupyter
EXPOSE 8888

RUN apt-get install -y git
RUN pip install git+https://github.com/borisdayma/dalle-mini.git
RUN pip install -q git+https://github.com/huggingface/transformers.git
RUN pip install -q git+https://github.com/patil-suraj/vqgan-jax.git

CMD jupyter notebook --allow-root --ip 0.0.0.0
