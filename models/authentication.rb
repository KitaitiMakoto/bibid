class Authentication < ActiveRecord::Base
  NAME_FIELD = {
    'twitter'       => 'nickname',
    'facebook'      => 'nickname'
  }
  DISPLAY_NAME_FIELD = {
    'google_oauth2' => 'name',
    'twitter'       => 'name',
    'facebook'      => 'name'
  }
  belongs_to :user

  class << self
    def name_from(auth_hash)
      auth_hash.info[NAME_FIELD[auth_hash.provider]] ||
        auth_hash.info['email'].scan(/\A[^@]+/).first
    end

    def display_name_from(auth_hash)
      auth_hash.info[DISPLAY_NAME_FIELD[auth_hash.provider]]
    end
  end
end
