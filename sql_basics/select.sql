SELECT first_name, last_name, total_orders, total_quantity, t3.total_money_spent
FROM ((SELECT t.person_id, t.first_name, t.last_name, t.total_orders
      FROM (SELECT p.id AS person_id, p.first_name, p.last_name, count(o.id) AS total_orders
            FROM person p
                     LEFT OUTER JOIN `order` o ON p.id = o.person_id
            GROUP BY p.id, p.first_name, p.last_name) AS t) AS t2
               LEFT OUTER JOIN
           (SELECT person_id, sum(quantity) AS total_quantity,SUM((price - discount) * quantity) AS total_money_spent
            FROM `order` o
                     INNER JOIN order_item oi ON o.id = oi.order_id
                     INNER JOIN item i ON oi.item_id = i.id
            GROUP BY person_id) AS t3 ON t2.person_id = t3.person_id)
ORDER BY total_orders;

