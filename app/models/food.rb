class Food < ApplicationRecord
    # setup relationship b/w food and user 
    belongs_to :user
end
