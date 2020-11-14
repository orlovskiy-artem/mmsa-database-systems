SELECT p.first_name,p.last_name,
       count(DISTINCT order_id) AS total_orders,
       sum(quantity) AS total_items_bought,
       sum((price-discount)*quantity) AS total_money_spent
       FROM person p  LEFT OUTER JOIN  "order" o ON p.id = o.person_id
                      LEFT OUTER JOIN  order_item oi ON oi.order_id = o.id
                      LEFT OUTER JOIN item i ON oi.item_id = i.id
GROUP BY p.first_name,p.last_name;
