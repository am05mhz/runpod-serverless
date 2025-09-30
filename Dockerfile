# start from a clean base image
FROM runpod/worker-comfyui:5.4.1-base

# install custom nodes using comfy-cli
RUN comfy-node-install ComfyUI-KJNodes ComfyUI-IC-Light \
    ComfyUI-RMBG comfyui_controlnet_aux ComfyUI_IPAdapter_plus \
    ComfyUI_LayerStyle ComfyUI_LayerStyle_Advance Masquerade-Nodes \
    ComfyUI-DepthAnythingV2 ComfyUI_BiRefNet_ll stability-ComfyUI-nodes \
    ComfyUI_Zwng_Nodes ComfyUI-Nikosis-Preprocessors ComfyUI_essentials
