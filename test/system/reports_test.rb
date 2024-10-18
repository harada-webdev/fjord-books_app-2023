# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:alice)

    visit root_path
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'HTMLとCSS'
    fill_in '内容', with: 'HTMLとCSSの本を読みました'
    click_button '登録する'

    assert_text '日報が作成されました。'
    assert_text 'HTMLとCSS'
    assert_text 'HTMLとCSSの本を読みました'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: 'Rails'
    fill_in '内容', with: 'Railsの本を読みました'
    click_button '更新する'

    assert_text '日報が更新されました。'
    assert_text 'Rails'
    assert_text 'Railsの本を読みました'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_button 'この日報を削除'

    assert_text '日報が削除されました。'
    assert_no_text 'Ruby'
    assert_no_text 'Rubyの本を読みました'
  end
end
