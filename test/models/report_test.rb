# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    alice_report = reports(:alice)
    alice = users(:alice)
    bob = users(:bob)

    assert alice_report.editable?(alice)
    assert_not alice_report.editable?(bob)
  end

  test 'created_on' do
    alice_report = reports(:alice)
    alice_report.created_at = Time.zone.local(2024, 10, 9, 0, 0, 0)
    assert_equal Date.new(2024, 10, 9), alice_report.created_on
  end

  test 'save_mentions' do
    alice = users(:alice)
    bob_report = reports(:bob)
    carol_report = reports(:carol)

    alice_report = alice.reports.create!(title: 'create_mention', content: <<~TEXT)
      #他人の日報のURLを書くと、その日報に言及したことになる
        "http://localhost:3000/reports/#{bob_report.id}"

      #同じ日報のURLを複数回書いても、その日報は一回しか言及されない
        "http://localhost:3000/reports/#{carol_report.id}"
        "http://localhost:3000/reports/#{carol_report.id}"
    TEXT

    [alice_report, bob_report, carol_report].each(&:reload)
    assert_equal [bob_report, carol_report].sort, alice_report.mentioning_reports.sort
    assert_equal [alice_report], bob_report.mentioned_reports
    assert_equal [alice_report], carol_report.mentioned_reports

    alice_report.update!(title: 'update_mention', content: <<~TEXT)
      #自分が今書いている日報には言及できない
        "http://localhost:3000/reports/#{alice_report.id}"

      #日報のURLを削除してから更新した場合、言及が削除される
        #bob_reportのURLを消した

      #日報が削除された場合も、言及が削除される
        "http://localhost:3000/reports/#{carol_report.id}"
    TEXT

    [alice_report, bob_report, carol_report].each(&:reload)
    assert_equal [carol_report], alice_report.mentioning_reports
    assert_equal [alice_report], carol_report.mentioned_reports
    assert_equal [], alice_report.mentioned_reports
    assert_equal [], bob_report.mentioned_reports

    alice_report.destroy
    assert_equal [], carol_report.reload.mentioned_reports
  end
end
