use review_system;
/*1-*display the paper_id and the
reviewer department name who
reviewed the paper “transformation in AI”*/


select distinct r.rev_email,r.rev_dept
from reviewer r,(select distinct pr.rev_email
				from paper_rev pr
				where pr.paper_id = 	(select distinct paper_id
										from paper_details
										where title = 'transformation in AI')) r_e
where r.rev_email = r_e.rev_email;


/*2-Display all the papers that are
published by the author
“auth4” and the respective
reviwer and score. */


select distinct pr.paper_id,pd.title,pr.rev_email,pr.score
from paper_rev pr,paper_details pd
where pr.paper_id = pd.paper_id and pr.paper_id in (select distinct p.paper_id
                                                    from paper p
                                                    where p.auth_email = (select distinct auth_email
                                                                            from author
                                                                            where auth_name = 'ram'));

/*or*/

select distinct pr.paper_id,pr.rev_email,pr.score
from paper_rev pr
inner join paper on pr.paper_id = paper.paper_id
where paper.auth_email = (select auth_email from author where auth_name = 'ram');

/*3-Display the paper_id and
topic_name where score is >=3 */

select distinct pd.paper_id,pd.total_score,pd.paper_topic
from paper_details pd
where pd.total_score >= 3;

/*4-Display the paper status
“paper_id”.
*/

select stat
from paper_details
where paper_id = 'A6';

/*5-Display the comments of
the paper and the author name
and the reviewer name of paper
title “Improvised deep learning”. */

/*we will the cross join of paper_details and paper_rev and then join with author and reviewer table*/

select *
from (select distinct rev_email,rev_comments from paper_rev where paper_id = (select distinct paper_id
                    from paper_details
                    where title = 'Improvised deep learning')) r,(select auth_email from paper
                                                                                    where paper_id = (select paper_id from paper_details
                                                                                                                      where title = 'Improvised deep learning')) a;


/*6-Display the author and the
committee comments where
paper id is “A4”*/

select pd.commitee_comments,pd.paper_id
from paper_details pd
where paper_id = 'A4' and pd.commitee_comments is not null;


/*7-Display the topics that are
intrested by the reviewer
“rajesh”.*/

select topics
from rev_topics
where rev_email = (select distinct rev_email from reviewer where rev_name = 'rajesh');

/*8-Display name of the dept of the
paper_like "AI".
*/

select distinct pd.dept
from paper_dept pd
where pd.topic = (select distinct paper_topic from paper_details where title like '%AI%');

/*9-Display the file name of the paper
ID --- need to write*/

/*10-Display the paper_id and
topic_name where score is <3. */

select distinct pd.paper_id,pd.total_score,pd.paper_topic
from paper_details pd
where pd.total_score < 3;
/*11-Display all the recommendation of
the paper_”Name” by the
reviewer_rv_email and author
name. */


select distinct p.auth_comments,pr.rev_comments
from paper p,paper_rev pr,(select distinct paper_id
					from paper_details
					where title = 'transformation in AI') pid
where pid.paper_id = p.paper_id and pid.paper_id = pr.paper_id;

/*13-Display the dept
paper_topic,related rv_email ID*/


select distinct rev_dept,paper_id,pr.rev_email
from paper_rev pr
inner join reviewer on pr.rev_email = reviewer.rev_email
group by rev_dept;

/*16-Scores of the paper_”title”.*/

select score,rev_email
from paper_rev
where paper_id = (select distinct paper_id from paper_details where title  = 'transformation in AI');

/*17-Display committee and author
comments in the paper all “title”.*/

select distinct pd.commitee_comments,p.auth_comments,p.auth_email
from paper_details pd,paper p
where pd.paper_id = p.paper_id and pd.paper_id = (select distinct paper_id from paper_details where title = 'Improvised deep learning');


create table paper_title(
    paper_id varchar(10),
    title varchar(10),
    foreign key (paper_id) references paper(paper_id)
);

alter table paper_title
add column topic varchar(20);

drop table paper_title;

create table paper_details(
    paper_id varchar(10),
    title varchar(20),
    paper_topic varchar(20),
    stat varchar(10)
);

alter table paper_details
modify title varchar(200);

insert into paper_details values
('A1','transformation in AI','AI','reviewed'),
('A2','Improvised deep learning','DL','reviewed'),
('A3','revolution in distrbuted database','Block chain','reviewed'),
('A5','etherium smart contracts','d apps','reviewed'),
('A4','Threats all over','ethichal hacking','reviewed'),
('A6','data collelction','iot','pending');

alter table paper_details
add foreign key (paper_id) references paper(paper_id);

