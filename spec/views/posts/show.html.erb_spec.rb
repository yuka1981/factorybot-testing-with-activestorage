require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  include Rails.application.routes.url_helpers

  before(:each) do
    @post = assign(:post, create(:post))
  end

  it "renders attributes in <p>" do
    render
    # expect(rendered).to match(@post.title)
    # expect(rendered).to match(@post.content)
    expect(rendered).to match(/#{Regexp.escape(@post[:title])}/)
    expect(rendered).to match(/#{Regexp.escape(@post[:content])}/)
  end

  it "redner the post image" do
    render
    assert_select "img[src=?]", rails_blob_path(@post.image, only_path: true), count: 1
  end
end
