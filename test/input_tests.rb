require 'net/http'

def login(user, pass)
  puts "user=#{user} pass=#{pass}"
  url = "http://localhost:3000/api/v1/sfu/auth"
  params = {"username" =>  user, "password" => pass}
  resp = Net::HTTP.post_form(URI.parse(url), params)
  puts resp.body
end

login("user40@canvas.dev", "\\5QqqA9pswqqQ7q")
login("user40alias@canvas.dev", "password")
login("patchin@sfu.ca", "password")

# the following will fail in rails through a timeout
#u = "user40@canvas.dev"
#p = "x" * (1024 * 1000000)
#login(u, p)

# Tested the following passwords.
# Note: the slash has to be escaped with another slash before posting.
#user31 $9A9\fE4|?{74M user31@canvas.dev
#user32 'k]325{6.K~}T user32@canvas.dev
#user33 437Z4qTb2eQ2{9a
#user34 %>84=(!ye2ndpCQ
#user35 96jr5]h5a4XS/J
#user36 $_U.s+{xE9{|ta
#user37 #&7?!m2K~&8a2M
#user38 }u6aE6F8_SCR4&r
#user39 Z^k(A]|  H662K
#user40 \5QqqA9pswqqQ7q

