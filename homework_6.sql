--Пользователь,  который больше всех общался с заданным пользоваетелем.
	  
	SELECT from_user_id, to_user_id FROM messages WHERE (to_user_id in
 ((SELECT friend_id 
	  FROM friendship 
	  WHERE user_id = 2
		AND confirmed_at IS NOT NULL 
		AND status IS NOT NULL
	)
	UNION
 (SELECT user_id 
	  FROM friendship 
	  WHERE friend_id = 2
		AND confirmed_at IS NOT NULL 
		AND status IS NOT NULL
	))
    and from_user_id = 2) or
 (from_user_id in 
 ((SELECT friend_id 
	  FROM friendship 
	  WHERE user_id = 2
		AND confirmed_at IS NOT NULL 
		AND status IS NOT NULL
	)
	UNION
 (SELECT user_id 
	  FROM friendship 
	  WHERE friend_id = 2
		AND confirmed_at IS NOT NULL 
		AND status IS NOT NULL
	))
    and to_user_id = 2
 );

-- Для подсчета к-ва лайков, которые получили 10 самых молодых пользователей

SELECT COUNT(id) FROM LIKES WHERE user_id IN (
  SELECT * FROM (
    SELECT id FROM users ORDER BY birthday DESC LIMIT 10
    ) as smth
);

-- К-во лайков (всего) - мужчины/женщины

SELECT IF(
	(SELECT COUNT(id) FROM LIKES WHERE user_id IN (
		SELECT id FROM users WHERE sex="m")
	) 
	> 
	(SELECT COUNT(id) FROM LIKES WHERE user_id IN (
		SELECT id FROM users WHERE sex="f")
	), 
   'male', 'female');

-- Вычислить 10 пользователей, которые проявляют наименьшую активность в соц.сети.


SELECT user_id, COUNT(*) AS count
FROM likes
GROUP BY user_id
ORDER BY count LIMIT 10;

SELECT user_id, COUNT(*) AS count
FROM media
GROUP BY user_id
ORDER BY count LIMIT 10;

SELECT from_user_id, COUNT(*) AS count
FROM messages
GROUP BY from_user_id
ORDER BY count LIMIT 10;