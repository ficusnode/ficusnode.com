# ficusnode.com jekyll sources

## Install

Install gem dependencies :

    $ bundle

## Usage

Build the jekyll static site :

    $ bundle exec thor jekyll:build

Run jekyll in development mode (optionnaly run the server to browse the static site at http://0.0.0.0:4000) :

    $ bundle exec thor jekyll:dev [-s|--server]

Deploy the jekyll static site :

    $ bundle exec thor jekyll:deploy

### To-do list

- Make images retina-friendly
- Enable image_optim only during jekyll building for production
- GZIP assets with Jekyll Assets
- GZIP HTML and static files with jekyll
- Compress HTML
- Stop using Compass
- Optimize images before using them as CSS inline data
