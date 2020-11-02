SELECT first_name, last_name, total_orders, total_quantity, total_money_spent
FROM (SELECT t.person_id, t.first_name, t.last_name, t.total_orders, t2.total_quantity
      FROM (SELECT p.id AS person_id, p.first_name, p.last_name, count(o.id) AS total_orders
            FROM person p
                     LEFT OUTER JOIN "order" o ON p.id = o.person_id
            GROUP BY p.id, p.first_name, p.last_name) AS t
               LEFT OUTER JOIN
           (SELECT person_id, sum(quantity) AS total_quantity
            FROM "order" o
                     INNER JOIN order_item oi ON o.id = oi.order_id
            GROUP BY person_id) AS t2 ON t.person_id = t2.person_id) AS t3
                LEFT OUTER JOIN
            (SELECT person_id, SUM((price - discount) * quantity) AS total_money_spent
             FROM "order" o
                     INNER JOIN order_item oi ON o.id = oi.order_id
                     INNER JOIN item i ON oi.item_id = i.id
             GROUP BY person_id
) AS t4 ON t3.person_id = t4.person_id
ORDER BY total_orders;

