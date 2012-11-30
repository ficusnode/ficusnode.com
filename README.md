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
