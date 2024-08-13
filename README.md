# Resume Page with Google oAuth

This is a resume page, using google authentication for login.

These instructions will get you a copy of the project up and running on your local machine.

## Requirements

We will use Ruby on Rails with SQLite for this project so you should have it locally.

## Installing

Following steps will help you to pull project and use it locally.

### 1 - Prerequisites
```
Ruby installed on your system (we have talked about up there)
Bundler gem installed (gem install bundler)
```


### 2 - Clone the repository: 
```
git clone https://github.com/W0w26/Resume-Page.git
```

### 3 - Bundle install the dependencies: 
* get into directory of project in 

```
cd path_to_project
```
then

```
bundle install
```

### 4 - Create a Google Cloud Platform project and enable the Google OAuth API (optional)
Create the ".env" file. To use the project you have to set your credentials.
```
google_oauth_client_id=your_client_id
google_oauth_client_secret=your_client_secret
GMAIL_USERNAME=your_gmail
GMAIL_PASSWORD=your_app_password
API_KEY=your_api_key
```

### 5 - Create database then run migrations:
```
rails db:create
rails db:migrate
```

### 6 - Start the application:
```
rails s
```

Now you can see project on your browser;
<br><br><br>
Visit localhost:3000

###  Notes:
In order to use Google Business Apis, your account has to be business account.
