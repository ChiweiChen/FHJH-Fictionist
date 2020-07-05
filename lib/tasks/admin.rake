namespace :admin do
    desc "remove chapters without books"
    task :remove => :environment do
        Chapter.all.each do |chapter|
            if(chapter.book==nil)
                chapter.destroy
            end
        end
    end
end