drop procedure if exists dbo.fibonacci_without_recursion
GO
create procedure dbo.fibonacci_without_recursion
AS
-- Fibonacci numbers are best gotten from a lookup table.  But if you want to calculate
-- the sequence yourself, here is a method that is much simpler than using recursion.
drop table if exists #f

create table #f
(seq INT IDENTITY,
 num BIGINT) 

DBCC CHECKIDENT (#f, RESEED,0)

insert into #f
select 0 UNION ALL
select 1

declare @first bigint
declare @second bigint

declare @loop int=2
while @loop <=92  -- If you go higher, you may feed to switch to a float (and thus lose
                  -- precision, but at least you won't overflow BIGINT
BEGIN
     set @first=(select num from #f where seq=@Loop-2)
	 set @second=(select num from #f where seq=@Loop-1)
	 insert into #f
	 select @first+@second
	 set @loop=@loop+1
END

select * from #f
order by 1
