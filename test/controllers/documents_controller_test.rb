# frozen_string_literal: true

require "test_helper"

# Test to assure documents can be modified and downloaded.
class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:general)
    @folder = folders(:mops)
    @document = documents(:one)
    @editor = users(:editor)
    @viewer = users(:viewer)
  end

  def document_params
    {
      featured: "1"
    }
  end

  # test "should get index" do
  #   get documents_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_document_url
  #   assert_response :success
  # end

  # test "should create document" do
  #   assert_difference("Document.count") do
  #     post documents_url, params: { document: document_params }
  #   end
  #   assert_redirected_to document_url(Document.last)
  # end

  # test "should show document" do
  #   get document_url(@document)
  #   assert_response :success
  # end

  test "should get edit as editor" do
    login(@editor)
    get edit_document_url(@document)
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer)
    get edit_document_url(@document)
    assert_redirected_to dashboard_url
  end

  test "should update document as editor" do
    login(@editor)
    patch document_url(@document), params: { document: document_params }
    assert_redirected_to category_folder_url(@category, @folder)
  end

  test "should not update document as viewer" do
    login(@viewer)
    patch document_url(@document), params: { document: document_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy document as editor" do
    login(@editor)
    assert_difference("Document.count", -1) do
      delete document_url(@document)
    end
    assert_redirected_to category_folder_url(@category, @folder)
  end

  test "should not destroy document as viewer" do
    login(@viewer)
    assert_difference("Document.count", 0) do
      delete document_url(@document)
    end
    assert_redirected_to dashboard_url
  end
end
