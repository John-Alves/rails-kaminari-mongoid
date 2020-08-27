class Mongo::Collection::View::Aggregation
  def page(number = 1)
    Kaminari.paginate_array(self.as_json)
  end
end