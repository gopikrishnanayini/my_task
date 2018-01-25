class Customer < ApplicationRecord
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :email,
             :presence =>true,
             :uniqueness => true,
             :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
             :message => "This field is required." }
end
