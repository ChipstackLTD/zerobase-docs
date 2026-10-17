$ErrorActionPreference = 'Stop'

$files = @(
  @{ Url = 'https://cdn.chipstack.vn/reference/CH32V003DS0%20datasheet.pdf'; OutFile = 'cdn/reference/CH32V003DS0 datasheet.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/reference/CH32V003RM%20Reference%20Manual.pdf'; OutFile = 'cdn/reference/CH32V003RM Reference Manual.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/reference/CH32V203DS0%20datasheet.pdf'; OutFile = 'cdn/reference/CH32V203DS0 datasheet.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/reference/CH32FV2x_V3x%20Reference%20Manual.pdf'; OutFile = 'cdn/reference/CH32FV2x_V3x Reference Manual.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/reference/WCHISPTool_CMD_Instruction.pdf'; OutFile = 'cdn/reference/WCHISPTool_CMD_Instruction.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/reference/WCH_LinkUserManual.pdf'; OutFile = 'cdn/reference/WCH_LinkUserManual.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/reference/esp8285-datasheet.pdf'; OutFile = 'cdn/reference/esp8285-datasheet.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/zerobase/schematic/SCH_Zerobase.pdf'; OutFile = 'cdn/zerobase/SCH_Zerobase.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/zerobase2/schematic/SCH_Zerobase_2.pdf'; OutFile = 'cdn/zerobase2/SCH_Zerobase_2.pdf' },
  @{ Url = 'https://cdn.chipstack.vn/zerobase2w/schematic/SCH_Zerobase_2W.pdf'; OutFile = 'cdn/zerobase2w/SCH_Zerobase_2W.pdf' }
)

foreach ($file in $files) {
  $directory = Split-Path -Parent $file.OutFile
  if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
  }

  Write-Host "Downloading $($file.Url)"
  Invoke-WebRequest -Uri $file.Url -OutFile $file.OutFile
}
