#!/bin/bash
$p_dir/generate_modes.py
err=$?
rm -r $p_dir/__pycache__
exit $err
