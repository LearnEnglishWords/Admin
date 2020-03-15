FROM simpleservices/nodejs:12

COPY . /opt/project
WORKDIR /opt/project

RUN npm install

EXPOSE 3000

ENTRYPOINT npm run dev
