-- taken from https://github.com/phadej/github/issues/288

{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE LambdaCase                #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE NamedFieldPuns            #-}

import Data.Foldable
import Data.Maybe
import qualified Data.List as L
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.ByteString.Char8 as BS

import System.Environment ( getArgs, getEnv )
import System.Exit ( exitFailure )
import System.IO ( hPutStrLn, stderr )

import GitHub.Auth ( Auth( OAuth ) )
import GitHub.Data.Issues ( Issue( Issue, issueMilestone, issueNumber, issueTitle, issueClosedBy, issueUrl, issueUser ) )
import GitHub.Data.Name ( Name( N ), untagName )
import GitHub.Data.Milestone ( Milestone( milestoneNumber, milestoneTitle ) )
import GitHub.Data.Options ( stateClosed )
-- Did not help:
-- import GitHub.Data.Options ( IssueState(..), IssueRepoMod(..) ) -- not exported:, FilterBy(..) )
import GitHub.Data.URL ( URL, getUrl )
import GitHub.Data.Definitions ( SimpleUser( simpleUserLogin ) )

import qualified GitHub.Endpoints.Issues.Milestones as GH ( milestones' )
import qualified GitHub.Endpoints.Issues as GH ( issuesForRepo' )

import qualified Data.Map.Strict as M
import Data.List.Split

formatUser :: SimpleUser -> Text
formatUser = untagName . simpleUserLogin

-- convert github login into personal name
convert :: M.Map String String -> String -> String
convert mapping githubid = M.findWithDefault githubid githubid mapping

envGHToken = "GITHUBTOKEN"
owner = "lclem"
repo  = "logic_course"
theRepo = owner ++ "/" ++ repo

compile :: [String] -> M.Map String String
compile [] = M.empty
compile (x:xs) = res
  where
    es = splitOn " " x
    key = es !! 0
    name | length es > 1 = es !! 1
         | otherwise = ""
    surname | length es > 2 = es !! 2
            | otherwise = ""
    value = name ++ " " ++ surname
    res | name /= "" && surname /= "" = M.insert key value (compile xs)
        | otherwise = compile xs

-- we expect just one argument in the example format "lclem Lorenzo Clemente;githublogin Name Surname;"...

main :: IO ()
main = do
  [arg] <- getArgs
  let tuples = splitOn ";" arg
  run (compile tuples)

count :: Eq a => a -> [a] -> Int
count x = length . filter (x==)

-- | Retrieve closed issues for the given milestone and print to stdout.
run :: M.Map String String -> IO ()
run mapping = do

  -- Get authentication token from environment.
  -- auth <- OAuth . BS.pack <$> getEnv envGHToken

  -- Resolve milestone into milestone id.
  -- mileStoneVector <- crashOr $ GH.milestones' Nothing {- (Just auth) -} (N owner) (N repo)
  -- mileStoneId <- case filter ((mileStoneTitle ==) . milestoneTitle) $ toList mileStoneVector of
  --   []  -> die $ "Milestone " ++ Text.unpack mileStoneTitle ++ " not found in github repo " ++ theRepo
  --   [m] -> return $ milestoneNumber m
  --   ms  -> die $ "Milestone " ++ Text.unpack mileStoneTitle ++ " ambiguous in github repo " ++ theRepo

  -- Get list of issues.
  issueVector <- crashOr $ GH.issuesForRepo' Nothing {- (Just auth) -} (N owner) (N repo) $ stateClosed
    -- Symbols not exported, thus, this does not work:
    -- IssueRepoMod $ \ o ->
    --   o { issueRepoOptionsMilestone = FilterBy mileStoneId
    --     , issueRepoOptionsState     = Just StateClosed
    --     }

  -- Filter by milestone.
  let issues = reverse
        [ i
        | i <- toList issueVector
        -- , m <- maybeToList $ issueMilestone i
        -- ,  milestoneNumber m == mileStoneId
        ]

  -- Print issues.
--  forM_ issues $ \ Issue{ issueNumber, issueTitle, issueUser } -> putStrLn $
--    "  [#" ++ show issueNumber
--    ++ "](https://github.com/" ++ theRepo ++ "/issues/" ++ show issueNumber
--    ++ "): " ++ Text.unpack issueTitle ++ " by " ++ (Text.unpack $ formatUser $ issueUser)

  let contributors = [ convert mapping $ Text.unpack $ formatUser $ issueUser issue | issue <- issues ]
  let contributorsNames = map (convert mapping) contributors
  let contributorsNamesClean = L.nub $ L.sort contributorsNames
  let contributorsNamesMultiplicity = map (\ name -> (name, count name contributorsNamesClean)) contributorsNamesClean
  
  forM_ contributorsNamesMultiplicity $ \ (name, n) -> (putStrLn $ name ++ " (" ++ show n ++ ")")
  
-- | Crash on exception.
crashOr :: Show e => IO (Either e a) -> IO a
crashOr m = either (die . show) return =<< m

-- | Crash with error message
die :: String -> IO a
die e = do hPutStrLn stderr e; exitFailure
