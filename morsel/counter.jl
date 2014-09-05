using Morsel

app = Morsel.app()

function handleJS(req, res)
  res.headers["Content-Type"] = "text/javascript"
  path = req.state[:resource]
  path[2:end] |> readall
end
route(app, GET, "/js/jquery-2.1.1.min.js", handleJS)
route(app, GET, "/js/vue.js", handleJS)
route(app, GET, "/js/main.js", handleJS)

function handleHTML(req, res)
  path = req.state[:resource]
  path[2:end] |> readall
end
route(app, GET, "/index.html", handleHTML)

function handleText(req, res)
  res.headers["Content-Type"] = "text/plain"
  path = req.state[:resource]
  path[2:end] |> readall
end
route(app, GET, "/README.md", handleText)

route(app, GET | POST | PUT, "/") do req, res
  req.state[:resource] = "/index.html"
  handleHTML(req, res)
end

function strip_whitespace(str)
  replace(str, r"[\t\0].*$", "")
end

app.state[:value] = 0

route(app, GET, "/counter") do req, res
  res.headers["Content-Type"] = "application/json"
  app.state[:value] |> string
end

route(app, POST, "/counter") do req, res
  res.headers["Content-Type"] = "application/json"
  app.state[:value] = req.state[:data]["value"] |> strip_whitespace |> int
  app.state[:value] |> string
end

route(app, GET, "/up") do req, res
  res.headers["Content-Type"] = "application/json"
  app.state[:value] += 1
  app.state[:value] |> string
end

route(app, POST, "/julia") do req, res
  res.headers["Content-Type"] = "application/json"
  code = req.state[:data]["code"] |> strip_whitespace
  parsed = code |> parse
  eval(parsed) |> string
end

#route(app, GET, "/next/<value::Int>") do req, res
#  req.state[:route_params]["value"]
#end

start(app, 8000)
