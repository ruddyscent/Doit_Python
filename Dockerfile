FROM quay.io/jupyter/datascience-notebook

USER root

RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get -y install --no-install-recommends \
    fonts-nanum \
 && apt-get clean autoclean \
 && apt-get autoremove --yes 
# && rm -rf /var/lib/apt/lists/*
# && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN cp /usr/share/fonts/truetype/nanum/Nanum* /opt/conda/lib/python3.12/site-packages/matplotlib/mpl-data/fonts/ttf/ \
 && fc-cache -f

COPY requirements.txt /tmp/pip-tmp/

RUN pip install --upgrade pip \
    && pip install --upgrade --no-cache-dir -r /tmp/pip-tmp/requirements.txt \
    && rm -rf /tmp/pip-tmp

USER jovyan

RUN rm -rf ~/.cache/matplotlib/
