class Scraping < ApplicationRecord
  def self.seed_categories
    agent = Mechanize.new
    page = agent.get("https://www.mercari.com/jp/category/")

    upper_categories = page.search('.category-root-category-link-name div')
    upper_categories.each.with_index do |upper_category, i|
      new_upper_category = UpperCategory.create(name: upper_category.text)

      middle_categories = page.search('.category-list-individual-box-inner-box')[i].search('h4')
      middle_categories.each.with_index do |middle_category, j|
        case middle_category.text.gsub(" ", "")
        when "トップス", "アウター", "ジャケット/アウター", "パンツ", "スカート", "ワンピース", "ルームウェア/パジャマ", "スーツ/フォーマル/ドレス", "スーツ", "マタニティ", "水着", "浴衣/水着"
          size_type = 1
        when "靴"
          size_type = 2
        when "ベビー服(女の子用)~95cm", "ベビー服(男の子用)~95cm", "ベビー服(男女兼用)~95cm", "キッズ服(女の子用)100cm~", "キッズ服(男の子用)100cm~", "キッズ服(男女兼用)100cm~"
          size_type = 3
        when "キッズ靴"
          size_type = 4
        else
          size_type = 0
        end
        unless middle_category.text == "すべて"
          new_middle_category = MiddleCategory.create(name: middle_category.text, upper_category_id: new_upper_category.id, size_type_id: size_type)
        end

        lower_categories = page.search('.category-list-individual-box-inner-box')[i].search('.category-list-individual-box-sub-sub-category-box')[j].search('a')
        lower_categories.each do |lower_category|
          unless lower_category.text.gsub(" ", "").gsub("\n", "") == "すべて"
            new_lower_category = LowerCategory.create(name: lower_category.text.gsub(" ", "").gsub("\n", ""), middle_category_id: new_middle_category.id)
          end
        end
      end
    end
  end

  def self.seed_brands
    agent = Mechanize.new
    page = agent.get("https://www.mercari.com/jp/brand/")

    # add the mothod to create brand_groups
    groups = page.search('.brand-group-link-box a')
    groups.each do |group|
      new_group = Group.create(name: group.text.gsub(" ", "").gsub("\n", ""))
    end

    urls = page.search('.brand-group-link-box a')
    urls.each.with_index do |url, i|
      agent = Mechanize.new
      page = agent.get("https://www.mercari.com#{url.attr('href')}")
      initial_words = page.search('.brand-initial-link-box-initial a')
      initial_words.each do |initial_word|
        brands = page.search("#initial-#{initial_word.text} p")
        brands.each do |brand|
          if Brand.find_by(name: brand.text) == nil
            new_brand = Brand.create(name: brand.text, initial_word: initial_word.text)
          else
            new_brand = Brand.find_by(name: brand.text)
          end
          BrandGroup.create(brand_id: new_brand.id, group_id: i+1)
        end
      end
    end
  end
end
