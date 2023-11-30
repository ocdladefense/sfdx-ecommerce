public class LineItem {

    // OrderItem.OrderProductNumber
    public Id itemId;

    // OrderItem.Product2.Name
    public String name;

    // Corresponds to OrderItem.Description
    public String description;

    // Decimal, OrderItem.Quantity
    public Decimal quantity;

    // Decima., OrderItem.UnitPrice
    public Decimal unitPrice;

    
    public LineItem() {}
}