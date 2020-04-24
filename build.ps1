Remove-Item -Path __pycache__ -Recurse
Remove-Item -Path build -Recurse
Remove-Item -Path dist -Recurse
Remove-Item -Path main.spec
pyinstaller --onefile --hidden-import babel.numbers main.py
