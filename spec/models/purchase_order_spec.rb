require 'rails_helper'

RSpec.describe PurchaseOrder, type: :model do
  describe '購入記録の保存' do
    before do
      @purchase_order = FactoryBot.build(:purchase_order)
    end
    context '保存できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_order).to be_valid
      end
      it 'building_nameはなくても保存できること' do
        @purchase_order.building_name = nil
        expect(@purchase_order).to be_valid
      end
    end
    context '保存できないとき' do
      it 'postal_codeが空では保存できない' do
        @purchase_order.postal_code = nil
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Postal code can't be blank", "Postal code code Input correctly")
      end
      it 'postal_codeのハイフンがないと保存できない' do
        @purchase_order.postal_code = '1234567'
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Postal code code Input correctly")
      end
      it 'prefecture_idが未選択だと保存できない' do
        @purchase_order.prefecture_id = 1
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Prefecture Select")
      end
      it 'municipalityが空だと保存できない' do
        @purchase_order.municipality = nil
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空だと保存できない' do
        @purchase_order.address = nil
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが12桁だと保存できない' do
        @purchase_order.phone_number = nil
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'tokenが空だと保存できない' do
        @purchase_order.token = nil
        @purchase_order.valid?
        expect(@purchase_order.errors.full_messages).to include()
      end
    end
  end
end
