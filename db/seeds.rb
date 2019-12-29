# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.delete_all()

# book6 = Book.create(book_name: 'An adventure novel', summary: 'This is an adventure novel', category:'adventure')
# Chapter.delete_all()
# book1.chapters.create(title: 'yes', content: 'no')
# book1.chapters.create(title: 'no', content: 'yes')
# book2.chapters.create(title: 'yes', content: 'no')
# book3.chapters.create(title: 'yes', content: 'no')
# book4.chapters.create(title: 'yes', content: 'no')
# book5.chapters.create(title: 'yes', content: 'no')
# book6.chapters.create(title: 'yes', content: 'no')
Category.delete_all()
category1 = Category.create(name: 'short',show: '短篇')
category2 = Category.create(name: 'sci_fi',show: '科幻')
category3 = Category.create(name: 'old_love',show: '古代愛情')
category4 = Category.create(name: 'mag_fi',show: '奇幻')
category5 = Category.create(name: 'east_fi',show: '玄幻')
category6 = Category.create(name: 'bl',show: '耽美')
category7 = Category.create(name: 'fan_fi',show: '同人')
category8 = Category.create(name: 'urban_love',show: '都市愛情')
category9 = Category.create(name: 'school_love',show: '校園愛情')
category10 = Category.create(name: 'foreign',show: '外文')
catagory11 = Category.create(name: 'real',show: '現實')
category12 = Category.create(name: 'mystery',show: '懸疑')
User.delete_all()



