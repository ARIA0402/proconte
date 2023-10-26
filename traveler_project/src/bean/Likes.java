package bean;

public class Likes implements java.io.Serializable {
	private int id;
	private int customer_id;
	private int product_id;

	public int getId() {
		return id;
	}

	public int getCustomerId() {
		return customer_id;
	}

	public int getProductId() {
		return product_id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setCustomerId(int id) {
		this.customer_id = id;
	}

	public void setProductId(int id) {
		this.product_id = id;
	}
}
