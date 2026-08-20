FROM runpod/worker-comfyui:5.8.6-base
RUN comfy-node-install comfyui-kjnodes rgthree-comfy comfyui-easy-use ComfyUI-GGUF ComfyUI-Crystools cg-use-everywhere
# download models using comfy-cli comfyui-impact-pack  comfyui-impact-subpack comfyui_controlnet_aux  comfyui_essentials 
RUN comfy model download --url https://huggingface.co/Comfy-Org/Krea-2/resolve/main/diffusion_models/krea2_turbo_bf16.safetensors --relative-path models/unet --filename krea2_turbo_bf16.safetensors
# Copy local static input files into the ComfyUI input directory
COPY input/ /comfyui/input/
RUN comfy model download --url https://huggingface.co/Comfy-Org/Krea-2/resolve/main/text_encoders/qwen3vl_4b_bf16.safetensors --relative-path models/text_encoders --filename qwen3vl_4b_bf16.safetensors
# https://huggingface.co/Comfy-Org/Krea-2/resolve/main/text_encoders/qwen3vl_4b_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Krea-2/resolve/main/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
# docker build --platform linux/amd64 -t <your-image-name>:<tag> .

# # Add Docker's official GPG key:
# sudo apt update
# sudo apt install ca-certificates curl
# sudo install -m 0755 -d /etc/apt/keyrings
# sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
# sudo chmod a+r /etc/apt/keyrings/docker.asc

# # Add the repository to Apt sources:
# sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
# Types: deb
# URIs: https://download.docker.com/linux/debian
# Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
# Components: stable
# Architectures: $(dpkg --print-architecture)
# Signed-By: /etc/apt/keyrings/docker.asc
# EOF

#  sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin