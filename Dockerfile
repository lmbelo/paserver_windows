# Use lightweight Windows base image
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

SHELL ["powershell", "-Command"]

# Set working directory
WORKDIR C:\PAServer

# Download PAServer ZIP from Google Drive
RUN Invoke-WebRequest -Uri "https://drive.usercontent.google.com/uc?export=download&id=1FidLUJJHxbKdROxWIlGVQVsj_bvb0t3Y" -OutFile paserver.zip ; \
    Expand-Archive -Path paserver.zip -DestinationPath . ; \
    Remove-Item paserver.zip

# Copy the correct subfolder to the working directory root
RUN Copy-Item -Path "PAServer\\23.0\\*" -Destination . -Recurse ; \
    Remove-Item -Recurse -Force PAServer

# Expose default PAServer port
EXPOSE 64211

# Run PAServer
CMD ["C:\\PAServer\\PAServer.exe"]
