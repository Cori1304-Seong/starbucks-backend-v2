package git_kkalnane.starbucksbackenv2.domain.order.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderDailyCounter;
import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderDailyCounterId;
import jakarta.persistence.LockModeType;

@Repository
public interface OrderDailyCounterRepository extends JpaRepository<OrderDailyCounter, OrderDailyCounterId> {

	@Lock(LockModeType.OPTIMISTIC)
	@Query("SELECT c FROM OrderDailyCounter c WHERE c.id = :id")
	Optional<OrderDailyCounter> findByIdWithOptimisticLock(
		@Param("id") OrderDailyCounterId id);

	@Lock(LockModeType.PESSIMISTIC_WRITE)
	@Query("SELECT c FROM OrderDailyCounter c WHERE c.id = :id")
	Optional<OrderDailyCounter> findByIdWithPessimisticLock(
		@Param("id") OrderDailyCounterId id);
}
