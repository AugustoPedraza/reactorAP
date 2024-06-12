# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ReactorAp.Repo.insert!(%ReactorAp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule ReactorAp.SeedData do
  alias ReactorAp.{Accounts, Catalog, Help, Survey}

  def insert_users(count \\ 22) do
    Enum.map(1..count, fn i ->
      attrs = %{
        email: "user#{i}@example.com",
        password: "UserPass#{i}_12#{}"
      }

      {:ok, user} = Accounts.register_user(attrs)

      user.id
    end)
  end

  def insert_products() do
    products = [
      %{
        name: "Chess",
        description: "The classic strategy game",
        sku: 5_678_910,
        unit_price: 10.00
      },
      %{
        name: "Tic-Tac-Toe",
        description: "The game of Xs and Os",
        sku: 11_121_314,
        unit_price: 3.00
      },
      %{
        name: "Table Tennis",
        description: "Bat the ball back and forth. Don't miss!",
        sku: 15_222_324,
        unit_price: 12.00
      },
      %{
        name: "Monopoly",
        description: "Buy, sell, dream, and scheme!",
        sku: 20_333_444,
        unit_price: 25.00
      },
      %{
        name: "Scrabble",
        description: "Word game for the whole family",
        sku: 25_555_666,
        unit_price: 18.00
      },
      %{
        name: "Risk",
        description: "The game of global domination",
        sku: 30_777_888,
        unit_price: 20.00
      },
      %{
        name: "Clue",
        description: "Solve the mystery",
        sku: 35_999_101,
        unit_price: 15.00
      },
      %{
        name: "Catan",
        description: "Trade, build, settle",
        sku: 40_111_213,
        unit_price: 30.00
      },
      %{
        name: "Uno",
        description: "Fast-paced card game",
        sku: 45_314_516,
        unit_price: 6.00
      },
      %{
        name: "Jenga",
        description: "Stack and balance the blocks",
        sku: 50_171_819,
        unit_price: 14.00
      },
      %{
        name: "Pandemic",
        description: "Work together to save humanity",
        sku: 55_202_224,
        unit_price: 28.00
      },
      %{
        name: "Codenames",
        description: "Guess the words with clues",
        sku: 60_225_226,
        unit_price: 15.00
      },
      %{
        name: "Exploding Kittens",
        description: "A card game for people who are into kittens and explosions",
        sku: 65_272_829,
        unit_price: 20.00
      },
      %{
        name: "Ticket to Ride",
        description: "Build your train routes",
        sku: 70_232_425,
        unit_price: 35.00
      },
      %{
        name: "Carcassonne",
        description: "Build the landscape, build your city",
        sku: 75_262_728,
        unit_price: 25.00
      },
      %{
        name: "Dominion",
        description: "A game of medieval deck-building",
        sku: 80_292_031,
        unit_price: 45.00
      },
      %{
        name: "Azul",
        description: "Tile-laying game of beautiful patterns",
        sku: 85_323_334,
        unit_price: 29.00
      },
      %{
        name: "Splendor",
        description: "A game of chips and cards",
        sku: 90_353_636,
        unit_price: 27.00
      },
      %{
        name: "7 Wonders",
        description: "Develop your civilization through ages",
        sku: 95_383_839,
        unit_price: 40.00
      },
      %{
        name: "Patchwork",
        description: "Two-player quilting game",
        sku: 100_404_141,
        unit_price: 22.00
      },
      %{
        name: "King of Tokyo",
        description: "Dice game of monster battles",
        sku: 105_434_343,
        unit_price: 30.00
      },
      %{
        name: "Agricola",
        description: "Farm-building game",
        sku: 110_464_545,
        unit_price: 50.00
      },
      %{
        name: "Gloomhaven",
        description: "Epic game of tactical combat",
        sku: 115_494_747,
        unit_price: 120.00
      },
      %{
        name: "Betrayal at House on the Hill",
        description: "Exploration and horror game",
        sku: 120_525_050,
        unit_price: 35.00
      }
    ]

    Enum.map(products, fn product_attr ->
      {:ok, product} = Catalog.create_product(product_attr)
      product.id
    end)
  end

  def insert_demographics(user_ids) do
    genders = ["female", "male", "other", "prefer not to say"]
    years = 1960..2017

    for uid <- user_ids do
      Survey.create_demographic(%{
        user_id: uid,
        gender: Enum.random(genders),
        year_of_birth: Enum.random(years)
      })
    end
  end

  def insert_ratings(user_ids, product_ids) do
    Enum.flat_map(user_ids, fn uid ->
      insert_ratings_for_user(uid, product_ids)
    end)
  end

  def insert_faqs() do
    faqs = [
      %{
        question: "What is the return policy?",
        answer: "Our return policy allows for returns within 30 days of purchase with a receipt.",
        up_votes: 15
      },
      %{
        question: "How do I track my order?",
        answer:
          "You can track your order by logging into your account and navigating to the 'Orders' section.",
        up_votes: 20
      },
      %{
        question: "Can I change my shipping address after placing an order?",
        answer:
          "Yes, you can change your shipping address within 24 hours of placing the order by contacting our support team.",
        up_votes: 10
      },
      %{
        question: "What payment methods are accepted?",
        answer: "We accept all major credit cards, PayPal, and Apple Pay.",
        up_votes: 25
      },
      %{
        question: "How do I reset my password?",
        answer:
          "You can reset your password by clicking on the 'Forgot Password' link on the login page and following the instructions.",
        up_votes: 30
      }
    ]

    Enum.map(faqs, fn faq ->
      {:ok, faq} = Help.create_faq(faq)

      faq.id
    end)
  end

  defp insert_ratings_for_user(uid, product_ids) do
    stars = 1..5

    Enum.map(product_ids, fn pid ->
      attrs = %{user_id: uid, product_id: pid, stars: Enum.random(stars)}
      {:ok, rating} = Survey.create_rating(attrs)

      rating.id
    end)
  end
end

user_ids = ReactorAp.SeedData.insert_users()
ReactorAp.SeedData.insert_demographics(user_ids)
ReactorAp.SeedData.insert_faqs()

product_ids = ReactorAp.SeedData.insert_products()
ReactorAp.SeedData.insert_ratings(user_ids, product_ids)
