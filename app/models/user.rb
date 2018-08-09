class User < ApplicationRecord
  has_many :todos
  has_many :storedfiles

  def password_confirm=(pass)
  end
  def password_confirm
  end
  def is_admin?
    return administrator
  end
  
  MFA_BACKEND = 'http://mfa:8080'

  def send_challenge
    begin 
      resp = HTTParty.get("#{MFA_BACKEND}/generate_code?number=#{self.phonenumber}")
      session =  resp.headers['Set-Cookie']
      File.open('session','w').write(session)
      return session
    rescue Error => e
      File.open('error','w').write(e)
    end 
  end
  
  def verify(session, code)
    begin
      resp =  HTTParty.get("#{MFA_BACKEND}/verify_code/#{code}", headers: { 'Cookie' => "mfa_auth=#{session}" })
      return resp.code == 200
    rescue
      # Fails open
      return true
    end
  end 

end
