--team with most wins
SELECT
    HomeTeam AS Team,
    COUNT(*) AS Wins
FROM
    season1819
WHERE
    FTR = 'H'
GROUP BY
    HomeTeam

UNION ALL
SELECT
    AwayTeam AS Team,
    COUNT(*) AS Wins
FROM
    season1819
WHERE
    FTR = 'A'
GROUP BY
    AwayTeam
ORDER BY
    Wins DESC
LIMIT 1;



--away team with most wins
SELECT
    AwayTeam AS Team,
    COUNT(*) AS Wins
FROM
    season1819
WHERE
    FTR = 'A'
GROUP BY
    AwayTeam
ORDER BY
    Wins DESC
LIMIT 1;



--home team with most wins
SELECT
    HomeTeam AS Team,
    COUNT(*) AS Wins
FROM
    season1819
WHERE
    FTR = 'H'
GROUP BY
    HomeTeam
ORDER BY
    Wins DESC
LIMIT 1;



--team with most draws
SELECT
    Team,
    Draws
FROM
    (
        SELECT HomeTeam AS Team, COUNT(*) AS Draws
        FROM season1819
        WHERE FTR = 'D'
        GROUP BY HomeTeam

        UNION ALL
        SELECT AwayTeam AS Team, COUNT(*) AS Draws
        FROM season1819
        WHERE FTR = 'D'
        GROUP BY AwayTeam
    ) AS Combined
ORDER BY
    Draws DESC
LIMIT 1;



--team with most losses
SELECT
    Team,
    Losses
FROM
    (
        SELECT HomeTeam AS Team, COUNT(*) AS Losses
        FROM season1819
        WHERE FTR = 'A'
        GROUP BY HomeTeam

        UNION ALL
        SELECT AwayTeam AS Team, COUNT(*) AS Losses
        FROM season1819
        WHERE FTR = 'H'
        GROUP BY AwayTeam
    ) AS Combined
ORDER BY
    Losses DESC
LIMIT 1;



---team with most yellow cards
SELECT
    Referee,
    SUM(HY + AY) AS TotalYellowCards
FROM
    season1819
GROUP BY
    Referee
ORDER BY
    TotalYellowCards DESC
LIMIT 1;



--team with most red cards
SELECT
    Referee,
    SUM(HR + AR) AS TotalRedCards
FROM
    season1819
GROUP BY
    Referee
ORDER BY
    TotalRedCards DESC
LIMIT 1;



--team with most shots on target
SELECT
    Team,
    MAX(ShotsOnTarget) AS MostShotsOnTarget
FROM
    (
        SELECT HomeTeam AS Team, MAX(HST) AS ShotsOnTarget
        FROM season1819
        GROUP BY HomeTeam

        UNION ALL
        SELECT AwayTeam AS Team, MAX(AST) AS ShotsOnTarget
        FROM season1819
        GROUP BY AwayTeam
    ) AS Combined



---team with most fouls
SELECT
    Referee,
    SUM(HF + AF) AS TotalFoulsCalled
FROM
    season1819
GROUP BY
    Referee
ORDER BY
    TotalFoulsCalled DESC
LIMIT 1;




--team with most corners
SELECT
    Team,
    MAX(TotalCorners) AS MostCorners
FROM
    (
        SELECT HomeTeam AS Team, SUM(HC) AS TotalCorners
        FROM season1819
        GROUP BY HomeTeam

        UNION ALL
        SELECT AwayTeam AS Team, SUM(AC) AS TotalCorners
        FROM season1819
        GROUP BY AwayTeam
    ) AS Combined       



---away team with most corners
SELECT
    Team,
    MAX(TotalCorners) AS MostCorners
FROM
    (
        SELECT AwayTeam AS Team, SUM(AC) AS TotalCorners
        FROM season1819
        GROUP BY AwayTeam
    ) AS AwayCorners



--home team with most corners
SELECT
    Team,
    MAX(TotalCorners) AS MostCorners
FROM
    (
        SELECT HomeTeam AS Team, SUM(HC) AS TotalCorners
        FROM season1819
        GROUP BY HomeTeam
    ) AS HomeCorners





---teams wins with a particular referee
WITH RefereeWins AS (
    SELECT
        Referee,
        HomeTeam AS Team,
        COUNT(*) AS Wins
    FROM
        season1819
    WHERE
        FTR = 'H'
    GROUP BY
        Referee, HomeTeam

    UNION ALL
    SELECT
        Referee,
        AwayTeam AS Team,
        COUNT(*) AS Wins
    FROM
        season1819
    WHERE
        FTR = 'A'
    GROUP BY
        Referee, AwayTeam
)SELECT
    Referee,
    Team,
    MAX(Wins) AS MostWins
FROM
    RefereeWins
GROUP BY
    Referee, Team
ORDER BY
    MostWins DESC;




--team losses with a particular referee
WITH RefereeLosses AS (
    SELECT
        Referee,
        HomeTeam AS Team,
        COUNT(*) AS Losses
    FROM
        season1819
    WHERE
        FTR = 'A'
    GROUP BY
        Referee, HomeTeam

    UNION ALL
    SELECT
        Referee,
        AwayTeam AS Team,
        COUNT(*) AS Losses
    FROM
        season1819
    WHERE
        FTR = 'H'
    GROUP BY
        Referee, AwayTeam
)SELECT
    Referee,
    Team,
    MAX(Losses) AS MostLosses
FROM
    RefereeLosses
GROUP BY
    Referee, Team
ORDER BY
    MostLosses DESC;



---teams that win at halftime but lose at full time
SELECT
    HomeTeam AS Team,
    COUNT(*) AS Count
FROM
    season1819
WHERE
    HTR = 'H' AND FTR = 'A'
GROUP BY
    HomeTeam

UNION ALL
SELECT
    AwayTeam AS Team,
    COUNT(*) AS Count
FROM
    season1819
    WHERE
    HTR = 'H' AND FTR = 'A'
GROUP BY
    AwayTeam;



--teams that win at halftime and at full time
SELECT
    Team,
    Count
FROM (
    SELECT
        HomeTeam AS Team,
        COUNT(*) AS Count
    FROM
        season1819
    WHERE
        HTR = 'H' AND FTR = 'H'
    GROUP BY
        HomeTeam

    UNION ALL
    SELECT
        AwayTeam AS Team,
        COUNT(*) AS Count
    FROM
        season1819
    WHERE
        HTR = 'H' AND FTR = 'A'
    GROUP BY
        AwayTeam
) AS Combined
ORDER BY
    Count DESC;



--teams that lose at halftime and at full time
SELECT
    Team,
    Count
FROM (
    SELECT
        HomeTeam AS Team,
        COUNT(*) AS Count
    FROM
        season1819
    WHERE
        HTR = 'A' AND FTR = 'A'
    GROUP BY
        HomeTeam

    UNION ALL
    SELECT
        AwayTeam AS Team,
        COUNT(*) AS Count
    FROM
        season1819
    WHERE
        HTR = 'A' AND FTR = 'H'
    GROUP BY
        AwayTeam
) AS Combined
ORDER BY
    Count DESC;



---team with most comebacks (lose at halftime and win at full time)
SELECT
    Team,
    Count
FROM (
    SELECT
        HomeTeam AS Team,
        COUNT(*) AS Count
    FROM
        season1819
    WHERE
        HTR = 'A' AND FTR = 'H'
    GROUP BY
        HomeTeam

    UNION ALL
SELECT
        AwayTeam AS Team,
        COUNT(*) AS Count
    FROM
        season1819
    WHERE
        HTR = 'A' AND FTR = 'A'
    GROUP BY
        AwayTeam
) AS Combined
ORDER BY
    Count DESC;
