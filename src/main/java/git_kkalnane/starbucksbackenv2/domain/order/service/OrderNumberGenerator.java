package git_kkalnane.starbucksbackenv2.domain.order.service;

import java.time.LocalDate;

import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.stereotype.Component;

import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderDailyCounterId;
import git_kkalnane.starbucksbackenv2.domain.order.dto.request.OrderCreateRequest;
import jakarta.persistence.OptimisticLockException;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class OrderNumberGenerator {
	private final OrderDailyCounterService orderDailyCounterService;

	/**
	 * 해당 매장과 날짜 기준으로 고유한 주문번호를 생성합니다.
	 * 낙관적 락을 사용하여 동시성을 제어하며, 충돌 시 최대 20번 재시도합니다.
	 *
	 * @param request 주문 생성 요청(매장 ID 포함)
	 * @return 생성된 주문번호 (예: "A-1")
	 * @throws RuntimeException 최대 재시도 횟수 초과 시
	 */
	public String generateOrderNumber(OrderCreateRequest request) {
		LocalDate today = LocalDate.now();
		OrderDailyCounterId id = new OrderDailyCounterId(today, request.storeId());

		int maxRetries = 20;
		int retryCount = 0;

		while (retryCount < maxRetries) {
			try {
				return orderDailyCounterService.incrementCounterWithNewTransaction(id);
			} catch (OptimisticLockException | ObjectOptimisticLockingFailureException e) {
				retryCount++;
				if (retryCount >= maxRetries) {
					throw new RuntimeException("주문번호 생성 실패: 최대 재시도 횟수 초과 (동시성 충돌)", e);
				}
				try {
					long baseDelay = (long)Math.pow(2, Math.min(retryCount - 1, 6)); // 최대 64ms
					long jitter = (long)(Math.random() * baseDelay); // 0 ~ baseDelay
					Thread.sleep(baseDelay + jitter);
				} catch (InterruptedException ie) {
					Thread.currentThread().interrupt();
					throw new RuntimeException("주문번호 생성 중단됨", ie);
				}
			}
		}

		throw new RuntimeException("주문번호 생성 실패: 예상치 못한 오류");
	}

}
