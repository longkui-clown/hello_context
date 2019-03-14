defmodule HelloContextWeb.LayoutView do
  use HelloContextWeb, :view

  def title() do
    Application.get_env(:hello_context, :title, "催泪、小丑--龙奎")  
  end

end
