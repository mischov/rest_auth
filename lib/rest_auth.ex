defmodule RestAuth do
  @moduledoc """
  `RestAuth` is a declarative ACL library for Phoenix. It functions by declaring a
  controller level plug with a set of roles specified for the given action. It also
  provides a framework for doing per-item-ACL with ETS backed caching built in.

  To set up and use `RestAuth` you need to specify some configuration for sane
  defaults. All the configuration is provided using a plug:

     plug RestAuth.Configure, handler: MyHandler

  The only option accepted right now is the `:handler` module that implements
  the `RestAuth.Handler` behaviour. An example handler is provided in the
  `examples/dummy_handler.ex` file.

  You also need to set up an authentication controller of sorts that calls
  `RestAuth.Controller.login/3` and `RestAuth.Controller.logout/3` functions

  A typical sample usage in a controller looks like so (pulled from `Restauth.Restrict` documentation):

      @rest_auth_roles  [
        {:index, ["user"]},
        {:create, ["admin"]},
        {:update, ["admin"]},
        {:show, ["admin"]},
        {:delete, ["admin"]}
      ]
      plug RestAuth.Restrict, @rest_auth_roles

  The handler module provided by the user takes full responsibility for loading
  user data from the database and caching the data using `RestAuth.CacheService`
  if caching is required.

  This library aims to be a slightly oppinionated framework for you to build your
  own logic on top of. After having implemented the behaviour `RestAuth` should
  rarely get in the way of anyhting.
  """
  use Application

  @doc false
  def start(_type, _args) do
    RestAuth.Supervisor.start_link
  end
end
