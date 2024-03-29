class Notification < ApplicationRecord
  belongs_to :sender,   class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :post,     optional: true
  belongs_to :comment,  optional: true
  belongs_to :chat,     optional: true
end
