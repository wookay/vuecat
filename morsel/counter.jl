using Morsel

app = Morsel.app()

function handleJS(req, res)
  res.headers["Content-Type"] = "text/javascript"
  path = req.state[:resource]
  readall(path[2:end])
end
route(app, GET, "/js/jquery-2.1.1.min.js", handleJS)
route(app, GET, "/js/vue.js", handleJS)
route(app, GET, "/js/main.js", handleJS)

function handleHTML(req, res)
  path = req.state[:resource]
  readall(path[2:end])
end
route(app, GET, "/index.html", handleHTML)

function handleText(req, res)
  res.headers["Content-Type"] = "text/plain"
  path = req.state[:resource]
  readall(path[2:end])
end
route(app, GET, "/README.md", handleText)

route(app, GET | POST | PUT, "/") do req, res
  req.state[:resource] = "/index.html"
  handleHTML(req, res)
end

route(app, GET, "/next/<id::Int>") do req, res
  res.headers["Content-Type"] = "application/json"
  ret = string(req.state[:route_params]["id"] + 1)
  println(ret)
  ret
end

start(app, 8000)
