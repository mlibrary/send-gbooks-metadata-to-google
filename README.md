# Send Google Books Metadata to Google Drive
This is a script that sends google books metadata to the shared google drive

## To Start development
1. Checkout out the repository
2. Copy `.env-example` to `.env` and fill in `.env` with the appropriate values
3. `docker-compose build`
4. run the script
```
docker-compose run --rm web bundle exec ruby send_to_google your-file.xml.gz
```
The file send has to exist and has to be xml.gz
