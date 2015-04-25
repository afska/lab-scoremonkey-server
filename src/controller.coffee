module.exports = (request, response) =>
  console.log new Date()
  console.log JSON.stringify request
  console.log "----------"

  end = =>
    response.writeHead 200, { "Content-Type": "text/plain" }
    response.end "ok"

  #---

  end()
