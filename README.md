**README**

Photo management application with simple "tweet" function. The system would require following features:

* Show this page if we access to the top page.
* We can login with user ID and password.
    * You don't need to develop the user registration function.
    * You can make users by inserting the record to DB or so.
        * These are manage with your system.
* Move to the pictures list page after login.
* In below cases, the system shows the error messages and the cause of failure.
    * The users didn't input the user ID.
    * The users didn't input the password.
    * There are no users matched with input user ID and password.
    
Picture index 
* Show the pictures uploaded by login user.
* The pictures are ordered by the uploaded date.
* Show the 'Title of picture' and the picture.
* There are no pictures in this page if this is first login.
* Has the link to 'Picture upload page' and 'Logout page'.
* If users access to this page before login, the system show the login page.

Picture upload
* Users can upload the images with 'Title of picture' and picture file.
* The system shows error message in the below case.
    * The users didn't input 'Title of picture' and/or picture file.
    * The character count of 'Title of picture' is larger than 30.
* Show 'Pictures list' if picture upload function ends successfully.
    * The users can find the last updated picture on the top of picture list.
* Show the link of 'Pictures list'.
    * If the user clicks this link, the upload will be canceled.
* Show the link of 'Logout'.
* If users access to this page before login, the system show the login page.

Logout
* The user status will be move to non login status.
* After login the system shows login page.

OAuth authorization
* Show the link moving to the OAuth authorization page in the pictures list page.
* If users click this link, the system shows the OAuth authorization page.
* It is the flow of (A) of RFC6749.

Get the access token of OAuth
* Not to be error when requests are redirected to 'GET http://localhost:3000/oauth/callback'.
* In this process the system get the access token using authorization code that set to URL. After that, system memorize it to session.
* Redirect the request to the photos list page after getting access token.
* You don't need handle in case of 'Not authorise' button was pressed.

Post the tweet to the linked application
* If the access token of the linkage application was memorized in session, show the 'tweet' button under each pictures.
* Post the tweet with below information when users press the 'tweet' button.
    * Title of picture
    * URL that was written at img tag src attribute.
        * Its domain is 'localhost' and port number is 3000.
* After completed to tweet, the system redirect the request to the photos list page.


**System dependencies**
* Ruby ruby-2.6.3 (on Rails 5.1.6)

**Getting started**
* Run <tt>dock build</tt> and <tt>dock run</tt> to build and start Docker
* Access application at http://localhost:3000
* Access docker by running <tt>dock bash</tt> and run tests <tt>rails test RAILS_ENV=test</tt>

**Docker**
* <tt>dock build</tt> (Re)builds the docker image
* <tt>dock run</tt> Runs the docker
* <tt>dock bash</tt> Opens bash inside the docker
* <tt>dock clean</tt> Deletes all unused docker data

**Other**
* Clean cache and temporary files: <tt>rails tmp:cache:clear</tt>
