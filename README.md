# Automated PC Setup
Automates various Machine Installations

## What Does It Do?
Below is a list of some of the functions of the script:

- Installs Various Applications via Winget
- Downloads various configs & settings
- Enabling WSL2

## Notes
- You need to Windows Package Manager(winget) 
- You need to run Powershell as an Administrator
- Before executing the Setup Script, you will probably have to change the execution policy in Powershell to Unrestricted
  ```powershell
  Set-ExecutionPolicy Unrestricted -Force
  ```

- You can execute the Powershell script as follows:
  ```powershell
  Powershell.exe ./Setup.ps1
  ```