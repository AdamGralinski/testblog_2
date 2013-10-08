class Comment
  include Mongoid::Document
  field :commenter, type: String
  field :users_vote, type: Array
  field :body, type: String
  field :voteup_count, type: Integer
  field :votedown_count, type: Integer
  field :abusive, type: Boolean, default: false
  field :user_id, type: String
  embedded_in :post
end
