defmodule SheriffExampleApp.UserLoader do
  @behaviour Sheriff.ResourceLoader

  def fetch_resource(_, _) do
    a = SheriffExampleApp.Repo.all(SheriffExampleApp.User)
    {:ok, a}
  end
end
