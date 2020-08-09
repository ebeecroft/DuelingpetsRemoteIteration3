module InventoryslotsHelper

   private
      def getInventoryslotParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "InventoryId")
            value = params[:inventory_id]
         elsif(type == "Inventoryslot")
            value = params.require(:inventoryslot).permit(:name, :inventory_id)
         elsif(type == "ItemId")
            value = params[:inventoryslot][:item_id]
         elsif(type == "SlotId")
            value = params[:inventoryslot][:inventoryslot_id]
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def checkSlot(slotFound)
         noItems = false
         slota = ((slotFound.item1_id.nil? && slotFound.item2_id.nil?) && (slotFound.item3_id.nil? && slotFound.item4_id.nil?))
         slotb = ((slotFound.item5_id.nil? && slotFound.item6_id.nil?) && (slotFound.item7_id.nil? && slotFound.item8_id.nil?))
         slotc = ((slotFound.item9_id.nil? && slotFound.item10_id.nil?) && (slotFound.item11_id.nil? && slotFound.item12_id.nil?))
         slotd = (slotFound.item13_id.nil? && slotFound.item14_id.nil?)
         if(slota && slotb && slotc && slotd)
            noItems = true
         end
         return noItems
      end

      def getItem(itemid, type)
         item = Item.find_by_id(itemid)
         value = ""
         if(type == "Name")
            value = item.name
         elsif(type == "Atk")
            value = item.atk
         elsif(type == "Def")
            value = item.def
         elsif(type == "Agility")
            value = item.agility
         elsif(type == "Strength")
            value = item.strength
         elsif(type == "HP")
            value = item.hp
         elsif(type == "MP")
            value = item.mp
         elsif(type == "Itemtype")
            value = item.itemtype.name
         elsif(type == "Fun")
            value = item.fun
         elsif(type == "Hunger")
            value = item.hunger
         elsif(type == "Thirst")
            value = item.thirst
         elsif(type == "Matk")
            value = item.matk
         elsif(type == "Mdef")
            value = item.mdef
         elsif(type == "Magi")
            value = item.magi
         elsif(type == "Mstr")
            value = item.mstr
         elsif(type == "Cost")
            value = item.cost
         elsif(type == "Emerald")
            value = item.emeraldcost
         elsif(type == "Artist")
            value = item.user
         elsif(type == "Equip")
            value = item.equipable
         elsif(type == "Retired")
            value = item.retireditem
         elsif(type == "Rarity")
            value = item.rarity
         elsif(type == "Itemartcheck" || type == "Itemart")
            value = item.itemart
            if(type == "Itemart")
               value = item.itemart_url(:thumb)
            end
         else
            raise "Invalid choice selected!"
         end
         return value
      end

      def itemView(item_id, qty)
         msg1 = ""
         msg2 = ""
         msg3 = ""
         msg4 = ""
         if(getItem(item_id, "Itemtype") != "Battleitems")
            msg1 = content_tag(:p, "Attack: #{getItem(item_id, "Atk")}")
            msg2 = content_tag(:p, "Defense: #{getItem(item_id, "Def")}")
            msg3 = content_tag(:p, "Agility: #{getItem(item_id, "Agility")}")
            msg4 = content_tag(:p, "Strength: #{getItem(item_id, "Strength")}")
         elsif(getItem(inventoryslot.item1_id, "Itemtype") != "Magicitems")
            msg1 = content_tag(:p, "Matk: #{getItem(item_id, "Matk")}")
            msg2 = content_tag(:p, "Mdef: #{getItem(item_id, "Mdef")}")
            msg3 = content_tag(:p, "Magi: #{getItem(item_id, "Magi")}")
            msg4 = content_tag(:p, "Mstr: #{getItem(item_id, "Mstr")}")
         else
            msg1 = content_tag(:p, "HP: #{getItem(item_id, "HP")}")
            msg2 = content_tag(:p, "MP: #{getItem(item_id, "MP")}")
            msg3 = content_tag(:p, "Hunger: #{getItem(item_id, "Hunger")}")
            msg4 = content_tag(:p, "Thirst: #{getItem(item_id, "Thirst")}")
            msg5 = content_tag(:p, "Fun: #{getItem(item_id, "Fun")}")
         end
         qtymsg = content_tag(:p, "Quantity: #{qty}")
         rarity = content_tag(:p, "Rarity: #{getItem(item_id, "Rarity")}")
         cost = content_tag(:p, "Cost: #{getItem(item_id, "Cost")}")
         emerald = content_tag(:p, "Emerald cost: #{getItem(item_id, "Emerald")}")
         itemInfo = (msg1 + msg2 + msg3 + msg4 + qtymsg + rarity + cost + emerald)
         return itemInfo
      end

      def itemView2(item_id, curdur, startdur, type)
         if(type == "Middle")
            itemInfo = content_tag(:p, "Durability: #{curdur}/#{startdur}")
         else
            equips = content_tag(:p, "Equipable: #{getItem(item_id, "Equip")}")
            itemtype = content_tag(:p, "Type: #{getItem(item_id, "Itemtype")}")
            itemInfo = (equips + itemtype)
         end
         return itemInfo
      end

      def storeitem(slotFound, itemFound)
         noRoom = false
         itemMatch = false
         if(!slotFound.item1_id.nil? && (slotFound.item1_id == itemFound.id && slotFound.startdur1 == itemFound.durability))
            slotFound.qty1 += 1
            itemMatch = true
         elsif(!slotFound.item2_id.nil? && (slotFound.item2_id == itemFound.id && slotFound.startdur2 == itemFound.durability))
            slotFound.qty2 += 1
            itemMatch = true
         elsif(!slotFound.item3_id.nil? && (slotFound.item3_id == itemFound.id && slotFound.startdur3 == itemFound.durability))
            slotFound.qty3 += 1
            itemMatch = true
         elsif(!slotFound.item4_id.nil? && (slotFound.item4_id == itemFound.id && slotFound.startdur4 == itemFound.durability))
            slotFound.qty4 += 1
            itemMatch = true
         elsif(!slotFound.item5_id.nil? && (slotFound.item5_id == itemFound.id && slotFound.startdur5 == itemFound.durability))
            slotFound.qty5 += 1
            itemMatch = true
         elsif(!slotFound.item6_id.nil? && (slotFound.item6_id == itemFound.id && slotFound.startdur6 == itemFound.durability))
            slotFound.qty6 += 1
            itemMatch = true
         elsif(!slotFound.item7_id.nil? && (slotFound.item7_id == itemFound.id && slotFound.startdur7 == itemFound.durability))
            slotFound.qty7 += 1
            itemMatch = true
         elsif(!slotFound.item8_id.nil? && (slotFound.item8_id == itemFound.id && slotFound.startdur8 == itemFound.durability))
            slotFound.qty8 += 1
            itemMatch = true
         elsif(!slotFound.item9_id.nil? && (slotFound.item9_id == itemFound.id && slotFound.startdur9 == itemFound.durability))
            slotFound.qty9 += 1
            itemMatch = true
         elsif(!slotFound.item10_id.nil? && (slotFound.item10_id == itemFound.id && slotFound.startdur10 == itemFound.durability))
            slotFound.qty10 += 1
            itemMatch = true
         elsif(!slotFound.item11_id.nil? && (slotFound.item11_id == itemFound.id && slotFound.startdur11 == itemFound.durability))
            slotFound.qty11 += 1
            itemMatch = true
         elsif(!slotFound.item12_id.nil? && (slotFound.item12_id == itemFound.id && slotFound.startdur12 == itemFound.durability))
            slotFound.qty12 += 1
            itemMatch = true
         elsif(!slotFound.item13_id.nil? && (slotFound.item13_id == itemFound.id && slotFound.startdur13 == itemFound.durability))
            slotFound.qty13 += 1
            itemMatch = true
         elsif(!slotFound.item14_id.nil? && (slotFound.item14_id == itemFound.id && slotFound.startdur14 == itemFound.durability))
            slotFound.qty14 += 1
            itemMatch = true
         end

         if(!itemMatch)
            if(slotFound.item1_id.nil?)
               slotFound.item1_id = itemFound.id
               slotFound.curdur1 = itemFound.durability
               slotFound.startdur1 = itemFound.durability
               slotFound.qty1 = 1
               slotFound.rarity1 = itemFound.rarity
            elsif(slotFound.item2_id.nil?)
               slotFound.item2_id = itemFound.id
               slotFound.curdur2 = itemFound.durability
               slotFound.startdur2 = itemFound.durability
               slotFound.qty2 = 1
               slotFound.rarity2 = itemFound.rarity
            elsif(slotFound.item3_id.nil?)
               slotFound.item3_id = itemFound.id
               slotFound.curdur3 = itemFound.durability
               slotFound.startdur3 = itemFound.durability
               slotFound.qty3 = 1
               slotFound.rarity3 = itemFound.rarity
            elsif(slotFound.item4_id.nil?)
               slotFound.item4_id = itemFound.id
               slotFound.curdur4 = itemFound.durability
               slotFound.startdur4 = itemFound.durability
               slotFound.qty4 = 1
               slotFound.rarity4 = itemFound.rarity
            elsif(slotFound.item5_id.nil?)
               slotFound.item5_id = itemFound.id
               slotFound.curdur5 = itemFound.durability
               slotFound.startdur5 = itemFound.durability
               slotFound.qty5 = 1
               slotFound.rarity5 = itemFound.rarity
            elsif(slotFound.item6_id.nil?)
               slotFound.item6_id = itemFound.id
               slotFound.curdur6 = itemFound.durability
               slotFound.startdur6 = itemFound.durability
               slotFound.qty6 = 1
               slotFound.rarity6 = itemFound.rarity
            elsif(slotFound.item7_id.nil?)
               slotFound.item7_id = itemFound.id
               slotFound.curdur7 = itemFound.durability
               slotFound.startdur7 = itemFound.durability
               slotFound.qty7 = 1
               slotFound.rarity7 = itemFound.rarity
            elsif(slotFound.item8_id.nil?)
               slotFound.item8_id = itemFound.id
               slotFound.curdur8 = itemFound.durability
               slotFound.startdur8 = itemFound.durability
               slotFound.qty8 = 1
               slotFound.rarity8 = itemFound.rarity
            elsif(slotFound.item9_id.nil?)
               slotFound.item9_id = itemFound.id
               slotFound.curdur9 = itemFound.durability
               slotFound.startdur9 = itemFound.durability
               slotFound.qty9 = 1
               slotFound.rarity9 = itemFound.rarity
            elsif(slotFound.item10_id.nil?)
               slotFound.item10_id = itemFound.id
               slotFound.curdur10 = itemFound.durability
               slotFound.startdur10 = itemFound.durability
               slotFound.qty10 = 1
               slotFound.rarity10 = itemFound.rarity
            elsif(slotFound.item11_id.nil?)
               slotFound.item11_id = itemFound.id
               slotFound.curdur11 = itemFound.durability
               slotFound.startdur11 = itemFound.durability
               slotFound.qty11 = 1
               slotFound.rarity11 = itemFound.rarity
            elsif(slotFound.item12_id.nil?)
               slotFound.item12_id = itemFound.id
               slotFound.curdur12 = itemFound.durability
               slotFound.startdur12 = itemFound.durability
               slotFound.qty12 = 1
               slotFound.rarity12 = itemFound.rarity
            elsif(slotFound.item13_id.nil?)
               slotFound.item13_id = itemFound.id
               slotFound.curdur13 = itemFound.durability
               slotFound.startdur13 = itemFound.durability
               slotFound.qty13 = 1
               slotFound.rarity13 = itemFound.rarity
            elsif(slotFound.item14_id.nil?)
               slotFound.item14_id = itemFound.id
               slotFound.curdur14 = itemFound.durability
               slotFound.startdur14 = itemFound.durability
               slotFound.qty14 = 1
               slotFound.rarity14 = itemFound.rarity
            else
               noRoom = true
            end
         end
         return noRoom
      end

      def editCommons(type)
         slotFound = Inventoryslot.find_by_id(getInventoryslotParams("Id"))
         if(slotFound)
            logged_in = current_user
            if(logged_in && ((logged_in.inventory.id == slotFound.inventory_id) || logged_in.pouch.privilege == "Admin"))
               @inventoryslot = slotFound
               @inventory = Inventory.find_by_id(slotFound.inventory.id)
               if(type == "update")
                  if(@inventoryslot.update_attributes(getInventoryslotParams("Inventoryslot")))
                     flash[:success] = "Inventoryslot #{@inventoryslot.name} was successfully updated."
                     redirect_to user_inventory_path(@inventory.user, @inventory)
                  else
                     render "edit"
                  end
               elsif(type == "destroy")
                  if(checkSlot(slotFound))
                     @inventoryslot.destroy
                     flash[:success] = "Inventory slot #{slotFound.name} was successfully removed!"
                     redirect_to user_inventory_path(@inventoy.user, @inventory)
                  else
                     flash[:error] = "Slot #{slotFound.name} has items and can't be removed!"
                     redirect_to root_path
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/crazybat"
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  allInvs = Inventoryslot.all
                  @inventoryslots = Kaminari.paginate_array(allInvs).page(getInventoryslotParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               itemMode = Maintenancemode.find_by_id(9)
               if(allMode.maintenance_on || itemMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/items/maintenance"
                  end
               else
                  logged_in = current_user
                  inventoryFound = Inventory.find_by_id(getInventoryslotParams("InventoryId"))
                  if((logged_in && inventoryFound) && (logged_in.id == inventoryFound.user_id))
                     newSlot = inventoryFound.inventoryslots.new
                     if(type == "create")
                        newSlot = inventoryFound.inventoryslots.new(getInventoryslotParams("Inventoryslot"))
                     end
                     @inventory = inventoryFound
                     @inventoryslot = newSlot
                     if(type == "create")
                        invslotcost = Fieldcost.find_by_name("Inventoryslot")
                        if(logged_in.pouch.amount - invslotcost.amount >= 0)
                           if(@inventoryslot.save)
                              logged_in.pouch.amount -= invslotcost.amount
                              @pouch = logged_in.pouch
                              @pouch.save
                              flash[:success] = "#{@inventoryslot.name} was successfully created."
                              redirect_to user_inventory_path(@inventory.user, @inventory)
                           else
                              render "new"
                           end
                        else
                           flash[:error] = "Insufficient funds to create an inventoryslot!"
                           redirect_to user_path(logged_in.id)
                        end
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  itemMode = Maintenancemode.find_by_id(9)
                  if(allMode.maintenance_on || itemMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/items/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "purchase")
               logged_in = current_user
               itemFound = Item.find_by_id(getInventoryslotParams("ItemId"))
               slotFound = Inventoryslot.find_by_id(getInventoryslotParams("SlotId"))
               if(logged_in && itemFound && slotFound && slotFound.inventory_id == logged_in.inventory.id)
                  #Store item only if there is space
                  noRoom = storeitem(slotFound, itemFound)
                  if(!noRoom)
                     affordItem = ((logged_in.pouch.amount - itemFound.cost >= 0) && (logged_in.pouch.emeraldamount - itemFound.emeraldcost >= 0))
                     if(affordItem)
                        #Purchases the item
                        logged_in.pouch.amount -= itemFound.cost
                        logged_in.pouch.emeraldamount -= itemFound.emeraldcost
                        @pouch = logged_in.pouch
                        @pouch.save

                        #Eventually make sure that owners get points later on sells!

                        #Saves the item
                        @inventoryslot = slotFound
                        @inventoryslot.save
                        flash[:success] = "Item #{itemFound.name} was added to the inventory!"
                        redirect_to user_inventory_path(@inventoryslot.inventory.user, @inventoryslot.inventory)
                     else
                        flash[:error] = "Insufficient funds to purchase a #{itemFound.name}!"
                        redirect_to user_path(logged_in.id)
                     end
                  else
                     flash[:error] = "No room to store #{itemFound.name}!"
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
