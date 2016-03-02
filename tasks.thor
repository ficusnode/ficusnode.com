class Jekyll < Thor
  BUILD_DIR = "_site/"
  ASSETS_DIR = "_site/assets/"
  REMOTE = "benjamin@grumpy.barreoblique.fr:/srv/www/ficusnode.com/"
  default_task :build

  def self.build_dir
    BUILD_DIR.chomp("/")
  end

  def self.assets_dir
    ASSETS_DIR.chomp("/")
  end

  def self.remote
    REMOTE.chomp("/")
  end

  desc "build", "Build the Jekyll static site"
  def build
    system "rm -rf .asset-cache/" # bug with Sprockets that make jekyll skip assets files during building
    system "bundle exec jekyll clean"
    system "JEKYLL_ENV=production bundle exec jekyll build"
  end

  desc "dev", "Run the jekyll server and continuously regenerates updated files"
  method_option :server, :type => :boolean, :aliases => "-s", :desc => "Optionnaly run the server to browse to http://0.0.0.0:4000"
  def dev
    command = "bundle exec jekyll build --watch"
    command = "bundle exec jekyll serve" if options[:server]
    system command
  end

  desc "deploy", "Build and deploy the jekyll static site"
  def deploy
    require "find"
    invoke :build
    print "Gzipping text-based files... "
    Find.find(Jekyll.build_dir) do |path|
      if FileTest.directory?(path)
        if File.basename(path)[0] == ?.
          Find.prune
        else
          next
        end
      else
        if [".css", ".eot", ".html", ".js", ".otf", ".svg", ".ttf", ".txt"].include?(File.extname(path)) and File.stat(path).size > 200
          system "gzip -c9 #{path} > #{path}.gz"
          system "touch #{path} #{path}.gz"
        end
      end
    end
    puts "done"
    print "Deploying on the remote server..."
    system "rsync --recursive --links --perms --times --compress --delete-after #{Jekyll.build_dir}/ #{Jekyll.remote}/"
    puts "done"
  end
end
