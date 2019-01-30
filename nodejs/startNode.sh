#! /bin/bash


  PGUSER=postgres \
  PGPASSWORD=docker \
  PGDATABASE=postgres \
  PGPORT=5432 \
  node index.js
