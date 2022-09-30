vRP.Identities(source: int)

vRP.Archive(Archive: string,Text: string)

vRP.Prepare(Name: string,Query: string)

vRP.Query(Name: string,Params: string)

vRP.Banned(License: string)

vRP.Account(License: string)

vRP.UserData(Passport: int,Key: string)

vRP.InsidePropertys(Passport: int,Coords)

vRP.Inventory(Passport: int)

vRP.SkinCharacter(Passport: int,Hash: string)

vRP.Passport(source: int)

vRP.Source(Passport: int)

vRP.Datatable(Passport: int)

vRP.Kick(Passport: int,Reason: string)

vRP.DataGroups(Group: string)

vRP.HasPermission(Passport: int,Permission: string)

vRP.SetPermission(Passport: int,Permission: string)

vRP.RemovePermission(Passport: int,Permission: string)

vRP.HasGroup(Passport: int,Permission: string)

vRP.NumPermission(Permission: string)

vRP.AddPermission(source: int,Passport: int,Permission: string)

vRP.BlankPermission(Passport: int,Permission: string)

vRP.Identity(Passport: int)

vRP.InitPrison(source: int,Passport: int,Amount: int)

vRP.UpdatePrison(Passport: int,source: int,Amount: int)

vRP.UpgradeChars(source: int)

vRP.UserGemstone(License: string)

vRP.UpgradeGemstone(source: int,Amount: int)

vRP.UpgradeNames(source: int,Passport: int,Name: string,Name2: string)

vRP.UpgradePhone(source: int,Passport: int,Phone: string)

vRP.PassportPlate(Plate: string)

vRP.UserPhone(Phone: string)

vRP.GenerateString(Format: string)

vRP.ConsultItem(Passport: int,Item: string,Amount)

vRP.GetWeight(Passport: int)

vRP.SetWeight(Passport: int,Amount: int)

vRP.SwapSlot(Passport: int,Slot: int,Target: int)

vRP.InventoryWeight(Passport: int)

vRP.CheckDamaged(Item: string)

vRP.ChestWeight(Data: table)

vRP.InventoryItemAmount(Passport: int,Item: string)

vRP.InventoryFull(Passport: int,Item: string)

vRP.ItemAmount(Passport: int,Item: string)

vRP.GiveItem(Passport: int,Item: string,Amount: int,Notify: bool,Slot: int)

vRP.GenerateItem(Passport: int,Item: string,Amount: int,Notify: bool,Slot: int)

vRP.MaxItens(Passport: int,Item: string,Amount: int)

vRP.TakeItem(Passport: int,Item: string,Amount: int,Notify: bool,Slot: int)

vRP.RemoveItem(Passport: int,Item: string,Amount: int,Notify: bool)

vRP.GetSrvData(Key: string)

vRP.SetSrvData(Key: string,Data: table)

vRP.RemSrvData(Key: string)

vRP.TakeChest(Passport: int,Data: string,Amount: int,Slot: int,Target: int)

vRP.StoreChest(Passport: int,Data: string,Amount: int,Weight: int,Slot: int,Target: int)

vRP.UpdateChest(Passport: int,Data: string,Slot: int,Target: int,Amount: int)

vRP.DirectChest(Chest: string,Amount: int)

vRP.UserBank(Passport: int,Mode: string)

vRP.GiveBank(Passport: int,Amount: int,Mode: string)

vRP.RemoveBank(Passport: int,Amount: int,Mode: string)

vRP.GetBank(source: int)

vRP.GetFine(source: int)

vRP.GiveFine(Passport: int,Amount: int,source: int)

vRP.RemoveFine(Passport: int,Amount: int,source: int)

vRP.PaymentGems(source: int,Amount: int)

vRP.PaymentBank(source: int,Passport: int,Amount: int)

vRP.PaymentFull(Passport: int,source: int,Amount: int)

vRP.WithdrawCash(Passport: int,source: int,Amount: int)

vRP.UpdateRolepass(source: int,Day: int)

vRP.CheckRolepass(source: int)

vRP.UpgradeThirst(Passport: int,Amount: int)

vRP.UpgradeHunger(Passport: int,Amount: int)

vRP.UpgradeStress(Passport: int,Amount: int)

vRP.DowngradeThirst(Passport: int,Amount: int)

vRP.DowngradeHunger(Passport: int,Amount: int)

vRP.DowngradeStress(Passport: int,Amount: int)

vRP.GetHealth(source: int)

vRP.ModelPlayer(source: int)

vRP.GetExperience(Passport: int,Work: string)

vRP.PutExperience(Passport: int,Work: string,Number)

vRP.SetArmour(source: int,Amount: int)

vRP.Teleport(source: int,x: number,y: number,z: number)

vRP.GetEntityCoords(source: int)

vRP.SetPremium(source: int)

vRP.UpgradePremium(source: int)

vRP.UserPremium(Passport: int)

vRP.LicensePremium(License: string)