#
# JupyterLab installation on Ubuntu, with Python and R kernels
#
FROM ubuntu:16.04

ENV JL_DATA /var/jupyterlab/data
ENV JL_PORT 8888

# Install Python
RUN apt-get update 
RUN  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# Install Python 2 and Jupyter 
RUN python2 -m pip install ipykernel && \
    python2 -m ipykernel install --user && \
    ipython kernel install && \
    pip install --upgrade pip 
    

# Install Python 3 and Jupyter 3
RUN apt-get update 
RUN apt-get install -y python3 python3-pip ipython3-notebook && \ 
    pip3 install --upgrade pip && \
    pip3 install -U jupyter && \
    ipython3 kernelspec install-self

# Install JupyterLab
RUN pip install jupyterlab && \
    jupyter serverextension enable --py jupyterlab --sys-prefix

# Install R and IRKernel
RUN echo "deb http://cran.ms.unimelb.edu.au/bin/linux/ubuntu xenial/" | tee -a /etc/apt/sources.list
RUN apt-get update 
RUN apt-get install -y libcurl4-openssl-dev libssl-dev
RUN apt-get install -y --allow-unauthenticated r-base 
COPY irkernel.R /tmp/
RUN R CMD BATCH /tmp/irkernel.R

# Install Folium and Plotly
RUN apt-get -y install pandoc
RUN pip3 install folium plotly pandas matplotlib
 
# Expose Jupyter port and start Jupyter
EXPOSE ${JL_PORT}
COPY startup.sh /tmp/
RUN mkdir -p ${JL_DATA} && chmod a+x /tmp/startup.sh
CMD /tmp/startup.sh
