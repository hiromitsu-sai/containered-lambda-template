# https://hub.docker.com/r/amazon/aws-lambda-python
FROM amazon/aws-lambda-python:3.9

COPY . ${LAMBDA_TASK_ROOT}
ENV PYTHONUTF8=1

# installing aws cli
RUN cat /etc/system-release \
    && yum install -y unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && aws --version

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=false
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi"

ENV APP_NAME=${APP_NAME:-{APP_NAME}}
ENV LOGLEVEL=${LOGLEVEL:-DEBUG}
ENV TIMEZONE=${TIMEZONE:-Asia/Tokyo}
ENV IS_DEBUG=${IS_DEBUG:-1}

CMD [ "app.handler" ]