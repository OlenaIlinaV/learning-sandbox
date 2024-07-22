## Order of execution of a Query
**SELECT DISTINCT** column, AGG_FUNC(column_or_expression), …

**FROM** mytable
    **JOIN** another_table
      **ON** mytable.column = another_table.column

**WHERE** constraint_expression

**GROUP BY** column

**HAVING** constraint_expression

**ORDER BY** column ASC/DESC

**LIMIT** count **OFFSET** COUNT;

## Logical Query Processing:
![alt text](https://cdn.sisense.com/wp-content/uploads/image-1-order-blog.png)

**FROM and JOINs**: У цьому кроці визначається, з якої таблиці чи таблиць потрібно вибирати дані. Якщо в запиті є декілька таблиць, вони об'єднуються за допомогою операції JOIN.

**WHERE**: Умови, вказані в розділі WHERE, фільтрують дані, вибираючи тільки ті рядки, які відповідають умовам.

**GROUP BY**: Якщо в запиті є групування (GROUP BY), дані групуються за вказаними полями.

**HAVING**: Умови, вказані в розділі HAVING, фільтрують групи, залишаючи лише ті, які задовольняють умовам.

**SELECT**: Визначається список колонок, які вибираються для виводу.

**ORDER BY**: Результати можна впорядкувати за допомогою ORDER BY вказаним полем чи полями.

**TOP (або LIMIT)**: Вибрані рядки можуть бути обмежені за допомогою TOP (в SQL Server) або LIMIT (в багатьох інших СУБД)

**OFFSET**: dictates the number of rows to skip from the beginning of the returned data before presenting the results. 

## JOIN

USING(...id)

![alt text](https://miro.medium.com/v2/resize%3Afit%3A1100/format%3Awebp/1%2Aav8Om3HpG1MC7YTLKvyftg.png)

## UNION


[Picture](/Users/olenailina/sources/my_practice/1714965101124.png)

![alt text](https://www.sqlservertutorial.net/wp-content/uploads/SQL-Server-UNION-vs-JOIN.png)


**INTERSECT** and **EXCEPT**
![alt text](image.png)

![alt text](https://www.sqlservertutorial.net/wp-content/uploads/SQL-Server-INTERSECT-Illustration.png)

![alt text](https://www.sqlservertutorial.net/wp-content/uploads/SQL-Server-EXCEPT-illustration.png)