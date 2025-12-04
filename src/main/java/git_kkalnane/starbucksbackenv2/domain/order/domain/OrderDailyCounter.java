package git_kkalnane.starbucksbackenv2.domain.order.domain;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Version;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 주문번호 생성을 위한 Entity파일을 작성하였습니다.
 *
 */

@Entity
@Table(name = "order_daily_counters")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OrderDailyCounter {

	@EmbeddedId
	private OrderDailyCounterId id;

	@Column(name = "count", nullable = false)
	private int count;

	public void increment() {
		this.count++;
	}

	@Version
	@Column(nullable = false)
	private Long version;

	public OrderDailyCounter(OrderDailyCounterId id, int count) {
		this.id = id;
		this.count = count;
	}
}
