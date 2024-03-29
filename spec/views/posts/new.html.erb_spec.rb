require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, build(:post))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do
      assert_select "input[name=?]", "post[title]"
      assert_select "textarea[name=?]", "post[content]"

      # Check for the image file field again
      assert_select "input[name=?]", "post[image]"
    end
  end
end
