# README

About:
CodePoints is a deliberate practice goal setting and tracking app aimed and new programmers.  It helps you set learning goals, track progress, see what others are doing, and maximize the use of the Quizlet flashcard program.

This app uses Ruby on Rails as a web app framework, the JavaScript libraries ChartJS and jQuery, and Bootstrap for UI. Data is collected from the Quizlet API.  Through an internal API, and related command line application can interact with this program and with Quizlet.

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

Download the Command Line App:
[CodePoints Command Line App](https://github.com/kjs222/cli_flash)
