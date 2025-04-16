# Use lightweight Windows base image
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

SHELL ["powershell", "-Command"]

# Set working directory
WORKDIR C:\\PAServer

# Download PAServer ZIP from Google Drive
RUN Invoke-WebRequest -Uri "https://drive.usercontent.google.com/download?id=1FidLUJJHxbKdROxWIlGVQVsj_bvb0t3Y&export=download&authuser=0&confirm=t&uuid=75a2e795-cc82-4ae2-a2aa-1f32acbb3a0b&at=APcmpoyAWZLyXubF3n22W7_rhD5s%3A1744832917527" -OutFile paserver.zip ; \
    Expand-Archive -Path paserver.zip -DestinationPath . ; \
    Remove-Item paserver.zip

# Copy the correct subfolder to the working directory root
RUN Copy-Item -Path "PAServer\\23.0\\*" -Destination . -Recurse ; \
    Remove-Item -Recurse -Force PAServer

# Expose default PAServer port
EXPOSE 64211

# Run PAServer
CMD ["C:\\PAServer\\PAServer.exe"]
