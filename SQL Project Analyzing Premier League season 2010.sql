-- Analyzing data When Chelsea Win The premier League Title 2009-2010


-- Show The Dataset 

Select * 
From Chelsea.stats_premierleague;

Select * 
From Chelsea.results_premier_league;

-- First add Draws Column and fill it 

Update chelsea.stats_premierleague
Set Draws = Case team
When 'Chelsea'           Then 5
When 'Manchester United' Then 4
When 'Liverpool'         Then 9
When 'Arsenal'           Then 6
When 'Tottenham Hotspur' Then 7
When 'Bolton Wanderers'  Then 9
When 'Manchester City'   Then 13
When 'Aston Villa'       Then 13
When 'Everton'           Then 13
When 'Birmingham City'   Then 11
When 'Blackburn Rovers'  Then 11
When 'Fulham'            Then 10
When 'Stoke City'        Then 14
When 'Sunderland'        Then 11
When 'Wigan Athletic'    Then 9
When 'Wolverhampton Wanderers' Then 11
When 'Burnley'           Then 6
When 'West Ham United'   Then 11
When 'Hull City'         Then 6
When 'Portsmouth'        Then 11
Else "invalid value"
End  
Where season = '2009-2010';

-- Filter The total Wins & Golas

Select team,
       max(wins) as Wins,
       Max(goals) as Goals,
       max(Draws),
       season
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team
Order by Wins desc;

-- Filter The Total Clean-sheet for on This Seson

Select team,
       Max(clean_sheet) as Clean_Sheet,
       season
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team
Order by Clean_Sheet desc;

-- Find The Percaentage of Wining For Each team

Select team,
       max(wins)/38 as Percentage_Of_wining,
       season
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team
Order by Percentage_Of_wining desc;

-- Find The Total points for Each Team Column 

Select team,
       max(wins*3) + max(Draws * 1) as Points
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team
Order by Points desc;

-- Find wich Team suffer the most From the Refesres Desscions During the Season 

Select team,
	   Max(total_yel_card) As Yellow_Card,
       Max(total_red_card) As Red_Card,
       Max(total_offside) As Total_Offside,
       Max(penalty_conceded) as Total_Penalty_Conceded
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team 
Order by Yellow_card desc;

-- Find The probablity For Each team during the Seson for getteing Red or Yellow card  per Game

Select team,
	   Max(total_yel_card)/38 As Percentage_Of_YellowCard_PerGame ,
       Max(total_red_card)/38 As Percentage_Of_RedCard_PerGame,
       Max(total_offside)/38  As  Percentage_Offside_PerGame
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team 
Order by Percentage_Of_YellowCard_PerGame desc;

-- Find The Unluckiest Team For the Season

Select team,
       max(hit_woodwork) as Hit_Woodwork,
       max(Own_goals) as  Own_goals
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team 
Order by Own_goals desc;

-- Make Identification Column For Each Team if the Lucky Or Not --

-- 1- First Create View That Can be Called 
 
 -- First View For Avg Hit_Woodwork
 Create view AvgOf_Unluckiest
 as 
 Select
	 avg(hit_woodwork) as avg_hit_woodwork
From Chelsea.stats_premierleague
Where season = '2009-2010'
Order by avg_hit_woodwork desc;

-- Second View For Avg Own_Golas
Create view AvgOf_Unluckiest2
 as 
 Select
	 avg(own_goals) as avg_own_Goals
From Chelsea.stats_premierleague
Where season = '2009-2010'
Order by avg_own_Goals desc;

-- 2- Show The Result Of the View That you Create
 Select * From AvgOf_Unluckiest;
 
 Select * From AvgOf_Unluckiest2;
 
-- 3- Use The (Case) Condition Now To apply The work

Select team,
       Case
       When max(hit_woodwork) > (select * From AvgOf_Unluckiest) 
       and  max(own_goals)     > (select * From AvgOf_Unluckiest2) Then "UnLucky"
	   When max(hit_woodwork) < (select * From AvgOf_Unluckiest) 
       and  max(own_goals)    < (select * From AvgOf_Unluckiest2) Then "Lucky"
       Else "Normal"
       End team_Status
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team ;

-- Find The Top 10 Attacking line in this season --

Select team,
       max(goals) as Total_Golas ,
       max(total_scoring_att) as Total_Scoring_Att
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team 
Order by Total_Golas desc
limit 10;       

-- Accroding to The Points specify Each Team Postion and Status in this season Whether They Qualified To the Champions League Or Not And How Relegated --

-- 1- Create View That Contain Only The Top 4 Teams 

Create view Top_4
as 
Select team,
       max(wins*3) + max(Draws * 1) as Points
From Chelsea.stats_premierleague
Where season = '2009-2010' 
group by team
Order by Points desc
Limit 4;

-- Show The Result Of the View 
   Select * From Top_4;
   
-- 2- Create Temporary Table That Contain Only The Last 3 Teams

Create view Bottom_3
as 
Select team,
       max(wins*3) + max(Draws * 1) as Points
From Chelsea.stats_premierleague
Where season = '2009-2010'
group by team
Order by Points asc
Limit 3;

-- Show The Result Of the View
Select * From Bottom_3;

-- 3- Now The fun work become ( Identify The Team Position)

Select Team,
	   max(Wins) as Wins,
       Max(Draws) as Draws,
       Max(Losses) as Losses,
       max(wins*3) + max(Draws * 1) as Points,
	Case team
    When team not in (select team From Top_4) Then "Qualified For Champions League" 
    When team not in (Select team From bottom_3 ) Then "Relegated"
    Else "Stay"
    End Team_Position
From Chelsea.stats_premierleague 
Where season = '2009-2010'
group by team 
Order by points desc;


    
  
