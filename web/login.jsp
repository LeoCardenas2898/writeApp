<%--
    Document   : login
    Created on : 06-nov-2018, 23:15:56
    Author     : Cardenas Salas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-app.js"></script>
        <script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-auth.js"></script>
        <script src="js/init.js" type="text/javascript"></script>
        <script src="js/jquery.js" type="text/javascript"></script>
        <title>Login</title>
    </head>
    <body>
        <table align="center">
          <tr align="center">
            <td colspan="2">Email:<br><input type="text" class="txtEmail"></td>
          </tr>
          <tr align="center">
            <td colspan="2">Password:<br><input type="text" class="txtPassword"></td>
          </tr>
          <tr align="center">
            <td colspan="2"><button class="btn-sign-in">Iniciar sesión</button></td>
          </tr>
          <tr align="center">
            <td><button class="btn-google">Google</button></td>
            <td><button class="btn-facebook">Facebook</button></td>
          </tr>
          <tr align="center">
            <td colspan="2"><a href="join.jsp">New in WriteApp? Create a account!</a></td>
          </tr>
          <tr align="center">
            <td colspan="2"><button class="sign-out" hidden></button></td>
          </tr>
        </table>
    </body>
    <script type="text/javascript">
    //Inicio de sesion:
           $(".btn-sign-in").on("click", function () {
              var emailUser = $(".txtEmail").val();
              var passwordUser = $(".txtPassword").val();
              if (emailUser.length < 4) {
                  alert('Please enter an email address.');
                  return;
              } else if (passwordUser.length < 4) {
                  alert('Please enter a password.');
                  return;
              } else {
                  firebase.auth().signInWithEmailAndPassword(emailUser, passwordUser).catch(function (error) {
                      // Handle Errors here.
                      var errorCode = error.code;
                      var errorMessage = error.message;
                      var user = firebase.auth().currentUser;
                      if (errorCode === 'auth/wrong-password') {
                          alert('Wrong password.');
                      } else {
                          alert(errorMessage);
                      }
                      console.log(error);
                  });
                  firebase.auth().onAuthStateChanged(function(user) {
                    if (user) {
                      $(".sign-out").show();
                                  $(".sign-out").text("Sign Out");
                                alert(user.displayName+" with "+user.email);
                    } else {
                      // No user is signed in.
                      alert("No ha iniciado sesión");
                    }
                });
              }
            });
    // Google:
          $(".btn-google").on("click", function(){
            var provider = new firebase.auth.GoogleAuthProvider();
            firebase.auth().useDeviceLanguage();
            firebase.auth().signInWithPopup(provider).then(function(result) {
            // Token para manejar API Google
            var token = result.credential.accessToken;
            // User:
            var user = result.user;
                if(user){
                  $(".sign-out").show();
                  $(".sign-out").text("Sign Out");
                  alert(user.displayName+" with "+user.email);
                }
            }).catch(function(error) {
              // Handle Errors here.
              var errorCode = error.code;
              var errorMessage = error.message;
              // The email of the user's account used.
              var email = error.email;
              // The firebase.auth.AuthCredential type that was used.
              var credential = error.credential;

            });
          });
    //Facebook:
          $(".btn-facebook").on("click", function(){
            var provider = new firebase.auth.FacebookAuthProvider();
            firebase.auth().languageCode = 'en-us';
            firebase.auth().signInWithPopup(provider).then(function(result) {
            // This gives you a Facebook Access Token. You can use it to access the Facebook API.
            var token = result.credential.accessToken;
            // The signed-in user info.
            var user = result.user;
            if(user){
                $(".sign-out").show();
                $(".sign-out").text("Sign Out");
              alert(user.displayName+" with "+user.email);
            }
            // ...
          }).catch(function(error) {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            // The email of the user's account used.
            var email = error.email;
            // The firebase.auth.AuthCredential type that was used.
            var credential = error.credential;
            // ...
            });
          });
      //Cerrar sesión:
      $(".sign-out").on("click", function (){
          firebase.auth().signOut().then(function() {
          // Sign-out successful.
            $(".sign-out").hide();
           }).catch(function(error) {
           // An error happened.
        });
      });
    </script>
</html>
