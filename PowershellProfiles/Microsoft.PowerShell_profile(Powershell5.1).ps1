# This profile is for Powershell 5.1
#powershell.exe -NoLogo
Import-Module oh-my-posh
Import-Module -Name Terminal-Icons
oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/capr4n.omp.json | Invoke-Expression

#oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/clean-detailed.omp.json | Invoke-Expression
#Get-PoshThemes
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
##############################
#configuring psreadline works on powershell 7 and above only

Import-Module -Name psreadline
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -Colors @{
  Command            = 'Magenta'
  Number             = 'DarkGray'
  Member             = 'DarkGray'
  Operator           = 'DarkGray'
  Type               = 'DarkGray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = 'DarkGray'
  Default            = 'DarkGray'
  error              = 'DarkRed'
  InlinePrediction   = 'Green'
  # ContinuationPrompt: The color of the continuation prompt.
  # Emphasis: The emphasis color. For example, the matching text when searching history.
  # Error: The error color. For example, in the prompt.
  # Selection: The color to highlight the menu selection or selected text.
  # Default: The default token color.
  # Comment: The comment token color.
  # Keyword: The keyword token color.
  # String: The string token color.
  # Operator: The operator token color.
  # Variable: The variable token color.
  # Command: The command token color.
  # Parameter: The parameter token color.
  # Type: The type token color.
  # Number: The number token color.
  # Member: The member name token color.
  # InlinePrediction: The color for the inline view of the predictive suggestion.
}
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionSource 'History'
# Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -BellStyle Audible -DingTone 1221 -DingDuration 60
Clear

# Winget Auto completion (https://github.com/microsoft/winget-cli/blob/1fbfacc13950de8a17875d40a8beb99fc6ada6c2/doc/Completion.md)
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
      [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
      $Local:word = $wordToComplete.Replace('"', '""')
      $Local:ast = $commandAst.ToString().Replace('"', '""')
      winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
          [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
      }
}
