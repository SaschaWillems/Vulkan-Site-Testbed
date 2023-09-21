#! /bin/bash
rwd=$(pwd)

git -C "vulkan-tutorial" pull || git clone https://github.com/KhronosGroup/Vulkan-Tutorial.git "vulkan-tutorial"
git -C "vulkan-guide" pull || git clone https://github.com/KhronosGroup/Vulkan-Guide.git "vulkan-guide"
git -C "vulkan-samples" pull || git clone https://github.com/KhronosGroup/Vulkan-Samples.git "vulkan-samples"

cd antora-ui-khronos
npm install
gulp bundle
cd $rwd

cd vulkan-tutorial/antora
make
cd $rwd

cd vulkan-guide
make -f antora/Makefile clean setup
cd $rwd

cd vulkan-samples
cmake -H"." -B"build/unix" -DVKB_GENERATE_ANTORA_SITE=ON
cd $rwd

npx antora antora-playbook.yml
