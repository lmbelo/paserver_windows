# Use Windows Nano Server image
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

SHELL ["powershell", "-Command"]

# Set working directory
WORKDIR C:\\PAServer

# Download and extract PAServer using curl
RUN curl.exe -L -o paserver.zip "https://objects.githubusercontent.com/github-production-release-asset-2e65be/967651626/875acf35-3b19-4490-933e-6c229fb1919d?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250416%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250416T195309Z&X-Amz-Expires=300&X-Amz-Signature=f6d4f6e0b4225cfc8ab6fe93fc6e1ed5d8d315137002ad1aee437eca8dd8ed19&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3DPAServer_12_3.zip&response-content-type=application%2Foctet-stream" ; \
    powershell -Command "Expand-Archive -Path paserver.zip -DestinationPath ."; \
    del paserver.zip

# Move PAServer contents up if necessary
RUN if (Test-Path .\\PAServer\\23.0\\PAServer.exe) { \
        Copy-Item -Path ".\\PAServer\\23.0\\*" -Destination . -Recurse ; \
        Remove-Item -Recurse -Force .\\PAServer ; \
    }

# Expose PAServer default port
EXPOSE 64211

# Run PAServer
CMD ["C:\\PAServer\\PAServer.exe"]
