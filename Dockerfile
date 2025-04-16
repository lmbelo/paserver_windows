# Use Windows Nano Server image
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

# Set the default shell to PowerShell
SHELL ["powershell", "-Command"]

# Set working directory
WORKDIR C:\\PAServer

# Download PAServer zip file from OneDrive using Invoke-WebRequest
RUN Invoke-WebRequest -Uri "https://3aroma.dm.files.1drv.com/y4m35OvjObnsmV76hQuj8dY8kxg5MkoDCXQNeXF436gtdInfuXvgwEogSqkv1EEFKw_qci34aYDa4M5r6bjtTWn8DYSeBA8C42AYfQEkWIzuVYyFY1ZpAieTB15mUVZrY922IAcDIcog4dMT4K_xf2Rp_gdQUli4Dzh402biae5VQHs2oXkBcOx5i94nv_eoHHEERxeogzfOcpUWLMuYfBObrqXVb6XInv3oAxnYxFL2CE?AVOverride=1" ;

RUN dir

# Move PAServer contents if needed (if it's in a subfolder)
RUN if (Test-Path .\\PAServer\\23.0\\PAServer.exe) { \
        Copy-Item -Path ".\\PAServer\\23.0\\*" -Destination . -Recurse ; \
        Remove-Item -Recurse -Force .\\PAServer ; \
    }

# Expose PAServer default port
EXPOSE 64211

# Run PAServer
CMD ["C:\\PAServer\\PAServer.exe"]
