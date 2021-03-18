class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :name, presence: true
  validates :content, presence: true

  # accepts_nested_attributes_for :tags

  def tags_attributes=(tags_attributes)
    tags_attributes.values.each {|tag_attributes|
      if tag_attributes[:name].present?
        tag = Tag.find_or_create_by(tag_attributes)
        self.tags << tag
      end
    }
  end
end
