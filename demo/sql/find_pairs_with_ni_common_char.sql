-- Find pairs of sentences with no common characters
-- e.g. "I'm pappy", "He's sullen" does not have a character in common

create table letters (
    letter text
);

create table sentences (
    sentence text
);

insert into letters values ('a'), ('b'), ('c'), ('d'), ('e'), 
    ('f'), ('g'), ('h'), ('i'), ('j'), ('k'), ('l'), ('m'), 
    ('n'), ('o'), ('p'), ('q'), ('r'), ('s'), ('t'), ('u'), 
    ('v'), ('w'), ('x'), ('y'), ('z');

insert into sentences values 
    ('it is cold when it snows'),
    ('lava is hot'),
    ('I play my music in the sun'),
    ('on your left and on your right crosses are green crosses are blue'),
    ('the molten rock spills out over the land'),
    ('I am pappy'),  
    ('all the worlds a stage and we are merely players'),
    ('zymology is the study of fermentation'),
    ('he''s sullen');

-- Solution, credit to jingsting
-- https://github.com/jingsting
select 
    s1.sentence as lhs, 
    s2.sentence as rhs
from 
    sentences as s1, 
    sentences as s2
where not exists
    (select 
        *
    from 
        (select 
            letters.letter 
        from 
            letters 
        where 
            s1.sentence LIKE '%'|| letters.letter ||'%') as l1
        inner join 
        (select 
            letters.letter 
        from 
            letters 
        where 
            s2.sentence LIKE '%'|| letters.letter ||'%') as l2
    where l1.letter = l2.letter
    );