import std/json
# framework
# import valiant_wallet/crypt/ecdsa
import valiant_wallet/account
import basolato/controller
import ../views/pages/sign/signin_view


proc signin*(context:Context, params:Params):Future[Response] {.async.} =
  # ログインしていたら200
  if context.isLogin().await:
    return render("")

  let message = params.getStr("message")
  let addressStr = params.getStr("address")
  let address = addressStr.Address
  let signature = params.getStr("signature")
  let isValid = verifySignature(address, message, signature)
  if isValid:
    context.login().await
    context.set("address", addressStr).await
    return render("")
  else:
    return render(Http403, "")
  

proc signinPage*(context:Context, params:Params):Future[Response] {.async.} =
  var address = ""
  let isLoggedIn = context.isLogin().await
  if isLoggedIn:
    address = context.get("address").await
    address = address[0..4] & "..." & address[^4..^1]
  return render(signinView(isLoggedIn, address).await)




proc index*(context:Context, params:Params):Future[Response] {.async.} =
  return render("index")

proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  return render("show")

proc create*(context:Context, params:Params):Future[Response] {.async.} =
  return render("create")

proc store*(context:Context, params:Params):Future[Response] {.async.} =
  return render("store")

proc edit*(context:Context, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  return render("edit")

proc update*(context:Context, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  return render("update")

proc destroy*(context:Context, params:Params):Future[Response] {.async.} =
  let id = params.getInt("id")
  return render("destroy")
