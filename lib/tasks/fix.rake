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
  end
end
