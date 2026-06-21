create table Users (
    user_id serial primary key,
    full_name varchar(60),
    email varchar(40),
    role varchar(30) check (role='Ticket Manager' or role='Football Fan'),
    phone_number varchar(40)
      
);


create table Matches (
    match_id serial primary key,
    fixture varchar(60),
    tournament_category varchar(40),
    base_ticket_price int,
    match_status varchar(40)
    
    
);


create table Bookings(
    booking_id serial primary key,
    user_id integer references Users(user_id),
    match_id integer references Matches(match_id),
    seat_number varchar(10),
    payment_status varchar(30),
    total_cost int
     
);



insert into Users (user_id, full_name, email, role, phone_number) values
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


insert into Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) values
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');


insert into Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) values
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);


-- query-1
select match_id,fixture,base_ticket_price from Matches 
where tournament_category = 'Champions League' and match_status='Available'; 



-- query-2
select user_id,full_name,email from Users 
where full_name ilike 'Tanvir%' or full_name ilike '%Haque%';


-- query-3
select booking_id,user_id,match_id,coalesce(payment_status,'Action Required') as systematic_status from Bookings
where payment_status is null;

-- query-4
select booking_id,full_name,fixture,total_cost from Bookings
inner join Users on Bookings.user_id = Users.user_id
inner join Matches on Bookings.match_id = Matches.match_id;


-- query-5
select user_id,full_name,booking_id from Users 
left join Bookings using(user_id);

-- query-6
select booking_id,match_id,total_cost from Bookings
where total_cost>(select avg(total_cost) from Bookings);

-- query-7

select match_id,fixture,base_ticket_price from Matches
where base_ticket_price<(select max(base_ticket_price) from Matches)
order by base_ticket_price desc
limit 2;
