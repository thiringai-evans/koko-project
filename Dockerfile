FROM python:3.9-slim-buster
WORKDIR /flask-rest-api
COPY . .
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]
