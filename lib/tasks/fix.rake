desc 'auto fix the errors found by the linters'

namespace :fix do
  task ruby: :environment do
    sh 'rubocop -a'
  end

  task scss: :environment do
    sh 'npx stylelint app/assets/stylesheets --fix'
  end

  task javascript: :environment do
    sh 'npx eslint app/javascript --fix'
    sh 'npx eslint stylelint.config.js --fix'
  end
end
