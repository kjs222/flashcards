### CodePoints

CodePoints is a productivity app aimed at new programmers.  It helps new learners set learning goals, track learning activities, see historical practice information, follow other users, and maximize the use of the Quizlet flashcard program to learn programming skills.

See blog posts [here](https://www.turing.io/blog/2016/08/30/where-begin-solve-problem-you-know-well) and [here](https://medium.com/@KerrySheldon/customized-activity-feeds-in-rails-c6009f54c68b#.qlw033uci) for more information on the app.  

Codepoints app uses Ruby on Rails as a web app framework, the JavaScript libraries ChartJS and jQuery, and Bootstrap for UI. The app uses Quizlet's API and serves up it's own API to respond to AJAX requests as well as the companion CLI application.   The Public Activity gem is used to create customized feeds comprised of activity for the user's community.  

The testing suite uses RSpec, Capybara, and Selenium. 

To run locally:
```
git clone git@github.com:kjs222/flashcards.git
cd flashcards
bundle
rake db:create
rake db:migrate
rails s
```

Visit in Production: [CodePoints](https://codepoints.herokuapp.com/)

For the Command Line App:
[CodePoints Command Line App](https://github.com/kjs222/cli_flash)
