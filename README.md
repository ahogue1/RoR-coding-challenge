# Banner People

Banner People is a Game of Thrones based loyalty tracker where the Banner People's House loyalties change based on their current House's handouts. Meanwhile, a house Maester will be giving advisements to try to keep the Banner Person within the House's acceptable range of loyalty points


## Seeds

Generating the Seeds was my favorite part of this project. Generating the odds and keeping everything random to follow real human behavior and then watching the data unfold was a fun challenge. 

The seeds will similate 
[Faker::TvShows::GameOfThrones]

* Loyalty Points are measured on a random date every 7-8 days
  * If the Banner Person's Loyalty Points fall below 10, a new house will be selected, but there's a 25% that the Banner    Person will remain in the same house. These House changes will appear in the console as the Seeds are created. 
* Handouts are handed out 8 to 12 random times per month
  * Around 10% of those will be skipped
  * Handouts have a 50% probability of being the previous advisement, but there's a 25% chance that they will increase 100, 200, 300, 400 or 500 units and a 25% chance that they will decrease by the same amounts. 
 * Advisements are generated on 3 random dates per month when a handout is also being given

Run: 

```
rails db:seed
```
And watch the game unfold in the console and Banner People switch Houses in their quest for the Iron Throne. 

![image](https://user-images.githubusercontent.com/31170111/59397140-6301da80-8d40-11e9-8f7b-e832c6731872.png)


## Banner People Index
The app will route automatically to BannerPeople#Index

This will show the most current House each Banner Person belongs to, their most recent Loyalty Points reading and a link to thier #show pages. 

![image](https://user-images.githubusercontent.com/31170111/59397077-29c96a80-8d40-11e9-88c8-885eaf224520.png)

The background is pure CSS generated snow - I wouldn't normally use this in design, but I like messing with CSS transformations and since Winter is Coming, it felt appropriate. I used this [CSS Snow Generator] tutorial and tweaked it a bit to be less...intense.

## BannerPerson#Show Graph

At the top of the Banner Person Show page is the Highcharts Graph that shows the progression of a Banner Person's loyalty points throughout the month of January in the line and the handouts given in the bars

I used the Highcharts gem and started with the dark-green theme and customized it in `highcharts_theme.js` 

As recommended, I used the `gon` gem to transform my Ruby into JS variables. 

![image](https://user-images.githubusercontent.com/31170111/59397014-f25abe00-8d3f-11e9-8225-35b86e9d3608.png)

## BannerPerson#Show Tables

The Simple view and Extended view are seperate tables that are shown/hidden with a javascript fundtion found in `application.js`

![image](https://user-images.githubusercontent.com/31170111/59396927-a4de5100-8d3f-11e9-95eb-def25f098256.png)

![image](https://user-images.githubusercontent.com/31170111/59396833-529d3000-8d3f-11e9-8988-f188bc72b525.png)

Values:
* The house-ID is a combination of the House name's acronym (saved as `house_prefix` in the DB) interpolated with the BannerPerson ID
* I used `Bootstrap` to make a modal the `edit` function for the Advisement. Both the value and the date can be edited. 

![image](https://user-images.githubusercontent.com/31170111/59396984-d48d5900-8d3f-11e9-9ff6-60f516730511.png)


## Concepts that were new to me: 

* Gon and Highcharts - both were fairly easy and produced a nice graph

* Slim - it was weird at first and sometimes I needed to just do good ol' un-slim HTML, but by the end of the project I liked not having closing tags and ends everywhere

* Leveled Up Seeds : like I said, this was my favorite aspect. I've never made seeds that kind of mimic human behavior and unpredictability and I liked it



## Room for improvement: 

* I had to remove Turbolinks because it was preventing page loading and changing tables styles - TurboLinks compatibility would be ideal for the fastest loading. 

* The % accepted only goes until the last input Advisement, it would be ideal to have it aggregate after each new Advisement is created and for that to be put into an ActiveSupport Concern

* I was very tempted to have the page play the GOT theme when BannerPerson#index loads. I resisted for the sake of my sanity, but I think if ever a page should play a song upon load; it's this one.




[Faker::TvShows::GameOfThrones]: https://github.com/stympy/faker/blob/master/doc/tv_shows/game_of_thrones.md
[CSS Snow Generator]: https://redstapler.co/pure-css-snow-fall-effect/
