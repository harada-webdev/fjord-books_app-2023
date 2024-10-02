# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_report_mentions, class_name: 'ReportMention', foreign_key: 'mentioning_id', inverse_of: :mentioning, dependent: :destroy
  has_many :passive_report_mentions, class_name: 'ReportMention', foreign_key: 'mentioned_id', inverse_of: :mentioned, dependent: :destroy

  has_many :mentioning_reports, through: :active_report_mentions, source: :mentioned
  has_many :mentioned_reports, through: :passive_report_mentions, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
end
