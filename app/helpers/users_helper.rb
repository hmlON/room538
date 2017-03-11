module UsersHelper
  def user_photo(user, photo_class:, icon_size: '1x')
    if user.photo_url
      image_tag user.photo_url, class: "rounded-circle #{photo_class}"
    else
      fa_icon "user-circle-o #{icon_size}", title: 'To get a photo you should sign in with VK'
    end
  end
end
