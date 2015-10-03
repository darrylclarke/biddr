require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_1)   { create(:user)                 }  
  let(:auction) { create(:auction) }  
  let(:auction_1) { create(:auction) }  
  
  def valid_attributes
    {
      amount: 200
      # ,
      # date_time: Time.now,
      # auction_id: auction_1.id,
      # user_id:  user_1.id  
    }
  end
  def invalid_attributes
    {
      amount: 1
    }
  end
  
  describe "#create" do
    before { auction_1.user = user_1 }
    
    context "with user not signed in" do
      it "redirects to sign in page" do
        post :create, auction_id: auction_1.id, bid: valid_attributes
        expect(response).to redirect_to new_session_path
      end
    end

    context "with user signed in" do
      before { login(user) }

      context "with valid parameters" do

        def valid_request
          post :create, auction_id: auction_1.id, bid: valid_attributes
        end

        it "creates a bid in the database" do
          auction_1.user = user_1
          # auction_1.current_price = 1
          
          expect { valid_request }.to change { Bid.count }.by(1)
        end

        it "redirects to bid show page" do
          valid_request
          expect(response).to redirect_to auction_path( auction_1.id )
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end

        it "associates the created bid with the logged in user" do
          valid_request
          expect(Bid.last.user).to eq(user)
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post :create, auction_id: auction_1.id, bid: invalid_attributes
        end

        it "doesn't create a record in the database" do
          auction_1.user = user_1
          # auction_1.current_price = 1
          expect { invalid_request }.to change { Bid.count }.by(0)
        end

        it "renders the new template" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end
  end
  
  
end
