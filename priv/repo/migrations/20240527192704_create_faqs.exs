defmodule ReactorAp.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :string
      add :answer, :string
      add :up_votes, :integer

      timestamps()
    end
  end
end
