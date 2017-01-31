defmodule SheriffExampleApp.UserLaw do
  @behaviour Sheriff.Law

  alias SheriffExampleApp.User

  def permitted?(%User{admin: true}, :index, _) do
    true
  end

  def permitted?(_, _, _) do
    false
  end
end
