FROM ubuntu:18.04

# Maintainer
LABEL maintainer="albertotricker@correo.ugr.es"

# Force non interactive mode, avoid geographic zone request.
ARG DEBIAN_FRONTEND=noninteractive

# Install R and commons needed packages
RUN \
  apt-get update && \
  apt-get install -y apt-transport-https software-properties-common && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
  apt-get update && \
  apt-get install -y r-base && \
  apt-get install -y libxml2-dev && \
  apt-get install -y libxt-dev && \
  apt-get install -y libcairo2-dev && \
  apt-get install -y libapparmor1 && \
  apt-get install -y libcurl4-gnutls-dev && \
  apt-get install -y libssl-dev && \
  apt-get install -y default-jre && \
  apt-get install -y default-jdk && \
  R CMD javareconf && \
  rm -rf /var/lib/apt/lists/*

# Install R packages
RUN \
  echo "install.packages(\"rJava\")" | R --no-save && \
  echo "install.packages(\"RWeka\")" | R --no-save && \
  echo "install.packages(\"tydiverse\")" | R --no-save && \
  echo "install.packages(\"caret\")" | R --no-save && \
  echo "install.packages(\"rmatio\")" | R --no-save && \
  echo "install.packages(\"RSNNS\")" | R --no-save && \
  echo "install.packages(\"frbs\")" | R --no-save && \
  echo "install.packages(\"FSinR\")" | R --no-save && \
  echo "install.packages(\"forecast\")" | R --no-save

# Define working directory
WORKDIR /home/project

# Copy files
COPY stack_train.mat variables.mat test_script.R ./

# Define default command.
CMD ["bash"]


