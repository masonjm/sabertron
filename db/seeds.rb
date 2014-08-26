# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"

SEED_DIR = "db/seeds"

total_players = 0
imported_players = 0
players = []

player_files = Dir[File.join(SEED_DIR, "*.players.csv")]
player_files.each do |csv_file|
  CSV.foreach(csv_file) do |row|
    total_players += 1
    # Don't bother with rows that won't match up with the stats data.
    if row[0].present?
      imported_players += 1
      players << row
    else
      Rails.logger.info "Skipping #{row} from #{csv_file}. Missing player code."
    end
  end
end

Player.import [:code, :birth_year, :first_name, :last_name], players

puts "Imported #{imported_players} of #{total_players} players from #{player_files.length} csv files"

total_hitting_stats = 0
imported_hitting_stats = 0
hitting_stats = []

hitting_stats_files = Dir[File.join(SEED_DIR, "*.hitting_stats.csv")]
hitting_stats_files.each do |csv_file|
  CSV.foreach(csv_file) do |row|
    total_hitting_stats += 1
    player_code, year, league, team_code, games, at_bats, runs, hits, doubles, triples, home_runs, rbi, stolen_bases, caught_stealing = *row
    singles = hits.to_i - doubles.to_i - triples.to_i - home_runs.to_i
    team = Team.where(code: team_code).first_or_create(league: league)
    player = Player.where(code: player_code).first
    if team && player
      imported_hitting_stats += 1
      hitting_stats << [player.id, team.id, year, games, at_bats, runs, singles, doubles, triples, home_runs, rbi, stolen_bases, caught_stealing]
    else
      Rails.logger.info "Skipping #{row} from #{csv_file}. Missing player or team."
    end    
  end
end

HittingStat.import [:player_id, :team_id, :year, :games, :at_bats, :runs, :singles, :doubles, :triples, :home_runs, :rbi, :stolen_bases, :caught_stealing], hitting_stats

puts "Imported #{imported_hitting_stats} of #{total_hitting_stats} hitting stats from #{hitting_stats_files.length} csv files"