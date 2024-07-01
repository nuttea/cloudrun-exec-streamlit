FROM python:3.10 as base

RUN pip install poetry==1.8.1
RUN poetry config virtualenvs.create false

WORKDIR /app

# to cache dependencies
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev

COPY . ./

#######################################
FROM base as production

RUN set -e; \
    apt-get update -y && apt-get upgrade -y && apt-get install -y \
    apt-transport-https ca-certificates gnupg curl \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get install -y google-cloud-cli postgresql-client netcat-traditional \
    && apt-get -y autoremove && apt-get clean && pip install --upgrade pip

# to install own project
RUN poetry install --no-dev

EXPOSE 8080
CMD ["streamlit", "run", "Main.py", "--server.port=8080", "--theme.base=dark", "--theme.primaryColor=#4bbdff"]