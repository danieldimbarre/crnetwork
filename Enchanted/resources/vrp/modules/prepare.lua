-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/Person","SELECT id,Name,Lastname,Sex,Bank,Blood,Prison,Medic,Groups,Skin,License,Created,Login,Deleted FROM characters WHERE id = @id")
vRP.Prepare("characters/Delete","UPDATE characters SET Deleted = 1 WHERE id = @id")
vRP.Prepare("characters/SetSkin","UPDATE characters SET Skin = @Skin WHERE id = @id")
vRP.Prepare("characters/LastLogin","UPDATE characters SET Login = UNIX_TIMESTAMP() WHERE id = @id")
vRP.Prepare("characters/SetMedicplan","UPDATE characters SET Medic = @Medic WHERE id = @id")
vRP.Prepare("characters/AddBank","UPDATE characters SET Bank = Bank + @Bank WHERE id = @id")
vRP.Prepare("characters/RemBank","UPDATE characters SET Bank = Bank - @Bank WHERE id = @id")
vRP.Prepare("characters/SetGroupsTimer","UPDATE characters SET Groups = @Groups WHERE id = @id")
vRP.Prepare("characters/UserLicense","SELECT id,Name,Lastname,Sex,Bank,Blood,Prison,Medic,Groups,Skin,License,Created,Login,Deleted FROM characters WHERE id = @id AND License = @License")
vRP.Prepare("characters/Characters","SELECT id,Name,Lastname,Sex,Bank,Blood,Prison,Medic,Groups,Skin,License,Created,Login,Deleted FROM characters WHERE License = @License AND Deleted = 0")
vRP.Prepare("characters/Count","SELECT COUNT(License) FROM characters WHERE License = @License AND Deleted = 0")
vRP.Prepare("characters/InsertPrison","UPDATE characters SET Prison = Prison + @Prison WHERE id = @id")
vRP.Prepare("characters/ReducePrison","UPDATE characters SET Prison = Prison - @Prison WHERE id = @id")
vRP.Prepare("characters/UpdateName","UPDATE characters SET Name = @Name, Lastname = @Lastname WHERE id = @id")
vRP.Prepare("characters/LastCharacter","SELECT id FROM characters WHERE License = @License ORDER BY id DESC LIMIT 1")
vRP.Prepare("characters/NewCharacter","INSERT INTO characters (License,Name,Lastname,Sex,Skin,Blood,Created) VALUES (@License,@Name,@Lastname,@Sex,@Skin,@Blood,UNIX_TIMESTAMP() + (86400 * 3))")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("smartphone/Phone","SELECT id,owner_id,phone_number,name,pin,face_id,settings,is_setup,assigned,battery FROM phone_phones WHERE owner_id = @owner_id")
vRP.Prepare("smartphone/CheckInstagram","SELECT id,owner_id,phone_number,name,pin,face_id,settings,is_setup,assigned,battery FROM phone_instagram_accounts WHERE phone_number = @phone_number")
vRP.Prepare("smartphone/Instagram","UPDATE phone_instagram_accounts SET follower_count = follower_count + @Amount WHERE phone_number = @phone_number")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/All","SELECT id,Whitelist,Characters,Gemstone,Premium,Level,Banned,License,Discord,Login,Token FROM accounts")
vRP.Prepare("accounts/Token","SELECT id,Whitelist,Characters,Gemstone,Premium,Level,Banned,License,Discord,Login,Token FROM accounts WHERE Token = @Token")
vRP.Prepare("accounts/Account","SELECT id,Whitelist,Characters,Gemstone,Premium,Level,Banned,License,Discord,Login,Token FROM accounts WHERE License = @License")
vRP.Prepare("accounts/Clean","UPDATE accounts SET Whitelist = 0 WHERE License = @License")
vRP.Prepare("accounts/RemoveBanned","UPDATE accounts SET Banned = 0 WHERE License = @License")
vRP.Prepare("accounts/NewAccount","INSERT INTO accounts (License,Token) VALUES (@License,@Token)")
vRP.Prepare("accounts/LastLogin","UPDATE accounts SET Login = UNIX_TIMESTAMP() WHERE License = @License")
vRP.Prepare("accounts/AddGemstone","UPDATE accounts SET Gemstone = Gemstone + @Gemstone WHERE License = @License")
vRP.Prepare("accounts/SetPremium","UPDATE accounts SET Premium = @Premium, Level = @Level WHERE License = @License")
vRP.Prepare("accounts/UpdateCharacters","UPDATE accounts SET Characters = Characters + 1 WHERE License = @License")
vRP.Prepare("accounts/RemoveGemstone","UPDATE accounts SET Gemstone = Gemstone - @Gemstone WHERE License = @License")
vRP.Prepare("accounts/InsertBanned","UPDATE accounts SET Banned = UNIX_TIMESTAMP() + (86400 * @Days) WHERE License = @License")
vRP.Prepare("accounts/UpgradePremium","UPDATE accounts SET Premium = Premium + (86400 * 30), Level = @Level WHERE License = @License")
vRP.Prepare("accounts/Minimals","SELECT id,Whitelist,Characters,Gemstone,Premium,Level,Banned,License,Discord,Login,Token FROM accounts WHERE Login <= UNIX_TIMESTAMP() - (86400 * 15) AND License <> 0 AND Whitelist = 1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("playerdata/GetData","SELECT Passport,Name,Information FROM playerdata WHERE Passport = @Passport AND Name = @Name")
vRP.Prepare("playerdata/SetData","REPLACE INTO playerdata (Passport,Name,Information) VALUES (@Passport,@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("entitydata/GetData","SELECT Name,Information FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/RemoveData","DELETE FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/SetData","REPLACE INTO entitydata (Name,Information) VALUES (@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/All","SELECT id,Passport,Vehicle,Tax,Plate,Weight,Save,Rental,Arrest,Block,Engine,Body,Health,Fuel,Nitro,Work,Doors,Windows,Tyres,Seatbelt,Drift FROM vehicles")
vRP.Prepare("vehicles/plateVehicles","SELECT id,Passport,Vehicle,Tax,Plate,Weight,Save,Rental,Arrest,Block,Engine,Body,Health,Fuel,Nitro,Work,Doors,Windows,Tyres,Seatbelt,Drift FROM vehicles WHERE Plate = @Plate")
vRP.Prepare("vehicles/Arrest","UPDATE vehicles SET Arrest = 1 WHERE Plate = @Plate")
vRP.Prepare("vehicles/UserVehicles","SELECT id,Passport,Vehicle,Tax,Plate,Weight,Save,Rental,Arrest,Block,Engine,Body,Health,Fuel,Nitro,Work,Doors,Windows,Tyres,Seatbelt,Drift FROM vehicles WHERE Passport = @Passport")
vRP.Prepare("vehicles/Count","SELECT COUNT(Vehicle) FROM vehicles WHERE Vehicle = @Vehicle")
vRP.Prepare("vehicles/Minimals","SELECT id,Passport,Vehicle,Tax,Plate,Weight,Save,Rental,Arrest,Block,Engine,Body,Health,Fuel,Nitro,Work,Doors,Windows,Tyres,Seatbelt,Drift FROM vehicles WHERE Tax + (86400 * 15) <= UNIX_TIMESTAMP()")
vRP.Prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/selectVehicles","SELECT id,Passport,Vehicle,Tax,Plate,Weight,Save,Rental,Arrest,Block,Engine,Body,Health,Fuel,Nitro,Work,Doors,Windows,Tyres,Seatbelt,Drift FROM vehicles WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/CoiloverVehicles","UPDATE vehicles SET Drift = 1 WHERE Vehicle = @Vehicle AND Plate = @Plate")
vRP.Prepare("vehicles/UpdateSave","UPDATE vehicles SET Save = @Save WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/SeatbeltVehicles","UPDATE vehicles SET Seatbelt = 1 WHERE Plate = @Plate AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/PaymentArrest","UPDATE vehicles SET Arrest = 0 WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/PlateUsers","SELECT id,Passport,Vehicle,Tax,Plate,Weight,Save,Rental,Arrest,Block,Engine,Body,Health,Fuel,Nitro,Work,Doors,Windows,Tyres,Seatbelt,Drift FROM vehicles WHERE Plate = @Plate AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/PlateOwner","SELECT id,Passport,Vehicle,Tax,Plate,Weight,Save,Rental,Arrest,Block,Engine,Body,Health,Fuel,Nitro,Work,Doors,Windows,Tyres,Seatbelt,Drift FROM vehicles WHERE Plate = @Plate AND Vehicle = @Vehicle AND Passport = @Passport")
vRP.Prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET Plate = @NewPlate WHERE Plate = @Plate AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/moveVehicles","UPDATE vehicles SET Passport = @OtherPassport WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET Rental = Rental + (86400 * 30) WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/UpdateWeight","UPDATE vehicles SET Weight = Weight + (10 * @Multiplier) WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET Tax = UNIX_TIMESTAMP() + (86400 * 30) WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET Rental = UNIX_TIMESTAMP() + (86400 * 30) WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles (Passport,Vehicle,Plate,Weight,Work,Tax) VALUES (@Passport,@Vehicle,@Plate,@Weight,@Work,UNIX_TIMESTAMP() + (86400 * 7))")
vRP.Prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles (Passport,Vehicle,Plate,Weight,Work,Rental,Tax) VALUES (@Passport,@Vehicle,@Plate,@Weight,@Work,UNIX_TIMESTAMP() + (86400 * 30),UNIX_TIMESTAMP() + (86400 * 7))")
vRP.Prepare("vehicles/updateVehicles","UPDATE vehicles SET Engine = @Engine, Body = @Body, Health = @Health, Fuel = @Fuel, Doors = @Doors, Windows = @Windows, Tyres = @Tyres, Nitro = @Nitro WHERE Passport = @Passport AND Vehicle = @Vehicle")
vRP.Prepare("vehicles/updateVehiclesSave","UPDATE vehicles SET Engine = @Engine, Body = @Body, Health = @Health, Fuel = @Fuel, Doors = @Doors, Windows = @Windows, Tyres = @Tyres, Nitro = @Nitro, Save = @Save WHERE Passport = @Passport AND Vehicle = @Vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("chests/GetChests","SELECT id,Name,Weight,Slots,Permission,Logs FROM chests WHERE Name = @Name")
vRP.Prepare("chests/AddChests","INSERT IGNORE INTO chests (Name,Permission) VALUES (@Name,@Name)")
vRP.Prepare("chests/UpdateWeight","UPDATE chests SET Weight = Weight + (10 * @Multiplier), Slots = Slots + (5 * @Multiplier) WHERE Name = @Name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("propertys/All","SELECT id,Name,Interior,Item,Tax,Passport,Serial,Vault,Fridge,Garage FROM propertys")
vRP.Prepare("propertys/Sell","DELETE FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Exist","SELECT id,Name,Interior,Item,Tax,Passport,Serial,Vault,Fridge,Garage FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Serial","SELECT id,Name,Interior,Item,Tax,Passport,Serial,Vault,Fridge,Garage FROM propertys WHERE Serial = @Serial")
vRP.Prepare("propertys/Garages","SELECT id,Name,Interior,Item,Tax,Passport,Serial,Vault,Fridge,Garage FROM propertys WHERE Garage IS NOT NULL")
vRP.Prepare("propertys/AllUser","SELECT id,Name,Interior,Item,Tax,Passport,Serial,Vault,Fridge,Garage FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Item","UPDATE propertys SET Item = Item + 1 WHERE Name = @Name")
vRP.Prepare("propertys/Garage","UPDATE propertys SET Garage = @Garage WHERE Name = @Name")
vRP.Prepare("propertys/Credentials","UPDATE propertys SET Serial = @Serial WHERE Name = @Name")
vRP.Prepare("propertys/Count","SELECT COUNT(Passport) FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Vault","UPDATE propertys SET Vault = Vault + @Weight WHERE Name = @Name")
vRP.Prepare("propertys/Transfer","UPDATE propertys SET Passport = @Passport WHERE Name = @Name")
vRP.Prepare("propertys/Fridge","UPDATE propertys SET Fridge = Fridge + @Weight WHERE Name = @Name")
vRP.Prepare("propertys/Check","SELECT id,Name,Interior,Item,Tax,Passport,Serial,Vault,Fridge,Garage FROM propertys WHERE Name = @Name AND Passport = @Passport")
vRP.Prepare("propertys/Minimals","SELECT id,Name,Interior,Item,Tax,Passport,Serial,Vault,Fridge,Garage FROM propertys WHERE Tax <= UNIX_TIMESTAMP() - (86400 * 15)")
vRP.Prepare("propertys/Tax","UPDATE propertys SET Tax = UNIX_TIMESTAMP() + (86400 * 30) WHERE Name = @Name")
vRP.Prepare("propertys/Buy","INSERT INTO propertys (Name,Interior,Passport,Serial,Vault,Fridge,Tax) VALUES (@Name,@Interior,@Passport,@Serial,@Vault,@Fridge,UNIX_TIMESTAMP() + (86400 * 30))")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fines/List","SELECT id,Passport,Name,Date,Hour,Price,Message FROM fines WHERE Passport = @Passport")
vRP.Prepare("fines/Remove","DELETE FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Check","SELECT id,Passport,Name,Date,Hour,Price,Message FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Add","INSERT INTO fines (Passport,Name,Date,Hour,Price,Message) VALUES (@Passport,@Name,@Date,@Hour,@Price,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("taxs/Remove","DELETE FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/List","SELECT id,Passport,Name,Date,Hour,Price,Message FROM taxs WHERE Passport = @Passport")
vRP.Prepare("taxs/Check","SELECT id,Passport,Name,Date,Hour,Price,Message FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Add","INSERT INTO taxs (Passport,Name,Date,Hour,Price,Message) VALUES (@Passport,@Name,@Date,@Hour,@Price,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("transactions/List","SELECT id,Passport,Type,Date,Price,Balance,Timeset FROM transactions WHERE Passport = @Passport ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("transactions/Add","INSERT INTO transactions (Passport,Type,Date,Price,Balance,Timeset) VALUES (@Passport,@Type,@Date,@Price,@Balance,UNIX_TIMESTAMP() + (86400 * 30))")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("dependents/List","SELECT id,Passport,Dependent,Name FROM dependents WHERE Passport = @Passport")
vRP.Prepare("dependents/Remove","DELETE FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Check","SELECT id,Passport,Dependent,Name FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Add","INSERT INTO dependents (Passport,Dependent,Name) VALUES (@Passport,@Dependent,@Name)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("invoices/Remove","DELETE FROM invoices WHERE id = @id")
vRP.Prepare("invoices/Check","SELECT id,Passport,Received,Type,Reason,Holder,Price FROM invoices WHERE id = @id")
vRP.Prepare("invoices/List","SELECT id,Passport,Received,Type,Reason,Holder,Price FROM invoices WHERE Passport = @Passport")
vRP.Prepare("invoices/Add","INSERT INTO invoices (Passport,Received,Type,Reason,Holder,Price) VALUES (@Passport,@Received,@Type,@Reason,@Holder,@Price)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("investments/Remove","DELETE FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Check","SELECT id,Passport,Liquid,Monthly,Deposit,Last FROM investments  WHERE Passport = @Passport")
vRP.Prepare("investments/Add","INSERT INTO investments (Passport,Deposit,Last) VALUES (@Passport,@Deposit,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("investments/Invest","UPDATE investments SET Deposit = Deposit + @Price, Last = UNIX_TIMESTAMP() + 86400 WHERE Passport = @Passport")
vRP.Prepare("investments/Actives","UPDATE investments SET Monthly = Monthly + FLOOR((Deposit + Liquid) * 0.005), Liquid = Liquid + FLOOR((Deposit + Liquid) * 0.005), Last = UNIX_TIMESTAMP() + 86400 WHERE Last < UNIX_TIMESTAMP()")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HWID
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("hwid/All","UPDATE hwid SET Banned = @Banned WHERE Account = @Account")
vRP.Prepare("hwid/Check","SELECT id,Account,Token,Banned FROM hwid WHERE Token = @Token")
vRP.Prepare("hwid/Insert","INSERT INTO hwid (Token,Account) VALUES (@Token,@Account)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("summerz/Transactions","DELETE FROM transactions WHERE Timeset <= UNIX_TIMESTAMP()")
vRP.Prepare("summerz/Playerdata","DELETE FROM playerdata WHERE Information IN ('[]','{}','null')")
vRP.Prepare("summerz/Entitydata","DELETE FROM entitydata WHERE Information IN ('[]','{}','null')")
vRP.Prepare("summerz/Premium","UPDATE accounts SET Premium = '0', Level = '0' WHERE UNIX_TIMESTAMP() >= Premium")
vRP.Prepare("summerz/Phone","DELETE FROM phone_message_messages WHERE timestamp < UNIX_TIMESTAMP() - (86400 * 7)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("Races/Insert","INSERT INTO races (Mode,Race,Passport,Vehicle,Points) VALUES (@Mode,@Race,@Passport,@Vehicle,@Points)")
vRP.Prepare("Races/User","SELECT id,Mode,Race,Passport,Vehicle,Points FROM races WHERE Race = @Race AND Mode = @Mode AND Passport = @Passport")
vRP.Prepare("Races/Update","UPDATE races SET Points = @Points, Vehicle = @Vehicle WHERE Race = @Race AND Mode = @Mode AND Passport = @Passport")
vRP.Prepare("Races/Consult","SELECT id,Mode,Race,Passport,Vehicle,Points FROM races WHERE Race = @Race AND Mode = @Mode ORDER BY Points ASC LIMIT @Count")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.Query("summerz/Phone")
	vRP.Query("summerz/Premium")
	vRP.Query("summerz/Playerdata")
	vRP.Query("summerz/Entitydata")
	vRP.Query("summerz/Transactions")
end)