#!/bin/bash

docker run --rm -v $(pwd):/app -w /app lbb/bbos-builder make $1