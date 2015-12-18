require 'rake/hooks'
require 'fileutils'

before 'db:seed' do
  FileUtils.rm_rf File.join(Rails.root, 'public', 'uploads'), verbose: true
end