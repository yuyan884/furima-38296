FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    # Internet.passwordだと数字を含まない場合があるため、Lorem.charactersを使用する
    #password              {Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false)}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 4, min_numeric: 1)}
    password_confirmation {password}

    Faker::Config.locale = 'ja'
    last_name             {Faker::Name.last_name}
    first_name            {Faker::Name.first_name}
    last_name_kana        {"ミョウジ"}
    first_name_kana       {"ナマエ"}

    birthday              {Faker::Date.between(from: '1930-01-01', to: "#{Time.now.year-5}-12-31")}
  end
end
