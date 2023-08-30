# Copyright 2021 The terraform-docs Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM quay.io/terraform-docs/terraform-docs:0.16.0

# this is explicitly needed because yq v4.x only exists in this repo.
# ref: https://mikefarah.gitbook.io/yq/v/v3.x/#alpine-linux
# Using an official mirror from https://dl-cdn.alpinelinux.org/alpine/MIRRORS.txt
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
# https://www.alpinelinux.org/posts/Alpine-edge-signing-keys-rotated.html
RUN apk add -X https://dl-cdn.alpinelinux.org/alpine/v3.16/main -u alpine-keys

RUN set -x \
    && apk update \
    && apk add --no-cache \
        bash \
        git \
        git-lfs \
        jq \
        openssh \
        sed \
        yq

COPY ./src/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
