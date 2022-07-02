-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal','Acc','FullAcc','Fodder')
    state.HybridMode:options('Pet','DT','Normal')
    state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
    state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal','PDT','Refresh')
	state.Weapons:options('None','Godhands','PetWeapons')

    -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
	defaultManeuvers = {
		Melee = {
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
			{Name='Wind Maneuver', 	  Amount=0},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=1},
		},
		Ranged = {
			{Name='Wind Maneuver', 	  Amount=3},
			{Name='Fire Maneuver',	  Amount=0},
			{Name='Light Maneuver',	  Amount=0},
			{Name='Thunder Maneuver', Amount=0},
		},
		HybridRanged = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
		},
		Tank = {
			{Name='Water Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		LightTank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		Magic = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Heal = {
			{Name='Light Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Nuke = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Overdrive = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=0},
			{Name='Dark Maneuver',	  Amount=0},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
			{Name='Thunder Maneuver', Amount=1},
		},
	}

	deactivatehpp = 85
	
	gear.haste_jse_back = {name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Haste+10',}}
	gear.tank_jse_back = {name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}}
	
    select_default_macro_book()
	
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f8 gs c toggle AutoPuppetMode')
	send_command('bind @f7 gs c toggle AutoRepairMode')
	send_command('bind @pause gs c toggle AutoBuffMode') --Automatically keeps certain buffs up, job-dependant.
end

-- Define sets used by this job file.
function init_gear_sets()

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
	head="Herculean Helm",neck="Orunmila's Torque",
	body=gear.taeon_FC_body,
	legs="Gyve Trousers"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {} --feet="Cirque Scarpe +2"
    sets.precast.JA['Repair'] = {ammo="Automat. Oil +3", ear1="Pratik Earring", ear2="Guignol Earring", legs="Desultor Tassets", feet="Foire Bab. +1"}
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +3"}
	sets.precast.JA['Overdrive'] = {body="Pitre Tobe +3"}

    sets.precast.JA.Maneuver = {main="Midnights", neck="Buffoon's Collar", ear1="Burana Earring", body="Kara. Farsetto +1", hands="Foire Dastanas +1", back="Visucius's Mantle"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Heyoka Cap",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Pitre Tobe +3",hands="Heyoka Mittens",ring1="Niqmaddu Ring",ring2="Regal Ring",
        waist="Grunfeld Rope",legs="Samnuha Tights",feet=gear.herculean_wsd_feet}
	sets.precast.WS.Acc = {
        head="Heyoka Cap",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Pitre Tobe +3",hands="Heyoka Mittens",ring1="Niqmaddu Ring",ring2="Regal Ring",
        waist="Grunfeld Rope",legs="Samnuha Tights",feet=gear.herculean_wsd_feet}
	sets.precast.WS.FullAcc = {
        head="Heyoka Cap",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Pitre Tobe +3",hands="Heyoka Mittens",ring1="Niqmaddu Ring",ring2="Regal Ring",
        waist="Grunfeld Rope",legs="Samnuha Tights",feet=gear.herculean_wsd_feet}
	sets.precast.WS.Fodder = {
        head="Heyoka Cap",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Pitre Tobe +3",hands="Heyoka Mittens",ring1="Niqmaddu Ring",ring2="Regal Ring",
        waist="Grunfeld Rope",legs="Samnuha Tights",feet=gear.herculean_wsd_feet}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Victory Smite'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Victory Smite'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Stringing Pummel'].Acc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Stringing Pummel'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Stringing Pummel'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Shijin Spiral'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Shijin Spiral'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dragon Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Dragon Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Dragon Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tornado Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Tornado Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Raging Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Raging Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Howling Fist'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Howling Fist'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Backhand Blow'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Backhand Blow'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Backhand Blow'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Spinning Attack'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Spinning Attack'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Spinning Attack'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shoulder Tackle'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Shoulder Tackle'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Shoulder Tackle'].Fodder = set_combine(sets.precast.WS.Fodder, {})
    -- Midcast Sets

    sets.midcast.FastRecast = {
	head="Herculean Helm",neck="Orunmila's Torque",
	body=gear.taeon_FC_body,
	legs="Gyve Trousers"}
        
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
		
    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}

	sets.midcast.Pet['Enfeebling Magic'] = {} --neck="Adad Amulet",ear1="Enmerkar Earring",ring1="Varar Ring",ring2="Varar Ring",waist="Incarnation Sash",legs="Tali'ah Sera. +2"
    sets.midcast.Pet['Elemental Magic'] = {} --neck="Adad Amulet",ear1="Enmerkar Earring",ring1="Varar Ring",ring2="Varar Ring",waist="Incarnation Sash",legs="Tali'ah Sera. +2"
	sets.midcast.Pet.PetWSGear = {main="Ohtas",
	head="Karagoz Capello +1",neck="Shulmanu Collar",ear1="Domes. Earring",ear2="Burana Earring",
	body="Pitre Tobe +3",hands="Karagoz Guanti +1",ring1="Varar Ring",ring2="Varar Ring",
	back="Visucius's Mantle",waist="Incarnation Sash",legs="Kara. Pantaloni +1",feet="Naga Kyahan"}
	
    sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.HybridRanged = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {ear1="Domesticator's Earring",ear2="Burana Earring",})
	sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {ear1="Domesticator's Earring",ear2="Burana Earring",})
	sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {ear1="Domesticator's Earring",ear2="Burana Earring",})
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})
    

	sets.midcast.Pet.PetEnmityGear = {
		head = "Heyoka Cap",
		ear1 = "Rimeice Earring",
		ear2 = "Domesticator's Earring",
		body = "Heyoka Harness",
		hands = "Heyoka Mittens",
		back = gear.tank_jse_back,
		legs = "Heyoka Subligar",
		feet = "Heyoka Leggings"
	}
		
	-- Currently broken, preserved in case of future functionality.
	sets.midcast.Pet.WeaponSkill = {}
	

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets

    sets.idle = {main="Ohtas",
        head="Tali'ah Turban +2",neck="Loricate Torque +1",ear1="Burana Earring",ear2="Rimeice Earring",
        body="Pitre Tobe +3",hands="Tali'ah Gages +2",ring1="Defending Ring",ring2="Vocane Ring +1",
        back=gear.haste_jse_back,waist="Fucho-no-Obi",legs="Tali'ah Sera. +2",feet="Tali'ah Crackows +2"}
		
	sets.idle.Refresh = {main="Ohtas",
        head="Tali'ah Turban +2",neck="Loricate Torque +1",ear1="Burana Earring",ear2="Rimeice Earring",
        body="Pitre Tobe +3",hands="Tali'ah Gages +2",ring1="Defending Ring",ring2="Vocane Ring +1",
        back=gear.haste_jse_back,waist="Fucho-no-Obi",legs="Tali'ah Sera. +2",feet="Tali'ah Crackows +2"}
		
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = {main="Midnights",
        head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Rimeice Earring",
        body=gear.taeon_pet_body,hands=gear.taeon_pet_hands,ring1="Defending Ring",ring2="Vocane Ring +1",
        back=gear.tank_jse_back,waist="Isa Belt",legs="Tali'ah Sera. +2",feet=gear.taeon_pet_feet}

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
		neck="Shulmanu Collar",
		--main="Karambit",
		main="Ohtas",
		range="Divinator",
		head=gear.herculean_pet_stp_head,
		body={name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands=gear.herculean_pet_stp_hands,
		legs=gear.herculean_pet_stp_legs,
		feet=gear.herculean_pet_stp_feet,
		waist="Incarnation Sash",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
	}

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {
		neck="Shulmanu Collar",
		--main="Karambit",
		main="Ohtas",
		range="Divinator",
		head=gear.herculean_pet_stp_head,
		body={name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands=gear.herculean_pet_stp_hands,
		legs=gear.herculean_pet_stp_legs,
		feet=gear.herculean_pet_stp_feet,
		waist="Incarnation Sash",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
	})
    sets.idle.Pet.Engaged.HybridRanged = set_combine(sets.idle.Pet.Engaged, {
		neck="Shulmanu Collar",
		--main="Karambit",
		main="Ohtas",
		range="Divinator",
		head=gear.herculean_pet_stp_head,
		body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands=gear.herculean_pet_stp_hands,
		legs=gear.herculean_pet_stp_legs,
		feet=gear.herculean_pet_stp_feet,
		waist="Incarnation Sash",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
	})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {
		--main="Karambit",
		main="Ohtas",
		waist="Isa Belt",
		head="Anwig Salade",
		neck="Shepherd's Chain",
		body=gear.taeon_pet_tank_body,
		hands=gear.taeon_pet_tank_hands,
		legs=gear.taeon_pet_tank_legs,
		feet=gear.taeon_pet_tank_feet,
		--legs="Heyoka Subligar",
		--hands="Heyoka Mittens",
		--feet="Heyoka Leggings",
		--head="Heyoka Cap",
		--body="Heyoka Harness",
		ring1="Overbearing Ring",
		ear1="Rimeice Earring",
		ear2="Handler's Earring +1",
		back={name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}}
		--neck="Shulmanu Collar",
		--main="Karambit",
		--main="Ohtas",
		--range="Divinator",
		--head=gear.herculean_pet_stp_head,
		--body={ name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		--hands=gear.herculean_pet_stp_hands,
		--legs=gear.herculean_pet_stp_legs,
		--feet=gear.herculean_pet_stp_feet,
		--waist="Incarnation Sash",
		--left_ear="Rimeice Earring",
		--right_ear="Domes. Earring",
		--left_ring="Varar Ring",
		--right_ring="Varar Ring",
		--back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},
	})
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {
		--main="Karambit",
		main="Ohtas",
		waist="Isa Belt",
		head="Anwig Salade",
		neck="Shepherd's Chain",
		body=gear.taeon_pet_tank_body,
		hands=gear.taeon_pet_tank_hands,
		legs=gear.taeon_pet_tank_legs,
		feet=gear.taeon_pet_tank_feet,
		--legs="Heyoka Subligar",
		--hands="Heyoka Mittens",
		--feet="Heyoka Leggings",
		--head="Heyoka Cap",
		--body="Heyoka Harness",
		ring1="Overbearing Ring",
		ear1="Rimeice Earring",
		ear2="Handler's Earring +1",
		back={name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}}
	})
	sets.idle.Pet.Engaged.LightTank = set_combine(sets.idle.Pet.Engaged, {
		--main="Karambit",
		main="Ohtas",
		waist="Isa Belt",
		head="Anwig Salade",
		neck="Shepherd's Chain",
		body=gear.taeon_pet_tank_body,
		hands=gear.taeon_pet_tank_hands,
		legs=gear.taeon_pet_tank_legs,
		feet=gear.taeon_pet_tank_feet,
		ring1="Overbearing Ring",
		ear1="Rimeice Earring",
		ear2="Handler's Earring +1",
		back={name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}}
	})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
	sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic
	
    sets.idle.Pet.Engaged.DT = {
    	main = "Midnights",
    	head = "Anwig Salade",
    	neck = "Loricate Torque +1",
    	ear1 = "Enmerkar Earring",
    	ear2 = "Rimeice Earring",
    	body = gear.taeon_pet_body,
    	hands = gear.taeon_pet_hands,
    	ring1 = "Varar Ring",
    	ring2 = "Varar Ring",
    	back = gear.tank_jse_back,
    	waist = "Isa Belt",
    	legs = "Tali'ah Sera. +2",
    	feet = gear.taeon_pet_feet
    }

    -- Defense sets

    sets.defense.PDT = {main="Ohtas",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Vocane Ring +1",
        back="Mecisto. Mantle",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.MDT = {main="Ohtas",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Vocane Ring +1",
        back="Mecisto. Mantle",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.defense.MEVA = {main="Ohtas",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Vocane Ring +1",
        back="Mecisto. Mantle",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		--main="Karambit",
		main="Ohtas",
		head=gear.herculean_pet_stp_head,
		body={name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands=gear.herculean_pet_stp_hands,
		legs=gear.herculean_pet_stp_legs,
		feet=gear.herculean_pet_stp_feet,
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},	
	}
    sets.engaged.Acc = {
        --main="Karambit",
		main="Ohtas",
		head=gear.herculean_pet_stp_head,
		body={name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands=gear.herculean_pet_stp_hands,
		legs=gear.herculean_pet_stp_legs,
		feet=gear.herculean_pet_stp_feet,
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},			
	}
    sets.engaged.FullAcc = {
		--main="Karambit",
		main="Ohtas",
		head=gear.herculean_pet_stp_head,
		body={name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands=gear.herculean_pet_stp_hands,
		legs=gear.herculean_pet_stp_legs,
		feet=gear.herculean_pet_stp_feet,
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},	
	}
	sets.engaged.Fodder = {
		--main="Karambit",
		main="Ohtas",
		head=gear.herculean_pet_stp_head,
		body={name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}},
		hands=gear.herculean_pet_stp_hands,
		legs=gear.herculean_pet_stp_legs,
		feet=gear.herculean_pet_stp_feet,
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}},	
    }
				

	sets.engaged.DT = {main="Midnights",
        head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Rimeice Earring",
        body=gear.taeon_pet_body,hands=gear.taeon_pet_hands,ring1="Defending Ring",ring2="Vocane Ring +1",
        back=gear.tank_jse_back,waist="Isa Belt",legs="Tali'ah Sera. +2",feet=gear.taeon_pet_feet}
    sets.engaged.Acc.DT = {main="Midnights",
        head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Rimeice Earring",
        body=gear.taeon_pet_body,hands=gear.taeon_pet_hands,ring1="Defending Ring",ring2="Vocane Ring +1",
        back=gear.tank_jse_back,waist="Isa Belt",legs="Tali'ah Sera. +2",feet=gear.taeon_pet_feet}
    sets.engaged.FullAcc.DT = {main="Ohtas",
        head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Rimeice Earring",
        body=gear.taeon_pet_body,hands=gear.taeon_pet_hands,ring1="Defending Ring",ring2="Vocane Ring +1",
        back=gear.tank_jse_back,waist="Isa Belt",legs="Tali'ah Sera. +2",feet=gear.taeon_pet_feet}
    sets.engaged.Fodder.DT = {main="Ohtas",
        head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Rimeice Earring",
        body=gear.taeon_pet_body,hands=gear.taeon_pet_hands,ring1="Defending Ring",ring2="Vocane Ring +1",
        back=gear.tank_jse_back,waist="Isa Belt",legs="Tali'ah Sera. +2",feet=gear.taeon_pet_feet}

	sets.engaged.Pet = {main="Ohtas",
        head=gear.herculean_PetStp_head,neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Domesticator's Earring",
        body="Pitre Tobe +3",hands=gear.herculean_PetStp_hands,ring1="Varar Ring",ring2="Varar Ring",
        back=gear.haste_jse_back,waist="Incarnation Sash",legs="Heyoka Subligar",feet=gear.herculean_PetStp_feet}
    sets.engaged.Acc.Pet = {main="Ohtas",
        head=gear.herculean_PetStp_head,neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Domesticator's Earring",
        body="Pitre Tobe +3",hands=gear.herculean_PetStp_hands,ring1="Varar Ring",ring2="Varar Ring",
        back=gear.haste_jse_back,waist="Incarnation Sash",legs="Heyoka Subligar",feet=gear.herculean_PetStp_feet}
    sets.engaged.FullAcc.Pet = {main="Ohtas",
        head=gear.herculean_PetStp_head,neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Domesticator's Earring",
        body="Pitre Tobe +3",hands=gear.herculean_PetStp_hands,ring1="Varar Ring",ring2="Varar Ring",
        back=gear.haste_jse_back,waist="Incarnation Sash",legs="Heyoka Subligar",feet=gear.herculean_PetStp_feet}
    sets.engaged.Fodder.Pet = {
        head=gear.herculean_PetStp_head,neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Domesticator's Earring",
        body="Pitre Tobe +3",hands=gear.herculean_PetStp_hands,ring1="Varar Ring",ring2="Varar Ring",
        back=gear.haste_jse_back,waist="Incarnation Sash",legs="Heyoka Subligar",feet=gear.herculean_PetStp_feet}
		
	-- Weapons sets
	sets.weapons.PetWeapons = {main="Ohtas",range="Animator P +1",}
	sets.weapons.Godhands = {} --main="Godhands",range="Animator P +1",
end


function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
set_macro_page(2, 20)
set_style(6) 
end