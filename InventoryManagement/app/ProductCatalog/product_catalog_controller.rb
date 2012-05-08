require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ProductCatalogController < Rho::RhoController
  include BrowserHelper

  # GET /ProductCatalog
  def index
    @productcatalogs = ProductCatalog.find(:all)
    render :back => '/app'
  end

  # GET /ProductCatalog/{1}
  def show
    @productcatalog = ProductCatalog.find(@params['id'])
    if @productcatalog
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /ProductCatalog/new
  def new
    @productcatalog = ProductCatalog.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /ProductCatalog/{1}/edit
  def edit
    @productcatalog = ProductCatalog.find(@params['id'])
    if @productcatalog
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /ProductCatalog/create
  def create
    @productcatalog = ProductCatalog.create(@params['productcatalog'])
    redirect :action => :index
  end

  # POST /ProductCatalog/{1}/update
  def update
    @productcatalog = ProductCatalog.find(@params['id'])
    @productcatalog.update_attributes(@params['productcatalog']) if @productcatalog
    redirect :action => :index
  end

  # POST /ProductCatalog/{1}/delete
  def delete
    @productcatalog = ProductCatalog.find(@params['id'])
    @productcatalog.destroy if @productcatalog
    redirect :action => :index  
  end
end
