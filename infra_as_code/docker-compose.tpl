version: "3.8"
services:
  
  mongodb:
      container_name: mongo_supspace
      image: mongo:4.4.17-focal
      restart: always
      ports:
        - "27018:27017"
      volumes:
        - ./mongo-data:/data/db
      networks:
        - supspace-network
      environment:
        MONGO_INITDB_ROOT_USERNAME: mongo
        MONGO_INITDB_ROOT_PASSWORD: supspace1
        MONGO_URI: mongodb://mongo:supspace1@localhost:27017/
      # profiles: ["app","dev"]
      logging:
        driver: "json-file"
        options:
          max-file: "5"
          max-size: "10m"
  mongo-express:
      image: mongo-express:0.54.0
      container_name: mongo-express_supspace
      restart: always
      ports:
        - 8081:8081
      networks:
        - supspace-network
      environment:
        # ME_CONFIG_BASICAUTH_USERNAME: "mongo"
        # ME_CONFIG_BASICAUTH_PASSWORD: "supspace1"
        ME_CONFIG_SITE_BASEURL: "/mongodb/"
        ME_CONFIG_MONGODB_URL: "mongodb://mongo:supspace1@mongo:27017/"
        # ME_CONFIG_MONGODB_ENABLE_ADMIN: "true"
        # - ME_CONFIG_MONGODB_ADMINUSERNAME=mongo
        # - ME_CONFIG_MONGODB_ADMINPASSWORD=supspace1
        ME_CONFIG_MONGODB_SERVER: "mongodb"
        ME_CONFIG_MONGODB_ADMINUSERNAME: "mongo"
        ME_CONFIG_MONGODB_ADMINPASSWORD: "supspace1"
      depends_on:
        - mongodb
      # profiles: ["app","dev"]
      logging:
        driver: "json-file"
        options:
          max-file: "5"
          max-size: "10m"
  backend:
      image: hiba25/backend
      container_name: backend_container
      ports:
        - "5000:5000"
      environment:
        DB_URI: "mongodb://mongo:supspace1@mongodb:27017/"
      depends_on:
        - mongo-express
      networks:
        - supspace-network
  modele:
      image: hiba25/modele
      container_name: modele_fruit_container
      ports:
        - "8000:8000"
      environment:
        MODEL_PATH: "/app/model_path/model_final.pth"
        BASE_URL: "http://${ip_address}:8000"
      networks:
        - supspace-network
networks:
  supspace-network:
    driver: bridge
