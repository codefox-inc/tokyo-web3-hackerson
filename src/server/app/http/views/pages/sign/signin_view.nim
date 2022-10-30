import std/asyncdispatch
import std/json
import basolato/view
import ../../layouts/application_view


proc impl(isLoggedIn:bool, address:string):Future[Component] {.async.} =
  let style = styleTmpl(Css, """
    <style>
      .className {
      }
    </style>
  """)

  tmpli html"""
    $(style)
    <div class="$(style.element("className"))">
      <button onclick="signin()">signin</button>
      $if isLoggedIn{
        <p>you are logged in</p>
      }$else{
        <p>you are <strong>NOT</strong> logged in</p>
      }
      <p id="address">$(address)</p>
    </div>
    <script src="https://cdn.ethers.io/lib/ethers-5.2.umd.min.js" type="application/javascript"></script>
    <script>
      async function signin(){
        if (!window.ethereum) {
          console.error('!window.ethereum')
          return
        }

        const provider = new ethers.providers.Web3Provider(window.ethereum)
        await provider.send('eth_requestAccounts', [])

        const signer = await provider.getSigner()
        const message = 'message'
        const address = await signer.getAddress()
        const signature = await signer.signMessage(message)
        console.log([message, signature])
        const resp = await fetch("http://localhost:8000/api/signin", {
          method: "POST",
          mode: "cors",
          headers:{
            "Content-Type": "application/json"
          },
          body: JSON.stringify({message, address, signature})
        })
        if(resp.status == 200){
          location.reload()
        }
      }
    </script>
  """

proc signinView*(isLoggedIn=false, address=""):Future[string] {.async.} =
  let title = ""
  return $applicationView(title, impl(isLoggedIn, address).await)
