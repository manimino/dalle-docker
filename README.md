## Dockerfile for DALL-E Mega

Follow instructions in [Boris Dayma's DALL-E mini repo](https://github.com/borisdayma/dalle-mini/) to download the 
latest DALL-E Mega model.

This Dockerfile will run the notebooks from that repo and generate you some images. 
Just like the Huggingface space does. Haven't tried training yet.

On an RTX 3090, it takes about 5.6 seconds per image (so 50 seconds for a 9-pack of images).

Image generation also worked on CPU, but took several minutes per image.

The images look great:

![Spiderman generated image](img/spidey.png)

## Instructions

### Build this Dockerfile:

`docker build -t dallemega .`

### Run it:

Replace `YOUR_PATH_HERE` with wherever wandb downloaded your dall-e checkpoint to:

`docker run --gpus all -it --rm -v $(realpath ~/notebooks):/notebooks -v /YOUR_PATH_HERE/artifacts/:/artifacts -p 8888:8888 dallemega`

That will launch a Jupyter notebook instance, open a browser to `localhost:8888/?token=...` and copy the token from 
stdout.

If your `docker run` command fails, you may need to install `nvidia-container-toolkit`. That's an OS-specific process 
so... Google around. Good luck.

### Run the inference notebook

Make a notebook in `/notebooks` and copy/paste stuff into it from the 
[dalle-mini inference notebook](https://github.com/borisdayma/dalle-mini/blob/main/tools/inference/inference_pipeline.ipynb).

Replace the DALLE_MODEL path with yours. So if you have checkpoint 15, it looks like:

`DALLE_MODEL = "/artifacts/mega-1:v15"`

