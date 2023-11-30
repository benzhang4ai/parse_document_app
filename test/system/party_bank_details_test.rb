require "application_system_test_case"

class PartyBankDetailsTest < ApplicationSystemTestCase
  setup do
    @party_bank_detail = party_bank_details(:one)
  end

  test "visiting the index" do
    visit party_bank_details_url
    assert_selector "h1", text: "Party bank details"
  end

  test "should create party bank detail" do
    visit party_bank_details_url
    click_on "New party bank detail"

    fill_in "Account name", with: @party_bank_detail.account_name
    fill_in "Account number", with: @party_bank_detail.account_number
    fill_in "Party", with: @party_bank_detail.party_id
    fill_in "Swift code", with: @party_bank_detail.swift_code
    click_on "Create Party bank detail"

    assert_text "Party bank detail was successfully created"
    click_on "Back"
  end

  test "should update Party bank detail" do
    visit party_bank_detail_url(@party_bank_detail)
    click_on "Edit this party bank detail", match: :first

    fill_in "Account name", with: @party_bank_detail.account_name
    fill_in "Account number", with: @party_bank_detail.account_number
    fill_in "Party", with: @party_bank_detail.party_id
    fill_in "Swift code", with: @party_bank_detail.swift_code
    click_on "Update Party bank detail"

    assert_text "Party bank detail was successfully updated"
    click_on "Back"
  end

  test "should destroy Party bank detail" do
    visit party_bank_detail_url(@party_bank_detail)
    click_on "Destroy this party bank detail", match: :first

    assert_text "Party bank detail was successfully destroyed"
  end
end
