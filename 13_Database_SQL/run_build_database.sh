#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
python3 00_build_database.py
