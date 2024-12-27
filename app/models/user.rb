class User < ApplicationRecord
    # 申請状態関係
    has_many :sent_requests, class_name: "Request", foreign_key: "sender_id", dependent: :destroy
    has_many :received_requests, class_name: "Request", foreign_key: "receiver_id", dependent: :destroy

    # 恋人関係
    has_one :relationship, foreign_key: "user_id", dependent: :destroy
    has_one :partner, through: :relationship, source: :partner

    # プロフィール画像
    has_one_attached :profile_image

    # 登録状態を管理
    #   pending：仮登録
    #   active ：本登録
    enum status: { pending: "pending", active: "active" }
end
