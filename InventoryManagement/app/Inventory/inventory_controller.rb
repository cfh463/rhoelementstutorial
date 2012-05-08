require 'rho/rhocontroller'
require 'helpers/browser_helper'

class InventoryController < Rho::RhoController
  include BrowserHelper

  def scanPage
        Scanner.decodeEvent = url_for(:action => :decodeEventCallback)
        Scanner.enable       
        render :back => '/app'
  end

  def decodeEventCallback
      barcode = @params['data']
      product = ProductCatalog.find(
        :first,
        :conditions => {:SKU => barcode}
      )   
      if product.nil?
        product = ProductCatalog.create({"SKU" => barcode, "Name" => "Unknown Product", "Image" => "data:image/jpeg;base64,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%3D"})
      end
      
      name = product.Name  
      if product.Image
        WebView.execute_js("setImgSrc('"+product.Image+"'); ")
      end      
      
      inventoryItem = Inventory.find(
        :first,
        :conditions => {:SKU => barcode}
      )
           
      if inventoryItem.nil?
        inventoryItem = Inventory.create(
          {"SKU" => barcode, "Quantity" => 1}
        )      
      else
        itemCount = inventoryItem.Quantity.to_i
        itemCount += 1
        inventoryItem.update_attributes(
          {"Quantity" => itemCount.to_s}
        )     
      end
      inventoryItem.save
      if itemCount.nil?
        itemCount = 1
      end
      getInventoryCount
      WebView.execute_js("setProductData('"+name+"','"+barcode+"','"+itemCount.to_s+"'); ")
  
    end     

  def getInventoryCount  
         
      items= Inventory.find(
        :all
      )
      scanCount = 0
      
      items.each do
        |item| 
        scanCount = scanCount + item.Quantity.to_i()
      end    
      WebView.execute_js("setProductCount('"+scanCount.to_s+"'); ")
  end    
    
    
  # GET /Inventory
  def index
    @inventories = Inventory.find(:all)
    render :back => '/app'
  end

  # GET /Inventory/{1}
  def show
    @inventory = Inventory.find(@params['id'])
    if @inventory
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Inventory/new
  def new
    @inventory = Inventory.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Inventory/{1}/edit
  def edit
    @inventory = Inventory.find(@params['id'])
    if @inventory
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Inventory/create
  def create
    @inventory = Inventory.create(@params['inventory'])
    redirect :action => :index
  end

  # POST /Inventory/{1}/update
  def update
    @inventory = Inventory.find(@params['id'])
    @inventory.update_attributes(@params['inventory']) if @inventory
    redirect :action => :index
  end

  # POST /Inventory/{1}/delete
  def delete
    @inventory = Inventory.find(@params['id'])
    @inventory.destroy if @inventory
    redirect :action => :index  
  end
end
