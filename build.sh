#!/bin/bash
rm -rf __pycache__/ main.spec dist/ build/
pyinstaller --onefile --hidden-import babel.numbers main.py
