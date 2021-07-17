require 'rake'

desc 'install the dot files'
task :install do
  replace_all = false
  excluded_files = %w[Rakefile README LICENSE id_rsa.pub id_rsa_office.pub]

  Dir['*'].each do |file|
    next if excluded_files.include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end

  # Handle ssh pubkey on its own
  puts 'Linking the ssh folder, make sure Keybase.io is installed and setup'
  system %Q{ln -s /Volumes/Keybase/private/lantonio/ssh .ssh}

  # Need to do this to make vim use RVM's ruby version
  puts 'Moving zshenv to zshrc'
  system %Q{sudo mv /etc/zshenv /etc/zshrc}

  # mainly needed for vim backups
  puts 'Create .tmp directory'
  system %Q{mkdir $HOME/.tmp 2>/dev/null}

  # install rb
  puts 'Install rb'
  system %Q{sudo curl https://raw.githubusercontent.com/thisredone/rb/master/rb -o /usr/local/bin/rb && sudo chmod +x /usr/local/bin/rb}
end

desc 'install essential homebrew software'
task :install_brew do
  # install homebrew if not installed
  system %Q{/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  # install all the packages listed in the Brewfile
  system %Q{brew bundle}
end

desc 'install essential asdf-vm plugins'
task :install_asdf do
  %w{elixir golang ruby nodejs python terraform helm}.each do |tool|
    system %Q{asdf plugin add #{tool}}
  end
  # will install all the tools listed in ~/.tool-versions
  system %Q{asdf install}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
