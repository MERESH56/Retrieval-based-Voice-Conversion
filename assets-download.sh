#!/usr/bin/env bash
#
# Downloads required large files for RVC.

set -e

REPO_FOLDER="VoiceConversionWebUI"

assets_commit_hash="$1"
assets_dir="$2"

export GIT_CLONE_PROTECTION_ACTIVE=false
export GIT_LFS_SKIP_SMUDGE=1

git clone https://huggingface.co/lj1995/VoiceConversionWebUI "${REPO_FOLDER}"

pushd "${REPO_FOLDER}"

git checkout "${assets_commit_hash}"

unset GIT_LFS_SKIP_SMUDGE
unset GIT_CLONE_PROTECTION_ACTIVE

git lfs pull --include="hubert_base.pt"
git lfs pull --include="pretrained"
git lfs pull --include="uvr5_weights"
git lfs pull --include="rmvpe.pt"
git lfs pull --include="rmvpe.onnx"

popd

mkdir -p "${assets_dir}"

cp "${REPO_FOLDER}/hubert_base.pt" "${assets_dir}/hubert_base.pt"

mkdir -p "${assets_dir}/rmvpe"

cp "${REPO_FOLDER}/rmvpe.pt" "${assets_dir}/rmvpe/rmvpe.pt"
cp "${REPO_FOLDER}/rmvpe.onnx" "${assets_dir}/rmvpe/rmvpe.onnx"

cp -r "${REPO_FOLDER}/pretrained" "${assets_dir}/pretrained"
cp -r "${REPO_FOLDER}/uvr5_weights" "${assets_dir}/uvr5_weights"
