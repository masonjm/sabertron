namespace :saber do
  
  namespace :batting_average do
    desc "Prints player with the most improved batting average between the given years"
    task :most_improved, [:from_year, :to_year] => :environment do |t, args|
      puts BattingAverageChangeCalculator.new(args[:from_year], args[:to_year]).most_improved
    end
  end
  
  namespace :slugging_percentage do
    desc "Prints slugging percentags for the given team for the given year"
    task :team, [:team, :year] => :environment do |t, args|
      puts SluggingPercentageCalculator.new(args[:year]).for_team(args[:team])
    end
  end
  
  desc "Prints the AL and NL triple crown winners (if any) for the given year"
  task :triple_crown, [:year] => :environment do |t, args|
    puts TripleCrownCalculator.new(args[:year]).winners
  end
end

desc "Demo task that exercise other saber tasks"
task :saber => :environment do
  Rake.application.invoke_task("saber:batting_average:most_improved[2009,2010]")
  puts ""
  Rake.application.invoke_task("saber:slugging_percentage:team[OAK,2007]")
  puts ""
  Rake.application.invoke_task("saber:triple_crown[2011]")
  puts ""
  Rake.application["saber:triple_crown"].reenable
  Rake.application.invoke_task("saber:triple_crown[2012]")
end