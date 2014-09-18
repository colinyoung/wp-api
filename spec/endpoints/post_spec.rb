describe WP::API do
  context "raw HTTP request" do
    let(:response) { HTTParty.get('http://wp.example.com/wp-json/posts/1').body }
    let(:file) { support_file('posts/1.json') }
    subject { parse_json(response) }

    it { should eq parse_json(file) }
  end

  context "/wp-json/post/:post" do

    let(:client) { WP::API['wp.example.com'] }

    subject { client.post(1) }
    
    it "should be a post" do
      expect(subject).to be_a WP::API::Post
    end

    it "should have an attributes hash" do
      expect(subject.attributes).to be_a Hash
    end

    it "should have a headers hash" do
      expect(subject.headers).to be_a Hash
    end

    it "should have correct IDs" do
      expect(subject.id).to eq 1
    end

    it "should have correct author" do
      expect(subject.author.id).to eq 2
    end
  end

end
