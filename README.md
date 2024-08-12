# README
To get started with the application, first ensure you have Ruby on Rails(7.1.3.4) and Bundler installed on your system.

Clone the repository from GitHub,
$git clone https://github.com/W0w26/Resume-Page.git

navigate to the project directory,
$cd Desktop/Resume-Page (assuming you cloned the project to desktop)

and run 
$bundle install
to install the required gems.

Set up your Google OAuth credentials by creating `.env` and adding your Google Client ID, Secret, API key, gmail username and app password.
GMAIL_USERNAME=your_gmail
GMAIL_PASSWORD=your_gmail_app_password
google_oauth_client_id=your_project_client_id
google_oauth_client_secret=your_project_client_secret
API_KEY=your_api_key

Migrate the database using
$rails db:migrate

Finally, start the Rails server with `rails s` and open your browser to `http://localhost:3000` to view the application.
