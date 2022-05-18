require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:Post_1)
    @user = users(:User_1)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should not get new" do
    get new_post_url
    assert_response :redirect
  end

  # test "should create post" do
  #   assert_difference('Post.count') do
  #     post posts_url, params: { post: { body: @post.body, title: @post.title, user: @user } }
  #   end

  #   assert_redirected_to post_url(Post.last)
  # end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should not get edit" do
    get edit_post_url(@post)
    assert_redirected_to '/'
  end

  test "should not update post" do
    patch post_url(@post), params: { post: { body: @post.body, title: @post.title, user: @user } }
    assert_redirected_to '/'
  end

  test "should destroy post" do
    assert_difference('Post.count', 0) do
      delete post_url(@post)
    end

    assert_redirected_to '/'
  end
end
