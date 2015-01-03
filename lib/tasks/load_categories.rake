desc "(Re)Load categories usin Allegro WebAPI"
task :load_categories do
  allegro_api = AllegroApi.instance
  allegro_api.categories.each do |i|
    category = Category.find_or_initialize_by(id: i[:cat_id])
    category.name = i[:cat_name]
    category.parent = i[:cat_parent]
    category.position = i[:cat_position]
    category.is_product_catalogue_enabled = i[:cat_is_product_catalogue_enabled]
    category.save
  end
end
