defmodule SheriffExampleApp.UserLaw do
  @behaviour Sheriff.Law

  def permitted?(_, _, _) do
    true
  end
end
