# Bosch Target Charts
**Target Charts** is a Ruby on Rails web application that allows Bosch to easily manage and visualize their business and production targets. It was created by our team of senior Computer Science majors at the College of Charleston in collaboration with Mr. David Stamps and Mr. Charles Bolin of Bosch Charleston as part of our senior capstone seminar course.

Bosch approached our capstone class at the beginning of the semester and asked a team of students to make an application to replace their current system. Their current system was made with applications familiar to Bosch&mdash;Microsoft Excel and PowerPoint. While these applications are great for general purposes, Bosch needed a more specific solution. We designed and built a Ruby on Rails web application that is accessible from any device, allows multiple users to edit their data at once, and is easy to use.

# Target Charts Video:
[![Target Charts Video](https://img.youtube.com/vi/ShAVnZbSqfY/0.jpg)](https://www.youtube.com/watch?v=ShAVnZbSqfY&feature=youtu.be)

# Technologies
* **Ruby on Rails** (Rails): A powerful web framework that uses Ruby code on the backend and strictly enforces a model-view controller structure. We chose Rails because it's open-source, robust, and allows us to easily install external libraries, called "gems". We used Rails as a full stack framework, meaning the frontend (views) were within the same framework as the backend (controllers and models) rather than have two separate frameworks where we have to build our own API for those to work togeter.
* **Bootstrap**: A popular CSS and Javascipt library that made it easy for our application to look clean and sleek. Bootstrap also made it easy to build a responsive UI.

* **CoffeeScript and jQuery**: CoffeeScript is just simplified Javascript. In fact, there are (online translators)[http://js2.coffee/] to convert JavaScript to CoffeeScript and vice-versa (often CoffeeScript syntax can be simplified further when using an online converter). jQuery is a JavaScript library that makes common JavaScript tasks, such as HTML manipulation, much easier.

* **Haml**: Like CoffeeScript, Haml (HTML abstraction markup language) is simplified and easier to read ERB (Embedded Ruby). ERB is HTML with a few extra tags to embed Ruby code to dynamically generate an HTML page. Haml is based on indentation rather than `<>` and `</>`, meaning that our view code is less cluttered.

* **MySQL**: We store all of our data in a SQL database using MySQL, which is familiar to most web developers. Because we use Rails, it's incredibly easy to manage our database structure. Simply write one or more migration files in Ruby and run a command line command to execute those migrations.

* **RSpec**: A built in testing framework gem. In combination with a few other testing gems, such as (shoulda-matchers)[https://github.com/thoughtbot/shoulda-matchers] and (capybara-webkit)[https://github.com/thoughtbot/capybara-webkit], writing tests is incredibly easy and our tests are readable.

* **GitHub and ZenHub**: We used Git and GitHub for version control and code collaboration. ZenHub was used to track stories, milestones, burndown charts, etc. that integrates nicely with GitHub's issues and milestones.

# Key Features
* **Simplicity**: Target Charts is designed with simplicity and ease-of-use in mind. The UI is clean, spacious, and simple, but still provides all the information needed to get an accurate reflection of how the plant is doing in terms of its goals. One issue Bosch has with their current system is that color blind users have a hard time differentiating between colors. Our application uses a combination of simple colors and informative icons to make sure that doesn’t happen.

* **Excel-like Data Management**: Bosch originally chose to use Excel for data storage because those who worked at the plant were familiar with it. We wanted to make sure our application wouldn't be difficult for those using their current system to learn, so we decided to mimic the controls of Excel in our application. What we came up with allows users to quickly enter data via CoffeeScript popovers and tab between fields. It’s like excel, but simplified for Bosch’s specific needs.

* **Interactive Chart Visualization**: Our charts are visually similar to the charts created by Bosch in PowerPoint for familiarity. Our charts organize targets by category, and for each target you can see the name and the metrics, or stop lights, that tell you how the plant is doing towards meeting that target. Our charts are completely customizable as well. Users can choose from a list of targets and drag and drop the target right onto the chart. If they don’t want to track a target anymore, all they have to do is click the little "x" to remove it.

* **Historical Data Tracking**: Target Charts stores information based on the year, so Bosch can go back and view all of their historical data. In addition, if they need to start a new year, with the click of a button, all of their charts and targets from the current year are automatically copied over for them with the data removed, effectively creating a scaffold for the new year.

* **Responsive UI**: Target Charts is an online web application that can be accessed from a browser on any device. This means that Targets is accessible in the office or on the go from any desktop, laptop, tablet, or phone.

* **Test Coverage**: We wrote over 300 tests for Target Charts. This gives Bosch peace of mind as the application grows and develops in the future.

# About Us
### Developers:
* Sam Word, B.S. Computer Science, College of Charleston
* Kyle Glick, B.S. Computer Science, College of Charleston
* Josh Glass, B.A. Computer Science, College of Charleston
* Omer Omer, B.S. Computer Science, College of Charleston

### Advisors:
* David Stamps, Bosch Charleston (ChP/DBE)
* Charles Bolin, Bosch Charleston (ChP/ICO)
* Dr. Paul Anderson, College of Charleston Capstone Instructor

### Our Development Process
We had nine total sprints. Our sprints were only one week long, with the exception of a couple at the beginning of the project and the last sprint. We chose to do weekly sprints so that we could frequently revisit what needs to be completed. Each developer got a chance to be Scrum Master for approximately three weeks:
1. Josh: Our first Scrum Master. During his time as scrum master we primarily focused on gathering information from Bosch and designing a model for our application.
2. Omer: Our second Scrum Master who focused on pulling out key features of Target Charts and beginning to implement those features.
3. Kyle: Our third Scrum Master. During his time as scrum master we focused almost entirely on developing the application. Most of our application was actually coded during these few weeks.
4. Sam: Our last Scrum Master. Sam's time as Scrum Master was dedicated to finishing key features of the application, fixing minor bugs that persisted, deploying the application, and thoroughly documenting the application to hand over to Bosch. Coding Target Charts was finished around sprints 7 and 8, and all documentation was done by the end of sprint 9.

