require_relative('../db/sql_runner')
# require('pry')

class Guitar

  attr_reader :id, :manufacturer_id
  attr_accessor :name, :type, :description, :stock_quantity, :buying_cost, :selling_price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @description = options['description']
    @stock_quantity = options['stock_quantity'].to_i
    @buying_cost = options['buying_cost'].to_i
    @selling_price = options['selling_price'].to_i
    @manufacturer_id = options['manufacturer_id'].to_i
  end

  def save()
    sql = "INSERT INTO guitars (
          name,
          type,
          description,
          stock_quantity,
          buying_cost,
          selling_price,
          manufacturer_id
          ) VALUES ($1, $2, $3, $4, $5, $6, $7)
          RETURNING id;"
    values = [@name, @type, @description, @stock_quantity, @buying_cost, @selling_price, @manufacturer_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM guitars;"
    results = SqlRunner.run(sql)
    return results.map{|guitar| Guitar.new(guitar)}
  end

  def self.delete_all()
    sql = "DELETE FROM guitars;"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM guitars
          WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Guitar.new(result.first)
  end

  def update()
    sql = "UPDATE guitars SET (
          name,
          type,
          description,
          stock_quantity,
          buying_cost,
          selling_price
          ) = ($1, $2, $3, $4, $5, $6)
          WHERE id = $7;"
    values = [@name, @type, @description, @stock_quantity, @buying_cost, @selling_price, @id]
    SqlRunner.run(sql, values)
  end

  def manufacturer()
    sql = "SELECT * FROM manufacturers
          WHERE id = $1;"
    values = [@manufacturer_id]
    result = SqlRunner.run(sql, values)
    # why do I need .first here? Nicked it from the Zombies site!
    return Manufacturer.new(result.first)
  end

  def self.find_by_manufacturer(manufacturer_id)
    # binding.pry
    sql = "SELECT * FROM guitars
          WHERE manufacturer_id = $1;"
    values = [manufacturer_id]
    results = SqlRunner.run(sql, values)
    return results.map{|guitar| Guitar.new(guitar)}
  end

  def self.find_by_type(type)
    # binding.pry
    sql = "SELECT * FROM guitars
          WHERE type = $1;"
    values = [type]
    results = SqlRunner.run(sql, values)
    return results.map{|guitar| Guitar.new(guitar)}
  end

end
