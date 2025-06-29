FROM python

#Required for tzdata
ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Clone depot_tools
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /depot_tools
# Add depot_tools to PATH
ENV PATH="/depot_tools:${PATH}"

# Install dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git unzip curl build-essential cmake ninja-build libx11-dev libxcursor-dev libxi-dev libgl1-mesa-dev libfontconfig1-dev

RUN ln -s /usr/bin/python3 /usr/bin/python

COPY compile.sh /

VOLUME /dependencies
VOLUME /output

WORKDIR /output

RUN ["chmod", "+x", "/compile.sh"]

ENTRYPOINT ["/compile.sh"]
