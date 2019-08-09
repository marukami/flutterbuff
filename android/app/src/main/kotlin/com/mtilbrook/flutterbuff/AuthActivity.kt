package com.mtilbrook.flutterbuff

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Toast
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.mtilbrook.app.UserOuterClass
import kotlinx.android.synthetic.main.activity_auth.*

class AuthActivity : Activity(), View.OnClickListener {
  private lateinit var auth: FirebaseAuth

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_auth)
    auth = FirebaseAuth.getInstance()

    // Buttons
    emailSignInButton.setOnClickListener(this)
    emailCreateAccountButton.setOnClickListener(this)
    signOutButton.setOnClickListener(this)
  }

  public override fun onStart() {
    super.onStart()
    // Check if user is signed in (non-null) and update UI accordingly.
    val currentUser = auth.currentUser
    updateUI(currentUser)
  }

  private fun createAccount(email: String, password: String) {

    auth.createUserWithEmailAndPassword(email, password)
        .addOnCompleteListener(this) { task ->
          if (task.isSuccessful) {
            // Sign in success, update UI with the signed-in user's information
            Log.d(TAG, "createUserWithEmail:success")
            val user = auth.currentUser
            updateUI(user)
            newUserSession(user)
          } else {
            // If sign in fails, display a message to the user.
            Log.w(TAG, "createUserWithEmail:failure", task.exception)
            Toast.makeText(
                baseContext, "Authentication failed.",
                Toast.LENGTH_SHORT).show()
            updateUI(null)
          }
        }
  }

  private fun signIn(email: String, password: String) {
    Log.d(TAG, "signIn:$email")

    auth.signInWithEmailAndPassword(email, password)
        .addOnCompleteListener(this) { task ->
          if (task.isSuccessful) {
            // Sign in success, update UI with the signed-in user's information
            Log.d(TAG, "signInWithEmail:success")
            val user = auth.currentUser
            updateUI(user)
            newUserSession(user)
          } else {
            // If sign in fails, display a message to the user.
            Log.w(TAG, "signInWithEmail:failure", task.exception)
            Toast.makeText(baseContext, "Authentication failed.",
                Toast.LENGTH_SHORT).show()
            updateUI(null)
          }

          if (!task.isSuccessful) {
            status.text = "auth failed"
          }
        }
  }

  private fun signOut() {
    auth.signOut()
    updateUI(null)
  }

  private fun newUserSession(user: FirebaseUser?) {
    user ?: return
    val protoUser = firebaseUserToProtoUser(user)

    val data = protoUser.toByteArray()
    setResult(
        RESULT_OK,
        Intent().apply { putExtra(RES_KEY_USER, data) }
    )

    finish()
  }

  private fun updateUI(user: FirebaseUser?) {
    if (user != null) {
      status.text = "email: ${user.email}  isEmailVerified: ${user.isEmailVerified}"
      detail.text = "UID: ${user.uid}"

      emailPasswordButtons.visibility = View.GONE
      emailPasswordFields.visibility = View.GONE
      signedInButtons.visibility = View.VISIBLE

    } else {
      status.text = "Signed Out"
      detail.text = null

      emailPasswordButtons.visibility = View.VISIBLE
      emailPasswordFields.visibility = View.VISIBLE
      signedInButtons.visibility = View.GONE
    }
  }


  override fun onClick(v: View) {
    when (v.id) {
      R.id.emailCreateAccountButton -> createAccount(fieldEmail.text.toString(), fieldPassword.text.toString())
      R.id.emailSignInButton -> signIn(fieldEmail.text.toString(), fieldPassword.text.toString())
      R.id.signOutButton -> signOut()
    }
  }

  companion object {
    const val REQ_CODE = 10
    const val RES_KEY_USER = "auth:user"
  }
}

fun firebaseUserToProtoUser(firebaseUser: FirebaseUser) =
    UserOuterClass
        .User
        .newBuilder()
        .apply {
          uid = firebaseUser.uid
          providerId = firebaseUser.providerId
          displayName = firebaseUser.displayName ?: firebaseUser.email ?: ""
          email = firebaseUser.email ?: ""
          isEmailVerified = firebaseUser.isEmailVerified
        }
        .build()

const val TAG = "AuthActivity"
