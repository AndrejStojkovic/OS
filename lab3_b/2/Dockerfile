
FROM eclipse-temurin:25-alpine

WORKDIR /src

COPY CatalogViewer.java .

RUN javac CatalogViewer.java

ENV PRODUCT_FILE_PATH=/srv/catalog/products.txt

CMD [ "java", "CatalogViewer" ]