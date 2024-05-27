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

alias ReactorAp.{Accounts, Catalog, Help}

users = [
  %{
    email: "pj1@example.com",
    password: "player1_asd123"
  },
  %{
    email: "admin@example.com",
    password: "admin_asd123"
  }
]

Enum.map(users, fn user ->
  {:ok, user} = Accounts.register_user(user)

  user
end)

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
    description: "Bat the ball back and forth, don't miss!",
    sku: 15_222_324,
    unit_price: 12.00
  }
]

Enum.each(products, fn product ->
  Catalog.create_product(product)
end)

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

Enum.each(faqs, fn faq ->
  Help.create_faq(faq)
end)
