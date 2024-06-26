defmodule ReactorAp.HelpTest do
  use ReactorAp.DataCase

  alias ReactorAp.Help

  describe "faqs" do
    alias ReactorAp.Help.Faq

    import ReactorAp.HelpFixtures

    @invalid_attrs %{answer: nil, question: nil, up_votes: nil}

    test "list_faqs/0 returns all faqs" do
      faq = faq_fixture()
      assert Help.list_faqs() == [faq]
    end

    test "get_faq!/1 returns the faq with given id" do
      faq = faq_fixture()
      assert Help.get_faq!(faq.id) == faq
    end

    test "create_faq/1 with valid data creates a faq" do
      valid_attrs = %{answer: "some answer", question: "some question", up_votes: 42}

      assert {:ok, %Faq{} = faq} = Help.create_faq(valid_attrs)
      assert faq.answer == "some answer"
      assert faq.question == "some question"
      assert faq.up_votes == 42
    end

    test "create_faq/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Help.create_faq(@invalid_attrs)
    end

    test "update_faq/2 with valid data updates the faq" do
      faq = faq_fixture()
      update_attrs = %{answer: "some updated answer", question: "some updated question", up_votes: 43}

      assert {:ok, %Faq{} = faq} = Help.update_faq(faq, update_attrs)
      assert faq.answer == "some updated answer"
      assert faq.question == "some updated question"
      assert faq.up_votes == 43
    end

    test "update_faq/2 with invalid data returns error changeset" do
      faq = faq_fixture()
      assert {:error, %Ecto.Changeset{}} = Help.update_faq(faq, @invalid_attrs)
      assert faq == Help.get_faq!(faq.id)
    end

    test "delete_faq/1 deletes the faq" do
      faq = faq_fixture()
      assert {:ok, %Faq{}} = Help.delete_faq(faq)
      assert_raise Ecto.NoResultsError, fn -> Help.get_faq!(faq.id) end
    end

    test "change_faq/1 returns a faq changeset" do
      faq = faq_fixture()
      assert %Ecto.Changeset{} = Help.change_faq(faq)
    end
  end
end
