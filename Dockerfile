# start from a clean base image
FROM runpod/worker-comfyui:5.4.1-base

RUN mkdir /setup
COPY custom_nodes.txt /setup/custom_nodes.txt
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

# install custom nodes
RUN echo "installing custom nodes"
WORKDIR /comfyui/custom_nodes
RUN xargs -n 1 git clone --recursive < /setup/custom_nodes.txt && \
    find /comfyui/custom_nodes -name "requirements.txt" -exec uv pip install --no-cache-dir -r {} \; && \
    find /comfyui/custom_nodes -name "install.py" -exec uv python {} \; ;
RUN echo "custom nodes installed"

