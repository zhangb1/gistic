FROM ubuntu:14.04

# Note: FROM java and FROM r-base work too but take much longer apt-get updating

RUN apt-get update && apt-get upgrade --yes && \
        apt-get install -y wget && \
        apt-get install --yes bc vim libxpm4 libXext6 libXt6 libXmu6 libXp6 zip unzip  build-essential

#RUN apt-get update && apt-get upgrade --yes && \
#    apt-get install build-essential --yes
#    apt-get install python-dev groff  --yes --force-yes && \
#    apt-get install default-jre --yes --force-yes && \
#    wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py  && \
#    apt-get install software-properties-common --yes --force-yes && \
#    add-apt-repository ppa:fkrull/deadsnakes-python2.7 --yes

RUN mkdir /home/gistic
WORKDIR /home/gistic

RUN mkdir /home/gistic/MCRInstaller

RUN cd /home/gistic/MCRInstaller && \
   wget https://www.mathworks.com/supportfiles/downloads/R2014a/deployment_files/R2014a/installers/glnxa64/MCR_R2014a_glnxa64_installer.zip && \
#   wget ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTIC_2_0_23.tar.gz && \
   unzip MCR_R2014a_glnxa64_installer.zip
#   tar -zxvf GISTIC_2_0_23.tar.gz

RUN cd /home/gistic && \
    wget ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTIC_2_0_23.tar.gz && \
    tar -zxvf GISTIC_2_0_23.tar.gz

#RUN mkdir /builddd
#COPY Dockerfile /build/Dockerfile

#COPY runMatlab.sh /usr/local/bin/runMatlab.sh
#COPY matlab.conf /etc/ld.so.conf.d/matlab.conf

#RUN  chmod a+x /usr/local/bin/runMatlab.sh && \
RUN  cd /home/gistic/MCRInstaller && \
        /home/gistic/MCRInstaller/install -mode silent -agreeToLicense yes -destinationFolder /usr/local/MATLAB/MATLAB_Compiler_Runtime/
#COPY module/gp_gistic2_from_seg /usr/local/bin/gp_gistic2_from_seg

ENV LD_LIBRARY_PATH /usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/bin/glnxa64:/usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/sys/os/glnxa64:${LD_LIBRARY_PATH}
ENV XAPPLRESDIR /usr/local/MATLAB/MATLAB_Compiler_Runtime/v83/X11/app-defaults

CMD ["/bin/bash"]
