class SorteiosController < ApplicationController

  def index
    @sorteios = Sorteio.all
  end
  

end
