/*ACTIVATING THE DATABASE*/
Use Sakila;

/*TASK 1- LIST OF ACTORS AND LAST UPDATED DATE*/
 Select concat(First_name ,'  ', Last_name ) As Name,
       Last_update
    From Actor;

/*TASK 2*/
/* TASK 2.A- IS THERE ANY CHANGE IN ACTORS FIRST AND LAST NAME*/

  Select concat(first_name ,'  ', last_name ) 
     As Name
  From Actor;

/*Conclusion- There is no change in the names of actor*/
    
/*TASK 2.B-LIST OF ACTORS HAVING SAME FIRST AND LAST NAME AND LIST THEM*/

 Select count(*) 
        From (Select first_name,count(first_name) as 'count of name'
               FROM ACTOR 
        Group by first_name
        Having count(first_name)>1
        ORDER BY count(first_name) DESC ) as tab
   ;
   
Select count(*) 
    From (Select Last_name, count(Last_name) as 'count'
         FROM ACTOR
     group by Last_name
     having count(Last_name)>1)
           as tab1;
   
/*TASK 2.C- HOW MANY ACTORS HAVE UNIQUE NAMES? COUNT OF THESE ACTORS*/
   
select  count(*)
   From (Select distinct First_name 
          From ACTOR)  
        as tab;

/*TASK 3-LIST OF ACTORS HAVING UNIQUE AND SAME NAMES*/

/*UNIQUE NAMES LIST*/
Select distinct( CONCAT(First_Name, ' ',last_name)) as 'name'From ACTOR  
          ;
          
/* REPEATED NAMES LIST*/
 
 Select concat(First_name,last_name) as 'full_name',
         count(concat(First_name,last_name))as 'OCCURENCE'
        from 
            actor
        group by 
            concat(First_name,last_name)
        having 
            count(concat(First_name,last_name))>1 ;

   
/*TASK 4-CATEGORISE THE ACTORS PLAYING IDENYITY ROLES AS AS ACTION
         ROMANCE, HORROR AND MYSTERY
         DETAILED OVERVIEW OF FILM BASED ON ACTORS PREFERENCE*/
select * from category;
select * from film;
select * from film_actor;
SELECT * FROM FILM_CATEGORY;


Select  actor.first_name, actor.last_name,
       actor.actor_id,
       film_actor.film_id,
       film_category.category_id,
       category.name,
       film.title
    from actor 
      inner join 
            film_actor on actor.actor_id=film_actor.actor_id 
     inner join 
           film_category on film_category.film_id=film_actor.film_id
     inner join 
           film on film_actor.film_id= film.film_id
    inner join 
           category on category.category_id= film_category.category_id;

/*TASK 5- */
/*5.1 - WHICH CATEGORY HAV MAJOITY COUNT*/

SELECT * FROM FILM_CATEGORY;
select count(film_id), category_id from FILM_CATEGORY 
 group by category_id
 order by count(film_id) desc limit 0,5;
 
 /*majority of films are of category id 15*/

/*5.2- The board wants to know various rating categories with description*/
select* from film;
select rating , count(film_id) as 'count'
   FROM Film
   group by rating
   order by count(film_id) desc ;


/* TASK 6.1- MOVIE TITLE WHERE REPLACEMENT COST IS UPTO 9*/
SELECT * FROM FILM;
Select title ,replacement_cost
      from film 
       where replacement_cost<9;
         
/* TASK 6.2-MOVIE TITLE WHERE REPLACEMENT COST IS BETWEEN 15 AND 20*/      
Select title ,replacement_cost
      from film 
       where replacement_cost>15
       and   replacement_cost<20;

/*TASK 6.3- MOVIES WITH THE HIGHEST REPLACEMENT COST AND LOWEST RENTAL RATE*/
SELECT MAX(replacement_cost) FROM FILM; /* 29.99*/
SELECT MIN(RENTAL_RATE) FROM FILM;      /*0.99*/
Select title ,replacement_cost, RENTAL_RATE
      from film 
       where replacement_cost= 29.99
       AND   RENTAL_RATE = 0.99;
       
/* TASK 7 - LIST OF ALL FILMS ALONG WITH THE NO OF ACTORS LISTED WITH IT*/
SELECT * FROM FILM;     

Select title , count(film_actor.film_id) as 'count of actor'
      from Film
       inner join film_actor on film.film_id= film_actor.film_id
      group by title;
      
/*TASK 8 - FILMS STARTING WITH THE LETTER K AND Q */
select * from film;

Select title 
     from Film 
      where title like ('k%') or
            Title like ('Q%');

/* TASK 9 - ALL THE ACTORS IN THE FILM AGENT TRUMAN*/
SELECT * FROM FILM;

Select actor.first_name , actor.last_name,
        film_actor.actor_id,
        film.title
    from film
      inner join 
          film_actor 
            on film.film_id= film_actor.film_id
      inner join 
          actor 
            on actor.actor_id= film_actor. actor_id
      where title='agent truman';

/*TASK 10 - ALL THE MOVIES CATEGORISED AS FAMILY FILM*/
 SELECT * FROM CATEGORY;
 SELECT * FROM FILM;
 SELECT * FROM film_category;
 
 select film.title,
        film.film_id,
        Category.Name
        from film
        inner join film_category on film.film_id= film_category.film_id
        inner join CATEGORY on CATEGORY.Category_id= film_category.Category_id
        where name= 'family';
        

/*TASK 11- DISPLAY THE MOST FREQUENTLY RENTED MOVIES IN DESCEDING ORDER 
           TO MAINTAIN MORE COPIES OF THOSE MOVIES*/
SELECT * FROM FILM;
select * from rental;
select * from inventory;
Select Film.title , COUNT(Inventory.inventory_id) as 'no_rented'
   from Film
  inner join 
          INVENTORY
            on film.film_id = INVENTORY.film_id
  inner join 
         RENTAL  
            on inventory.inventory_id= rental.inventory_id
  group by 
          inventory.film_id
  order by
        count(inventory.inventory_id) desc;

/*TASK 12- IN HOW MANY FILM CATEGORIES THE AVERAGE DIFFERENCE BTW THE FILM */
           /*REPLACEMENT AND THE RENTAL RATE IS GREATER THAN 15*/
           
Select CATEGORY.Name ,
       ( avg(Film.replacement_cost) -avg(rental_rate)) as 'avg diff'
    from film
        inner join 
             film_category 
                on film.film_id= film_category.film_id
        inner join 
              CATEGORY 
                on CATEGORY.Category_id= film_category.Category_id
        group by
             category.name
        having (avg(Film.replacement_cost)-avg(rental_rate))>15;
        
           
           
           
/*TASK 13- THE GENRE HAVING 60 TO 70 FILMS. LIST THE NAMES OF THESE CATEGORIES
           AND THE NUMBER OF FILMS PER CATEGORY, SORTED BY THE NO OF FILMS*/ 
 
   Select count(Film_id), category.name
        From FILM_CATEGORY 
   Inner join  
          category 
        on FILM_CATEGORY.category_id= category .category_id
    group by 
           category.category_id
    having 
           count(Film_id) between 60 and 70
    order by 
            count(FILM_CATEGORY.film_id) desc;