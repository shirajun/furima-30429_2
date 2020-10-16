require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '出品物の保存' do
    describe '#create' do
      before do
        @item = FactoryBot.build(:item)
      end
      context '保存がうまくいく時' do
        it 'すべての値が正しく入力されていれば保存される' do
          expect(@item).to be_valid
        end
      end

      context '保存がうまくいかない時' do
        it 'imageが空では保存できないこと' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end

        it 'nameが空では保存できないこと' do
          @item.name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it 'textが空では保存できないこと' do
          @item.text = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Text can't be blank")
        end

        it 'categoryが未選択では保存できないこと' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Category Select')
        end

        it 'conditionが未選択では保存できないこと' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Condition Select')
        end

        it 'shippingformatが未選択では保存できないこと' do
          @item.shipping_format_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Shipping format Select')
        end

        it 'prefectureが未選択では保存できないこと' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Prefecture Select')
        end

        it 'dayが未選択では保存できないこと' do
          @item.day_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Day Select')
        end

        it 'priceが空では保存できないこと' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end

        it 'priceが10,000,000円以上だと保存できないこと' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Out of setting range')
        end

        it 'priceが299円以下だと保存できないこと' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('Price Out of setting range')
        end

        it 'priceが半角数字でないと保存できないこと' do
          @item.price = '２０００'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price half-width characters.')
        end
      end
    end
  end
end
