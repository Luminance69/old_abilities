HeroController = HeroController or class({})
HeroController.known_player_heroes = {}

function HeroController:InitHero(player_id, hero)
	HeroController.known_player_heroes[player_id] = hero
end
