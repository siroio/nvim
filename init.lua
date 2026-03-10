require("config.options")
require("config.lazy")

-- Auto-install DotRush if not present
local function ensure_dotrush()
    local data_path = vim.fn.stdpath("data")
    local dotrush_dir = data_path .. "/dotrush"
    local dotrush_exe = dotrush_dir .. "/DotRush.exe"

    if vim.fn.filereadable(dotrush_exe) == 0 then
        print("DotRush not found. Downloading...")
        vim.fn.mkdir(dotrush_dir, "p")

        local ps_script = [[
            $ErrorActionPreference = 'Stop'
            $InstallPath = ']] .. dotrush_dir .. [['
            $DownloadUrl = (Invoke-RestMethod -Uri "https://api.github.com/repos/JaneySprings/DotRush/releases/latest").assets | Where-Object { $_.name -eq "DotRush.Bundle.Server_win32-x64.zip" } | Select-Object -ExpandProperty browser_download_url
            $ZipPath = Join-Path -Path $InstallPath -ChildPath "DotRush.zip"
            Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipPath
            Expand-Archive -Path $ZipPath -DestinationPath $InstallPath -Force
            Remove-Item -Path $ZipPath
        ]]

        vim.fn.jobstart({ "powershell", "-NoProfile", "-Command", ps_script }, {
            on_exit = function(_, code)
                if code == 0 then
                    print("DotRush installed successfully!")
                else
                    print("Failed to install DotRush. Exit code: " .. code)
                end
            end,
        })
    end
end

ensure_dotrush()
