# frozen_string_literal: true

gemfiles = ['Gemfile.core']
gemfiles.each do |gemfile|
  instance_eval File.read(gemfile)
end
gem 'devise', '>= 4.7.1'
gem 'devise-jwt'
gem 'mailgun-ruby', git: 'https://github.com/paiyou-network/mailgun-ruby', branch: :master
gem 'qiniu'
