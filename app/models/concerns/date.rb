require 'date'
class Date
  def weekend?
    saturday? || sunday?
  end
end