name "rubygems"
dependencies ["ruby"]

source :url => "http://production.cf.rubygems.org/rubygems/rubygems-1.8.12.tgz",
       :md5 => "5948bdea82a6ab1cc9059d5b280dd836"

relative_path "rubygems-1.8.12"

build do
  command "/opt/opscode/embedded/bin/ruby setup.rb"
end