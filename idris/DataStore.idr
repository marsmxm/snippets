module Main

import Data.Vect

data DataStore : Type where
     MkData : (size : Nat) -> (items : Vect size String) ->
              DataStore

size : DataStore -> Nat
size (MkData size' items') = size'

items : (store : DataStore) -> Vect (size store) String
items (MkData size' items') = items'

addToStore : DataStore -> String -> DataStore
addToStore (MkData size items) newitem = MkData _ (addToData items)
  where
    addToData : Vect old String -> Vect (S old) String
    addToData [] = [newitem]
    addToData (item :: items') = item :: addToData items'


data Command = Add String
             | Get Integer
             | Search String
             | Size
             | Quit

parseCommand : (cmd : String) -> (args : String) -> Maybe Command
parseCommand "add" str = Just (Add str)
parseCommand "get" val = case all isDigit (unpack val) of
                              False => Nothing
                              True => Just (Get (cast val))
parseCommand "size" _ = Just Size
parseCommand "search" str = Just (Search str)
parseCommand "quit" _ = Just Quit
parseCommand _ _ = Nothing


parse : (input : String) -> Maybe Command
parse input = case span (/= ' ') input of
                   (cmd, args) => parseCommand cmd (ltrim args)


getEntry : (pos : Integer) -> (store : DataStore) ->
           Maybe (String, DataStore)
getEntry pos store = let store_items = items store in
                     case integerToFin pos (size store) of
                          Nothing => Just ("Out of range\n", store)
                          Just id => Just (index id store_items ++ "\n", store)

contains : String -> (Nat, String) -> Bool
contains str (idx, content) = (isInfixOf str content)

searchEntries : (str : String) -> (store : DataStore) -> Maybe (String, DataStore)
searchEntries str store@(MkData Z items') = Just ("\n", store)
searchEntries str store@(MkData (S k) items') =
  let idx_item_pairs = zip (fromList [0..k]) items' in
      case filter (contains str) idx_item_pairs of
           (len ** xs) => Just ("Search Result: " ++ show xs ++ "\n", store)


processInput : DataStore -> String -> Maybe (String, DataStore)
processInput store inp = case parse inp of
                              Nothing => Just ("Invalid command\n", store)
                              Just (Add item) =>
                                Just ("ID " ++ show (size store) ++ "\n", addToStore store item)
                              Just (Get pos) => getEntry pos store
                              Just (Search str) => searchEntries str store
                              Just Size => Just ("Size: " ++ show (size store) ++ "\n", store)
                              Just Quit => Nothing



main : IO ()
main = replWith (MkData _ []) "Command: " processInput
