#! /bin/bash

set -exu -o pipefail

TOOL_ROOT=$(realpath "$0" | xargs dirname | xargs dirname | xargs dirname)

echo "${TOOL_ROOT}"
cd "${TOOL_ROOT}"

# 安装到全局的python中，无需创建虚拟环境(当前已经使用uniSDK，对运行环境的依赖很少)
pip3 install "pytest>=7" "pytest-timeout>=2.3" "testsolar-testtool-sdk>=0.1.9"

# 将version信息写进文件，来判断走sdk V1还是V2逻辑
solarctl version > /tmp/solarctl_version

# 暂时仅支持amd64，后续再支持arm64
curl -Lk https://github.com/OpenTestSolar/testtools-uni-sdk/releases/download/0.0.2/testtools_sdk.amd64 -o /usr/local/bin/testtools_sdk
chmod +x /usr/local/bin/testtools_sdk
