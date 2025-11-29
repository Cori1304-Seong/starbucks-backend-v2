package git_kkalnane.starbucksbackenv2.domain.order.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderDailyCounter;
import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderDailyCounterId;
import jakarta.persistence.LockModeType;

@Repository
public interface OrderDailyCounterRepository extends JpaRepository<OrderDailyCounter, OrderDailyCounterId> {

	// TODO 낙관적 락을 사용으로 성능 개선되는지 확인하기
	@Lock(LockModeType.PESSIMISTIC_WRITE)
	@Query("SELECT c FROM OrderDailyCounter c WHERE c.id = :id")
	Optional<OrderDailyCounter> findByIdWithPessimisticLock(
		@org.springframework.data.repository.query.Param("id") OrderDailyCounterId id);
}
