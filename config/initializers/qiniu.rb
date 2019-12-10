# frozen_string_literal: true

if ENV['QINIU_ENABLED'] == 'yes'
  require 'qiniu'
  Qiniu.establish_connection! access_key: ENV['QINIU_ACCESS_KEY'], secret_key: ENV['QINIU_SECRET_KEY']

  ApplicationController.class_eval do
    def qiniu_token
      put_policy = Qiniu::Auth::PutPolicy.new(ENV['QINIU_BUCKET'])
      token = Qiniu::Auth.generate_uptoken(put_policy)

      render json: {
        ok: true,
        qiniuToken: token,
        qiniuHost: ENV['QINIU_HOST']
      }
    end
  end

  module QiniuRoutes
    def self.extended(router)
      router.instance_exec do
        match 'qiniu_token' => 'application#qiniu_token', via: :get
      end
    end
  end
end
