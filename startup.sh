#!/bin/bash
set -x
jupyter lab --ip=* --port=${JL_PORT} --no-browser --notebook-dir=${JL_DATA} --debug