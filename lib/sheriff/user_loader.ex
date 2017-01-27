defmodule SheriffExampleApp.UserLoader do
  @behaviour Sheriff.ResourceLoader

  def fetch_resource(_, _) do
    users = SheriffExampleApp.Repo.all(SheriffExampleApp.User)
    {:ok, users}
  end
end
