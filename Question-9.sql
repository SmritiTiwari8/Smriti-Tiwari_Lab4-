CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`()
BEGIN
select supp_id,supp_name,sum_of_rating/count_of_rating as rating,
case when rating =5 then 'Excellent Service'
when rating=4 then 'Good Service'
when rating=2 then 'Average Service'
else 'Poor Service' end as 'Type_of_Service'
from (select sp.supp_id supp_id, supp_name supp_name, rat_ratstars rating, sum(rat_ratstars) sum_of_rating, count(rat_ratstars) count_of_rating 
from supplier s inner join supplier_pricing sp
on s.supp_id = sp.supp_id inner join order_directory.order ord on sp.pricing_id=ord.pricing_id
inner join rating r on ord.ord_id=r.ord_id group by sp.supp_id) a;
END