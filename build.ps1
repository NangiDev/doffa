Set-Alias exist Test-Path -Option "Constant, AllScope"

if (exist __pycache) { Remove-Item -Path __pycache__ -Recurse }
if (exist build) { Remove-Item -Path build -Recurse }
if (exist dist) { Remove-Item -Path dist -Recurse }
if (exist main.spec) { Remove-Item -Path main.spec }

pyinstaller --onefile --hidden-import babel.numbers main.py
