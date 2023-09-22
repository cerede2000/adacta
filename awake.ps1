# This script will prevent a machine from locking, it presses the F15 key every 30 seconds
# It does NOT have to run as an admin, just right click and "Run with PowerShell" then type "A" if prompted

Clear-Host
Push-Location $PSScriptRoot

#region Functions
try {
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  
  public class KeyboardUtils {
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, int dwFlags, int dwExtraInfo);
    
    public const byte VK_F15 = 0x7E;   // F15 key code
    public const int KEYEVENTF_KEYUP = 0x02;
  }
"@
} catch {}

# Function to simulate pressing the F15 key
function Invoke-F15KeyPress {
	Write-Host "Preventing screen locking by simulating F15 key press..."
    	[KeyboardUtils]::keybd_event([KeyboardUtils]::VK_F15, 0, 0, 0)
    	[KeyboardUtils]::keybd_event([KeyboardUtils]::VK_F15, 0, [KeyboardUtils]::KEYEVENTF_KEYUP, 0)
}
#endregion

#region Prevent Screen Locking

# Main loop to prevent screen locking by simulating F15 key press every 30 seconds (adjust as needed)
while ($true) {
    
    Invoke-F15KeyPress
    Start-Sleep -Seconds 30
}

#endregion

