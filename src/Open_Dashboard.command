#!/bin/bash
cd "$(dirname "$0")" || exit 1
exec /opt/miniconda3/bin/python -m streamlit run dashboard.py
