-- Изучаем опросник CDP в поисках проблем для городов и населения, вызванных изменениями климата, и возможных их решений.

-- ПРОБЛЕМЫ, ВЫЗВАННЫЕ ИЗМЕНЕНИЕМ КЛИМАТА
-- Какие риски, связанные с глобальным потеплением, отметили организации для своих городов

Select substr(Hazard, (instr(Hazard, '>')+2)) as Hazard, NbOrganizations, Percentage 
From 
(Select Distinct(ResponseAnswer) as Hazard, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = 2.1
And ColumnNumber = 1
And Hazard <> 'NULL'
Group by Hazard
Order by NbOrganizations desc)


-- Какие сферы городской жизни наиболее подвержены климатическим рискам?

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = '2.1'
And ColumnNumber = 6
And a <> 'NULL'
Group by a
Order by NbOrganizations desc


-- Какие группы населения наиболее подвержены негативному влиянию?

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = '2.1'
And ColumnNumber = 7
And a <> 'NULL'
Group by a
Order by NbOrganizations desc


-- Отражаются ли риски на здравоохранении? 

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = '2.3'
And ColumnNumber = 0
And a <> 'NULL'
Group by a
Order by NbOrganizations desc


-- Проблемы в здравоохранении, связанные с изменением климата

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = '2.3a'
And ColumnNumber = 4
And a <> 'NULL'
And a <> 'Question not applicable'
Group by a
Order by NbOrganizations desc


-- АДАПТАЦИЯ
-- Сколько процентов городов включают цели устойчивого развития (например, сокращение выбросов парниковых газов) в генеральное планирование города

Select IncorporatingPlan, NbOrganizations, cast(NbOrganizations as Real)/556*100 as Percentage
From (
Select Distinct(ResponseAnswer) as IncorporatingPlan, Count(ResponseAnswer) as NbOrganizations
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = 1.0
And ColumnNumber = 0
Group by ResponseAnswer
)
Where NbOrganizations <> 0
Group by IncorporatingPlan
Order by NbOrganizations desc

-- ФАКТОРЫ, ВЛИЯЮЩИЕ НА ИЗМЕНЕНИЯ КЛИМАТА
-- Распределение использования энергии от различных источников

Select ColumnName,
Avg(ResponseAnswer)/Sum(Avg(ResponseAnswer)) Over () * 100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber =  '8.1'
And ColumnNumber <= 10
Group by ColumnName
Order by 2 desc


-- Есть ли в городе готовый отчет по выбросам вредных веществ в атмосферу

Select Distinct(ResponseAnswer) as Adaptation, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = 4.0
And ColumnNumber = 0
And Adaptation <> 'NULL'
Group by Adaptation
Order by NbOrganizations desc


-- Сводка выбросов CO2 по секторам (метрические тонны)

Select RowName, Sum(ResponseAnswer) as CO2_metric_tonnes
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = '4.6b'
And ColumnNumber = 1
Group by RowName
Order by RowNumber desc


-- МЕРЫ ПО АДАПТАЦИИ
-- Какие цели по адаптации к изменениям климата включены в планы развития городов

Select Distinct(ResponseAnswer) as Targets, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage, QuestionName
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = '1.0a'
And ColumnNumber = 1
And Targets <> 'NULL'
And Organization <> 'Tarakan City'
Group by Targets
Order by NbOrganizations desc


-- Какие конкретно действия предпринимают для адаптации к изменениям

Select Distinct(ResponseAnswer) as Adaptation, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = 3.0
And ColumnNumber = 2
And Adaptation <> 'NULL'
Group by Adaptation
Order by NbOrganizations desc


-- Как внедряют меры

Select Distinct(ResponseAnswer) as Adaptation, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = 3.0
And ColumnNumber = 5
And Adaptation <> 'NULL'
Group by Adaptation
Order by NbOrganizations desc


-- В каких сферах проходит сотрудничество города и бизнеса по устойчивому развитию 

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber =  '6.2a'
And ColumnNumber = 1
And a <> 'NULL'
And a <> 'Question not applicable'
Group by a
Order by NbOrganizations desc


-- Как осуществляется сотрудничество

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber =  '6.2a'
And ColumnNumber = 2
And a <> 'NULL'
And a <> 'Question not applicable'
Group by a
Order by NbOrganizations desc


-- УСПЕХИ
-- Изменилось ли количество выбросов с момента предыдущего отчёта

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = 4.8
And ColumnNumber = 1
And a <> 'NULL'
And a <> 'Question not applicable'
Group by a
Order by NbOrganizations desc


-- Почему произошли изменения в выбросах 

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber = 4.8
And ColumnNumber = 2
And a <> 'NULL'
And a <> 'Question not applicable'
Group by a
Order by NbOrganizations desc


-- К каким последствиям привели меры по адаптации к изменениям климата

Select Distinct(ResponseAnswer) as a, Count(ResponseAnswer) as NbOrganizations,
Count(ResponseAnswer)/cast(SUM(COUNT(ResponseAnswer)) OVER() as Real)*100 as Percentage
From '2020_Full_Cities_Dataset' 
Where QuestionNumber =  '6.0'
And ColumnNumber = 1
And a <> 'NULL'
And a <> 'Question not applicable'
Group by a
Order by NbOrganizations desc