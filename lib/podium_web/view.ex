defmodule PodiumWeb.View do
  require EEx
  EEx.function_from_file(:def, :index, "lib/podium_web/templates/index.html.eex", [:assigns])
end
