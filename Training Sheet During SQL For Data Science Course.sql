Create Schema Chelsea;

Create Table Players(
Name        Varchar(20) Primary Key,
Number      int(2) Not null,
Age         int(2) Not null,
Nationality Varchar(20) Not null
);

Create Table Liverpol (
Name  varchar(20),
TShirt_Number  int(2) Not null,
Age            int(2) not null,
Nationality   varchar(20) not null,
FOREIGN KEY (Name) REFERENCES Players(Player_Name)
);

select * from Liverpol ;

Insert Into Liverpol (TShirt_Number, Age, Nationality)
Values (10, 31, "Eygpt");

Insert Into Liverpol (TShirt_Number, Age, Nationality,Club)
Values (5, 22, "England",'Liverpol');

Insert Into Liverpol (TShirt_Number, Age, Country,Club_Name)
Values (6, 33, "Netherland",'Liverpol');

Insert Into Liverpol (TShirt_Number, Age, Country,Club_Name)
Values (23, 24, "Netherland",'Liverpol');

Insert Into Liverpol (TShirt_Number, Age, Country,Club_Name)
Values (8, 34, "Spain",'Liverpol');

Insert Into Liverpol (TShirt_Number, Age, Country,Club_Name)
Values (10, 28, "England",'Liverpol');

Insert Into Liverpol (Name, TShirt_Number, Age, Country,Club_Name)
Values ("Ronaldo", 7, 38, "Portugal",'Alnasser');

DELETE FROM Liverpol WHERE TShirt_Number = 6;

Select * From Players;

Insert Into Players (Player_Id,Player_Name, T_Shirt_Number, Age, Nationality)
Values (1,"Strling", 10, 28, "England");

Insert Into Players (Name, Number, Age, Nationality)
Values ("Enzo", 8, 22, "Argentina");

Insert Into Players (Name, Number, Age, Nationality)
Values ("Maduke", 12, 24, "England");

Insert Into Players (Name, Number, Age, Nationality)
Values ("James", 24, 23, "England");

Insert Into Players (Name, Number, Age, Nationality)
Values ("Silva", 6, 38, "Brazil");

Insert Into Players (Name, Number, Age, Nationality)
Values ("Mudrek", 15, 20, "Ukrain");

Insert Into Players (Name, Number, Age, Nationality)
Values ("Hazard", 10, 34, "Beligum");

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality)
Values ("Lambard", 8, 42, "England");

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality)
Values ("Terry", 3, 40, "England");

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality)
Values ("Drogba", 11, 43, "coatdivwar");

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality)
Values ("Cole", 6, 44, "England");

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality)
Values ("Casido", 25, 22, "Colombia");

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality,Player_ID,Club)
Values ("Lavia", 23, 25, "africa",10,'Chelsea');

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality,Player_ID,Club,Birthdate)
Values ("Chilwill", 13, 25, "England",88,'Chelsea','1998-7-1');

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality,Player_ID,Club,Birthdate)
Values ("Mount", 7, 24, "England",98,'manunited','1999-8-23');

Insert Into Players (Player_Name, T_shirt_Number, Age, Nationality,Player_ID,Club,Birthdate)
Values ("Ronaldo", 7, 38, "Portugal",77,'Alnasser','1987-2-13');
------------
Select Player_Name , T_shirt_Number 
From Players 
Where Nationality = "England";
------------ In 
Select Player_Name , T_shirt_Number , Nationality 
From Players 
Where T_shirt_Number In(6,10);
------------ Wild Card
Select Player_Name , Nationality 
From Players 
Where Player_Name Like "%Hazard";
---
Select Player_Name , Nationality 
From Players 
Where Player_Name Like "_Hazard";
---------------- Sorting Order by
Select Player_Name , T_shirt_Number, Nationality
From Players 
Order by T_shirt_Number;
--- by column
Select Player_Name 
From Players 
Order by 1;
-- 
Select Player_Name ,Nationality ,age
From Players
Order by 3 ASC;
---------------- Math operation
Select Player_Name, Nationality, T_shirt_Number + age as number_Of_love
from Players
where age< 30
Order by age;
---
Select Player_Name, Nationality, (T_shirt_Number + age)*2 as number_Of_love
from Players
Order by age ;
--------------- Aggregate function
Select AVG(age) as AVG_age
From players;
--- Return number of rows
Select Count(*) As Total_players
from Players;
--- 
Select Count(distinct Player_Name) As Players_Avaliable
From players;
--- return mnimum
Select Min(Age) as Youngest_Player
From players;
---
select Sum(T_shirt_Number) as Sum_of_Tshirt
From players;
-------------- Group by / having count(*)
Select T_shirt_Number,Count(*) as Tshirt_of_Players
from Players
Group by T_shirt_Number;
---
Select Count(*) as Same_Age
From players
Group by age
Having Count(*) >=1;

----------------- Sub Query
Select Player_Name,T_shirt_Number
From Players 
Where Player_Name In ( Select Name 
					   From Liverpol);
                       
---------------- Cross Joins / Repeate Every Record from the first table with each record from the second table
Select  Player_Name,
		Player_Id,
        Country, 
        Club_Name
From Players Cross Join Liverpol;
------------------ INNER JOIN                      
Select p.Player_Name ,
       p.T_shirt_Number,
       l.Country,
       l.Club_Name
From Players p Inner join Liverpol l On Player_Name = Name;
------------------ Alies & Self Join
Select Player_Name, 
       TShirt_Number, 
	   Country
From Players as p , Liverpol as l
Where p.Player_Name = l.Name;
---- Self join / treat the table as another table
Select A.player_Name as Al3b, 
       B.Player_Name as L3eeb ,
       A.Nationality
From Players A , Players B
Where A.Player_Name = B.Player_Name
And A.Nationality = B.Nationality
Order by A.Nationality;
--------------------------- Left & Right Join / Left join Return All the tables from the left side and what match from the right side
-- Left 
Select p.Player_Name ,
       l.TShirt_Number,
       l.country,
       l.Club_Name
From players p Left join Liverpol l 
On p.Player_Name = l.Name
Order by l.country;
-- Right 
Select p.Player_Name ,
       l.TShirt_Number,
       l.country,
       l.Club_Name
From players p Right join Liverpol l 
On p.Player_Name = l.Name
Order by l.country;
-- full outer Join
Select p.Player_Name ,
       l.TShirt_Number,
       l.country,
       l.Club_Name
From players p JOIN Liverpol l 
On p.Player_Name = l.Name
Order by l.country;

------------------------------- Union
Select Player_Name , Nationality 
From Players
Where Nationality  = "England"
Union 
Select Name, Country
From Liverpol
Where Country  = "England"
Order by Player_Name;


------------------------- Concatinate / Trim / SubStr / Upper,Lower,Uscase
Select Player_Name,
       Nationality,
       concat(Player_Name," - ", Nationality)
       From Players;
-- Trim 
Select Player_Name,
       Nationality,
       concat(Player_Name," - ", Nationality) AS Player_Country,
       Trim(Nationality)
       From Players;
-- SubStr
Select Player_Name,
       Nationality,
       substr(Player_Name,2,4) as SurName
From Players;
-- Upper / Lower / Uscase
Select upper(Player_Name) as Player_Name,
       lower(Nationality) as Nationality,
       ucase(Club)
From Players;
-------------------------------- Date & Time 
Select Birthdate ,
	   year(Birthdate) as Year,
       month(Birthdate) as Month,
       DAY(Birthdate) as Day
From Players
Where Birthdate is not null;
------------- Case Statment
Select Player_Name,
	   Nationality,
       Club,
CASE Club 
	 When 'Chelsea' Then 'Chelsea'
     When 'manunited' Then 'Manuinted'
     When 'alnasser' Then 'Alnasser'
     Else 'Other'
     End Club_Name
From Players;
--------
Select Player_Name,
       Nationality,
       Club,
CASE Nationality
     When 'England'  Then 'Premier League'
     When 'Africa'   Then 'Premier Leage'
     When 'Portugal' Then 'RLS League'
     else 'Other'
     End League
From players;
-------
Select Player_Name,
       Nationality,
       Club,
       age,
Case 
   When age >= 18 and age <= 25 Then "Young Player"
   When age > 25 and age <= 30 Then  "Prime Age Player"
   When age > 30 Then "Retair age"
   End player_Classfication
From Players;
-------------------- Views Tables 
create view My_View
as 
select p.Player_name,
       p.Nationality,
       l.Club_Name
From players p left Join liverpol l 
On p.Player_Name = l.Name;

Drop View My_View;

Select * From My_View;



















Update Players 
Set Club = "Chelsea"
Where Club is null;

Alter table Players Rename Column Name to Player_Name;

Alter table Players Rename Column Number to T_shirt_Number;

alter table Players add column Player_ID int Not null; 

Alter Table Players add column Club varchar(20);
 
Alter Table Liverpol Add column Club varchar(20);

Alter Table Liverpol Rename Column Club to 	Club_Name;

Alter Table Liverpol Rename Column Nationality to Country;

Alter Table Players add Column Birthdate date;


-- Drop Table Players;