# This profile is for Powershell 7.2
##############################
# configuring psreadline works on powershell 7 and above only

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

