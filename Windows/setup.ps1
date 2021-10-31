# Setup script for PC using winget and enabling WSL
# Must run in PowerShell as administrator (after updating AppInstaller from MS Store)

##############################################################
# Install list
##############################################################
$appList=@(
  "Notion.Notion"
  "Google.chrome"
  "7zip.7zip"
  "Microsoft.VisualStudioCode"
  "Microsoft.VisualStudio.2019.BuildTools"
  "Microsoft.SQLServer.2019.Express"
  "Microsoft.SQLServerManagementStudio"
  "Microsoft.PowerShell"
  "Microsoft.WindowsTerminal"
  "Microsoft.PowerToys"
  "Microsoft.AzureCLI"
  "Microsoft.AzureStorageExplorer"
  "Canonical.Ubuntu"
  "Git.Git"
  "TortoiseGit.TortoiseGit"
  "Docker.DockerDesktop"
  "Postman.Postman"
  "Python.Python.3"
  "GoLang.Go"
  "Oracle.JDK.17"
  "Graphviz.Graphviz"
  "vim.vim"
  "Volta.Volta"
)

##############################################################
# Install function
##############################################################
function exec_search_app($app) {
  return $installed_lists | Out-String -Stream | Select-String $app
}

function exec_winget($app) {
  $appExist=exec_search_app $app
  if($appExist -ne $null) {
    $result="Install already: $app"
    echo $result
    $script:exec_result+=$result
    return
  }

  echo "Start install: $app"
  & winget install -h $app

  if($LastExitCode -eq 0) {
    $result="Install succeeded: $app"
  } else {
    $result="Install failed: $app"
  }

  echo $result
  $script:exec_result+=$result
}

$exec_result=@()
$installed_lists=winget list
foreach($app in $appList) {
  exec_winget $app
}

echo "Install is finished."
echo $exec_result

##############################################################
# Setting
##############################################################
# nodejs
volta install node

# python
pip3 install pipenv

# Vim
set-alias vim 'C:\Program Files\Vim\vim82\vim.exe'

# Activate WSL
## * https://docs.microsoft.com/fr-fr/windows/wsl/install-win10)
## * https://support.rstudio.com/hc/en-us/articles/360049776974-Using-RStudio-Server-in-Windows-WSL2
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
## WSL 2
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
wsl --set-default-version 2 # Use V2 of WSL By Default 

## restart PC
Restart-Computer