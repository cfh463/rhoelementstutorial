require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    @@toolbar = nil
    super

    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')
    
    #Seed the database with initial data
    catalog = ProductCatalog.find(:all) 
    if catalog.empty?
      
      fileName = File.join(Rho::RhoApplication::get_base_app_path(), '/public/Products.txt')
      lines = File.read(fileName)
      jsonContent = Rho::JSON.parse(lines)
      jsonContent.each {
      |json|
        ProductCatalog.create("SKU" => json['SKU'], "Name" => json['Name'], "Image" => json['Image'])
      }
      #finished creating database for real application you may
      # want to display a loading page to indicate to the user 
      # something is going on
    else 
      #The catalog has been loaded already there is nothing to do
    end

  end
end
