require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  # use rails_blob_path, needs includ url_helpers
  include Rails.application.routes.url_helpers

  before(:each) do
    @posts = assign(:posts, [create(:post), create(:post)])
  end

  it "renders a list of posts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    # Contain the post title
    assert_select cell_selector, text: Regexp.new(@posts[0].title.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(@posts[1].title.to_s), count: 1

    # Contains the post content
    assert_select cell_selector, text: Regexp.new(@posts[0].content.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(@posts[1].content.to_s), count: 1

    # Test for the image
    assert_select "img[src=?]", rails_blob_path(@posts[0].image, only_path: true), count: 1
    assert_select "img[src=?]", rails_blob_path(@posts[1].image, only_path: true), count: 1
  end

  it "renders a logout button when signed in" do
    sign_in create(:user)
    render
    assert_select "a[href=?]", destroy_user_session_path, count: 1
  end
end
