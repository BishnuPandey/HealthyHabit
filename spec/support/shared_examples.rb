shared_examples 'requires sign_in' do
  before do
    test_host
    sign_out user
    action
  end

  it 'redirects_to new_session_path' do
    expect(response).to redirect_to new_user_session_path
  end
end