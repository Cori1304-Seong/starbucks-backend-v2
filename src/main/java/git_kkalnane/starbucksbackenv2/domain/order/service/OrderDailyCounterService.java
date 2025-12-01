package git_kkalnane.starbucksbackenv2.domain.order.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderDailyCounter;
import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderDailyCounterId;
import git_kkalnane.starbucksbackenv2.domain.order.repository.OrderDailyCounterRepository;
import lombok.RequiredArgsConstructor;

/**
 * OrderDailyCounter의 트랜잭션 관리를 담당하는 서비스.
 * Self-invocation 문제를 해결하기 위해 별도 클래스로 분리.
 */
@Service
@RequiredArgsConstructor
public class OrderDailyCounterService {

	private final OrderDailyCounterRepository orderDailyCounterRepository;

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public String incrementCounterWithNewTransaction(OrderDailyCounterId id) {
		OrderDailyCounter counter = orderDailyCounterRepository.findByIdWithOptimisticLock(id)
			.orElseGet(() -> {
				OrderDailyCounter newCounter = new OrderDailyCounter(id, 0);
				return orderDailyCounterRepository.save(newCounter);
			});

		counter.increment();
		orderDailyCounterRepository.save(counter);

		// 트랜잭션 커밋 시점에 낙관적 락 검증이 이루어짐
		return "A-" + counter.getCount();
	}
}
