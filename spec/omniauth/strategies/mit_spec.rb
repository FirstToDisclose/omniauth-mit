require 'spec_helper'

describe OmniAuth::Strategies::MIT do
  let(:access_token) { stub('AccessToken', :options => {}) }
  let(:parsed_response) { stub('ParsedResponse') }
  let(:response) { stub('Response', :parsed => parsed_response) }

  let(:enterprise_site)          { 'https://some.other.site.com/api/v3' }
  let(:enterprise_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
  let(:enterprise_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
  let(:enterprise) do
    OmniAuth::Strategies::MIT.new('MIT_KEY', 'MIT_SECRET',
        {
            :client_options => {
                :site => enterprise_site,
                :authorize_url => enterprise_authorize_url,
                :token_url => enterprise_token_url
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::MIT.new({})
  end

  before(:each) do
    subject.stub!(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://oidc.mit.edu/manage/dev/dynreg")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq(' https://oidc.mit.edu/authorize')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('https://oidc.mit.edu/token')
    end

  end

  context "#email" do
    it "should return email from raw_info if available" do
      subject.stub!(:raw_info).and_return({'email' => 'you@example.com'})
      subject.email.should eq('you@example.com')
    end

    it "should return nil if there is no raw_info and email access is not allowed" do
      subject.stub!(:raw_info).and_return({})
      subject.email.should be_nil
    end

  end

end
