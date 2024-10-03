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

  after_save :create_mentioned_reports

  private

  def create_mentioned_reports
    active_report_mentions.destroy_all
    valid_ids = content.scan(%r{http://localhost:3000/reports/(\d+)}).uniq.flatten.map(&:to_i).reject { |id| id == self.id }
    mentioned_reports = Report.where(id: valid_ids)
    mentioned_reports.each { |mentioned_report| active_report_mentions.create(mentioned: mentioned_report) }
  end
end
