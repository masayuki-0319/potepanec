module CategoriesHelper
  # rubocop:disable Lint/ParenthesesAsGroupedExpression, Metrics/LineLength
  def taxonomy_open(taxonomy, view_type)
    concat (content_tag :a, href: 'javascript:;', 'data-toggle': 'collapse', 'data-target': "#taxonomy-#{taxonomy.id}" do
      concat taxonomy.name
      concat content_tag :i, '', class: ['fa', 'fa-plus']
    end)
    concat (content_tag :ul, id: "taxonomy-#{taxonomy.id}", class: ['collapse', 'collapseItem'] do
      taxonomy.root.children.each do |taxons|
        if taxons.child_ids.blank?
          concat (content_tag :li do
            concat (content_tag :a, href: "/potepan/categories/#{taxons.id}?view_type=#{view_type}" do
              concat content_tag :i, '', class: ['fa', 'fa-caret-right'], 'aria-hidden': 'true'
              concat "#{taxons.name}( #{taxons.product_ids.count} )"
            end)
          end)
        else
          concat (content_tag :li do
            concat (content_tag :a, href: 'javascript:;', 'data-toggle': 'collapse', 'data-target': "#taxon-#{taxons.id}" do
              concat taxons.name
              concat content_tag :i, '', class: ['fa', 'fa-plus']
            end)
            concat (content_tag :ul, id: "taxon-#{taxons.id}", class: ['collapse', 'collapseItem'] do
              taxons.leaves.each do |taxon|
                concat (content_tag :li do
                  concat (content_tag :a, href: "/potepan/categories/#{taxon.id}?view_type=#{view_type}" do
                    concat content_tag :i, '', class: ['fa', 'fa-caret-right'], 'aria-hidden': 'true'
                    concat "#{taxon.name}( #{taxon.product_ids.count} )"
                  end)
                end)
              end
            end)
          end)
        end
      end
    end)
  end
  # rubocop:enable all
end
