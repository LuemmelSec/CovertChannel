## stripped down version of https://superuser.com/questions/1324007/setting-window-size-and-position-in-powershell-5-and-6/1324170#1324170
function Set-Window {
    param(
        [string]$ProcessName = '*',
        [int]$Id,
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height
    )

    if (-not ([type]::GetType('Window'))) {
        Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Window {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
public struct RECT {
    public int Left, Top, Right, Bottom;
}
"@
    }

    $processes = if ($PSBoundParameters.ContainsKey('Id')) {
        Get-Process -Id $Id -ErrorAction SilentlyContinue
    } else {
        Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
    }

    foreach ($p in $processes) {
        $hwnd = $p.MainWindowHandle
        if ($hwnd -eq [IntPtr]::Zero) { continue }

        [RECT]$rect = New-Object RECT
        [Window]::GetWindowRect($hwnd, [ref]$rect) | Out-Null

        $x = if ($PSBoundParameters.ContainsKey('X')) { $X } else { $rect.Left }
        $y = if ($PSBoundParameters.ContainsKey('Y')) { $Y } else { $rect.Top }
        $w = if ($PSBoundParameters.ContainsKey('Width')) { $Width } else { $rect.Right - $rect.Left }
        $h = if ($PSBoundParameters.ContainsKey('Height')) { $Height } else { $rect.Bottom - $rect.Top }

        [Window]::MoveWindow($hwnd, $x, $y, $w, $h, $true) | Out-Null
    }
}
