describe WP::API do
  context "raw HTTP request" do
    let(:response) { HTTParty.get('http://wp.example.com/wp-json/posts').body }
    let(:file) { support_file('posts.json') }
    subject { parse_json(response) }

    it { should eq parse_json(file) }
  end

  context "/wp-json/posts" do

    let(:client) { WP::API['wp.example.com'] }

    subject { client.posts }
    
    it "should have size of 2" do
      expect(subject.size).to eq 2
    end

    it "should have correct IDs" do
      expect(subject.collect(&:id)).to match_array [1, 2]
    end

    it "should have authors" do
      expect(subject.collect(&:author).size).to eq 2
    end

    context "first post" do
      subject do
        client.posts.find {|p| p.id == 1 }
      end
      
      it "should have boolean methods" do
        expect(subject.sticky).to eq true
        expect(subject.sticky?).to eq true
      end

      it("should have a title") { expect(subject.title).to eq "First post" }

      context "author" do
        let(:author) { subject.author }

        it "should be converted to author class" do
          expect(author).to be_a WP::API::Author
        end
      end

      context "meta" do
        let(:meta) { subject.meta }

        it "should not be converted to a class" do
          expect(meta).to be_a Hash
        end
      end

      context "categories" do
        let(:categories) { subject.categories }

        it "should be converted to a class" do
          expect(categories.first).to be_a WP::API::Category
        end

        it "should respond to #to_param" do
          expect(categories.first.to_param).to eq "foxes"
        end
      end

      context "link headers" do
        its(:next) { should == "/wp-json/posts?page=2" }
        its(:prev) { should be_nil }
        its('items.size') { should eq 2 }
      end
    end

  end
end
