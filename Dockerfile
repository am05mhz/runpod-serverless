# start from a clean base image
FROM runpod/worker-comfyui:5.5.1-base

RUN mkdir /setup
COPY custom_nodes.txt /setup/custom_nodes.txt
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

# install custom nodes
RUN echo "installing custom nodes"
WORKDIR /comfyui/custom_nodes
RUN xargs -n 1 git clone --recursive < /setup/custom_nodes.txt && \
    find /comfyui/custom_nodes -name "requirements.txt" | xargs -I {} uv pip install --no-cache-dir -r {} && \
    find /comfyui/custom_nodes -name "install.py" | xargs -I {} uv python {} ;
RUN echo "custom nodes installed"

COPY /inputs/* /comfyui/input/

WORKDIR /comfyui
RUN git pull
RUN uv pip install --no-cache-dir -r requirements.txt

# COPY --chmod=755 pre-start.sh /pre-start.sh

# Copy your handler code
COPY src/handler.py /

CMD ["/start.sh"]