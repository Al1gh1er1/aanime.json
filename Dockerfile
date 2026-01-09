# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow contains only unknown_registry custom nodes and no aux_id (GitHub repo) metadata,
# so these could not be automatically resolved or installed. Please provide the repository URLs
# or registry IDs for these if you want them installed automatically.
# - CheckpointLoaderSimple (unknown_registry - no aux_id provided)
# - CLIPSetLastLayer (unknown_registry - no aux_id provided)
# - MultiLoRAStack (unknown_registry - no aux_id provided)
# - FaceDetailer (unknown_registry - no aux_id provided)
# - UltralyticsDetectorProvider (unknown_registry - no aux_id provided)
# - SAMLoader (unknown_registry - no aux_id provided)
# - UltralyticsDetectorProvider (duplicate) (unknown_registry - no aux_id provided)
# - mxSeed (unknown_registry - no aux_id provided)
# - ConditioningMultiCombine (unknown_registry - no aux_id provided)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/knifeayumu/StableDiffusionXL_Collection/blob/b9bdbce55adfba10b36ec290a13748193cb0e3f6/animagineXL40_v4Opt.safetensors --relative-path models/checkpoints --filename animagineXL40_v4Opt.safetensors
RUN comfy model download --url https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth --relative-path models/sams --filename sam_vit_b_01ec64.pth
RUN comfy model download --url https://huggingface.co/ashllay/YOLO_Models/blob/e07b01219ff1807e1885015f439d788b038f49bd/bbox/nipples_yolov8s.pt --relative-path models/ultralytics/bbox --filename nipples_yolov8s.pt
# RUN # Could not find URL for segm/nipples_yolov8s-seg.pt

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
