#!/bin/bash

docker run --rm -v $(pwd):/app -w /app smatyukevich/bbos-builder make $1