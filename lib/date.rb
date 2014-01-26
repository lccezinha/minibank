require 'date'
p 'DATE'
class Date
  def weekend?
    saturday? || sunday?
  end
end