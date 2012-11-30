class Jekyll < Thor
  BUILD_DIR = "_site/"
  ASSETS_DIR = "_site/assets/"
  REMOTE = "vm.bearnaise.net:/home/sphax3d/ficusnode.com/"
  default_task :build

  desc "build", "Build the Jekyll static site"
  def build
    system "bundle exec jekyll"
  end

  desc "dev", "Run the jekyll server and continuously regenerates updated files"
  method_option :server, :type => :boolean, :aliases => "-s", :desc => "Optionnaly run the server to browse to http://0.0.0.0:4000"
  def dev
    command = "bundle exec jekyll --auto"
    command += " --server" if options[:server]
    system command
  end

  desc "deploy", "Build and deploy the jekyll static site"
  def deploy
    require "find"
    invoke :build
    print "Gzipping CSS and JS files... "
    Find.find(ASSETS_DIR.chomp('/')) do |path|
      if FileTest.directory?(path)
        if File.basename(path)[0] == ?.
          Find.prune
        else
          next
        end
      else
        if (File.extname(path) == ".css" or File.extname(path) == ".js")
          system "gzip -c9 #{path} > #{path}.gz"
          system "touch #{path} #{path}.gz"
        end
      end
    end
    puts "done"
    print "Deploying on the remote server... "
    # rsync: r = recursive, l = links, p = perms, t = times, z = compress
    system "rsync -rlptz --delete-after #{BUILD_DIR.chomp('/')}/ #{REMOTE.chomp('/')}/"
    puts "done"
  end
end
