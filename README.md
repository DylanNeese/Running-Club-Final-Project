Database Summary Report

Describing the Organization 

My Organization is called The Greenwood Roade Runners and they are a racing club based in Greenwood, Indiana. They were founded in 2019 and the club currently has 60 active members which range from ages 23 to 60. As of right now the club participates in 20-25 organized races per year. Two of which we host which are the Turkey Trot 5k and the Spring Classic Half Marathon. The President of the club, race director,Membership coordinators, and volunteer timers will handle all the planning, registration and keeping the records in the database. 
Our mission as an organization is to promote Health and pushing yourself 1% better everyday. Our Modo is Go One More, which incourages everyone to push past their limits to sucseed. We are inclusive so anyone, any age can join. We still celebrate competetive success through different age groups and club records. This database can give you the average 5k time for runners in their 30's or even top 10 5k times. while also looking back at ones history in races and seeing how much they have improved. 

Users Perspective

From a Users point of view, this database is a single source for everything related to the Club, whether racing or registration. Members and staff can pull up an alphabetical member dirrectory instantly and see every race that has been completed. This will have everything the club has entered including dates, locations, and distances. Also including ones indivitual time, overall place and age group. In one of my quiries Emily Johnson can run it and it will output her race history in chronological order. Another query you can is the 5k leaderboard, so that you can see how fast you need to run in order to make it up their. 

Staff will use the database daily. Some examples include the Membership coordinators, Timers, and President. The Membership coordinators can identify members who have not attempted a half marathon and encourage those to compete. While the Timers take a look at it after every event and can determine whose ran the fastedt out of a specific year to crown the fastest. They can also crown who has ran the fastest 5k fro the year. The President could track what months have the highest sign up rate in order to determine when to schedule new races. if an error is made in the timing portion and it says you ran 20 seconds too slow, thats no problem. A single UPDATE statment can correct that and fix your time. If A runner gets injured after being added to a race the ROLLBACK call can undo their entry. 

Overall Design

This database is intentionally designed in third normal form, and include three core tables which eliminate redundancy and ensure data integrity. The Members table serves as that master list of people. The Race Holds each race in its own row. The Race Results is the middle man. It connects the members table to races while also storing the performance user specifc data. Many-to-many relationship is the right way to have a fully normalized model. As one member can run many races, and one race has many members. This allows for no duplicating member names in every result row or repeating race details for each participant. 

Some design choices I chose was to store gender as an ENUM('M','F','X') to enforce a valid value. Birth_date is kept as a full DATE rather than only the year born to have an accurate age-on-race-day calculation dynamically using YEAR(race_date) -YEAR(birth_date) instead of storing a dervived age column. 

