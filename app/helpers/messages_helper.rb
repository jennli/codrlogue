module MessagesHelper
  def recipients_options
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}'>#{user.full_name}</option>"
    end
    s.html_safe
  end
end

# module MessagesHelper
#   def recipients_options
#     s = ''
#     User.all.each do |user|
#       s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}'>#{user.name}</option>"
#     end
#     s.html_safe
#   end
# end
