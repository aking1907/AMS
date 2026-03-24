page 50104 "AMS WH Operator RC"
{
    ApplicationArea = All;
    Caption = 'AMS WH Operator RC';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(AMSRSPostedWHOperations; "AMS RS Posted WH Operations")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action(AMSInventory)
            {
                ApplicationArea = All;
                Caption = 'AMS Inventory';
                RunObject = Page "AMS Inventory";
            }

            action(AMSAssemblyOverviewList)
            {
                ApplicationArea = All;
                Caption = 'AMS Assembly Overview List';
                RunObject = Page "AMS Assembly Overview List";
            }
            action(AMSWHOperations)
            {
                ApplicationArea = All;
                Caption = 'AMS Warehouse Operations';
                RunObject = Page "AMS Warehouse Operations";
            }
            action(TransferOrders)
            {
                ApplicationArea = All;
                Caption = 'Transfer Orders';
                RunObject = Page "Transfer Orders";
            }
            action(AssemblyOrders)
            {
                ApplicationArea = All;
                Caption = 'Assembly Orders';
                RunObject = Page "Assembly Orders";
            }
            action(PostedAssemblyOrders)
            {
                ApplicationArea = All;
                Caption = 'Posted Assembly Orders';
                RunObject = Page "Posted Assembly Orders";
            }
            action(ConfigPackages)
            {
                ApplicationArea = All;
                Caption = 'Configure Packages';
                RunObject = Page "Config. Packages";
            }
        }
    }
}
