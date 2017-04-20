FROM tensorflow/tensorflow:latest

RUN pip install Flask==0.12.1 keras==2.0.3 image==1.5.5 h5py==2.7.0

# Launchbot labels
LABEL name.launchbot.io="machine-learning-demystified"
LABEL workdir.launchbot.io="/usr/workdir"
LABEL 8888.port.launchbot.io="Jupyter Notebook"
LABEL 6006.port.launchbot.io="TensorBoard"
LABEL 8080.port.launchbot.io="Flask Server"

# Set the working directory
WORKDIR /usr/workdir

# Expose the notebook port
EXPOSE 8888
EXPOSE 6006
EXPOSE 8080

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Create jovyan user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER $CONDA_DIR

USER $NB_USER

# Start the notebook server
CMD jupyter notebook --no-browser --port 8888 --ip=* --allow-root