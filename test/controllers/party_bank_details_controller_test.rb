require "test_helper"

class PartyBankDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @party_bank_detail = party_bank_details(:one)
  end

  test "should get index" do
    get party_bank_details_url
    assert_response :success
  end

  test "should get new" do
    get new_party_bank_detail_url
    assert_response :success
  end

  test "should create party_bank_detail" do
    assert_difference("PartyBankDetail.count") do
      post party_bank_details_url, params: { party_bank_detail: { account_name: @party_bank_detail.account_name, account_number: @party_bank_detail.account_number, party_id: @party_bank_detail.party_id, swift_code: @party_bank_detail.swift_code } }
    end

    assert_redirected_to party_bank_detail_url(PartyBankDetail.last)
  end

  test "should show party_bank_detail" do
    get party_bank_detail_url(@party_bank_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_party_bank_detail_url(@party_bank_detail)
    assert_response :success
  end

  test "should update party_bank_detail" do
    patch party_bank_detail_url(@party_bank_detail), params: { party_bank_detail: { account_name: @party_bank_detail.account_name, account_number: @party_bank_detail.account_number, party_id: @party_bank_detail.party_id, swift_code: @party_bank_detail.swift_code } }
    assert_redirected_to party_bank_detail_url(@party_bank_detail)
  end

  test "should destroy party_bank_detail" do
    assert_difference("PartyBankDetail.count", -1) do
      delete party_bank_detail_url(@party_bank_detail)
    end

    assert_redirected_to party_bank_details_url
  end
end
