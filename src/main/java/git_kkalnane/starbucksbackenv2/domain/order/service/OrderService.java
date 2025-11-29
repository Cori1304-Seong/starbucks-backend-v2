package git_kkalnane.starbucksbackenv2.domain.order.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import git_kkalnane.starbucksbackenv2.domain.item.domain.ItemOption;
import git_kkalnane.starbucksbackenv2.domain.item.domain.beverage.BeverageItem;
import git_kkalnane.starbucksbackenv2.domain.item.domain.dessert.DessertItem;
import git_kkalnane.starbucksbackenv2.domain.item.service.BeverageItemService;
import git_kkalnane.starbucksbackenv2.domain.item.service.DessertItemService;
import git_kkalnane.starbucksbackenv2.domain.item.service.ItemOptionService;
import git_kkalnane.starbucksbackenv2.domain.member.domain.Member;
import git_kkalnane.starbucksbackenv2.domain.member.repository.MemberRepository;
import git_kkalnane.starbucksbackenv2.domain.order.common.exception.OrderErrorCode;
import git_kkalnane.starbucksbackenv2.domain.order.common.exception.OrderException;
import git_kkalnane.starbucksbackenv2.domain.order.domain.Order;
import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderItem;
import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderItemOption;
import git_kkalnane.starbucksbackenv2.domain.order.domain.OrderStatus;
import git_kkalnane.starbucksbackenv2.domain.order.dto.request.OrderCreateRequest;
import git_kkalnane.starbucksbackenv2.domain.order.dto.response.CustomerCurrentOrderResponse;
import git_kkalnane.starbucksbackenv2.domain.order.dto.response.CustomerOrderDetailResponse;
import git_kkalnane.starbucksbackenv2.domain.order.dto.response.CustomerOrderHistoryListResponse;
import git_kkalnane.starbucksbackenv2.domain.order.dto.response.StoreCurrentOrderResponse;
import git_kkalnane.starbucksbackenv2.domain.order.dto.response.StoreOrderHistoryListResponse;
import git_kkalnane.starbucksbackenv2.domain.order.repository.OrderItemOptionRepository;
import git_kkalnane.starbucksbackenv2.domain.order.repository.OrderRepository;
import git_kkalnane.starbucksbackenv2.domain.store.domain.Store;
import git_kkalnane.starbucksbackenv2.domain.store.dto.StoreSimpleDto;
import git_kkalnane.starbucksbackenv2.domain.store.repository.StoreRepository;
import lombok.RequiredArgsConstructor;

/**
 * 주문 관련 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OrderService {

	private final OrderRepository orderRepository;
	private final MemberRepository memberRepository;
	private final OrderItemService orderItemService;
	private final BeverageItemService beverageItemService;
	private final DessertItemService dessertItemService;
	private final ItemOptionService itemOptionService;
	private final StoreRepository storeRepository;
	private final OrderFactory orderFactory;
	private final OrderPriceCalculator orderPriceCalculator;
	private final OrderNumberGenerator orderNumberGenerator;
	private final OrderItemOptionRepository orderItemOptionRepository;

	// ====== 주문 생성 ======

	/**
	 * 새로운 주문을 생성하고, 가격을 계산하며, 결제를 처리합니다.
	 *
	 * @param request  주문 생성에 필요한 모든 정보를 담은 DTO
	 * @param memberId 주문을 생성하는 회원의 ID (인증을 통해 획득)
	 * @return 생성되고 저장된 Order 엔티티
	 */
	@Transactional
	public Order createOrder(OrderCreateRequest request, Long memberId) {
		/** TODO 필요한 이유는 주문하기할때 관계를 맺어 줘야 해서? 그렇다면 memberId만 있어도 괜챃지 않나?
		 memberId는 auth에서 검증된 값이기에 또 검증은 불필요로 사료됨, DB에 접근할 필요 없음 */
		Member member = getMemberOrThrow(memberId);

		StoreSimpleDto store = getStoreDtoOrThrow(request.storeId());
		List<OrderItem> orderItems = orderFactory.createOrderItems(request);

		/** TODO 계산을 서버에서 하는게 맞을까 의문 만약에 단체 주문으로 들어오면 그 만큼 계산하는데 시간이 소요 됨
		 확실하게 가격을 보증해줄 필요가 있음  */
		Long calculatedTotalPrice = orderPriceCalculator.calculateTotalPrice(orderItems);

		String orderNumber = orderNumberGenerator.generateOrderNumber(request);
		// TODO StoreSimpleDto를 그대로 사용하는 것도 좋을거 같음 햇갈림을 줄 있다.
		Store minimalStore = orderFactory.createMinimalStore(store);

		Order order = orderFactory.createOrder(member, minimalStore, orderNumber, calculatedTotalPrice, request);

		// Order 저장
		Order savedOrder = orderRepository.save(order);
		Store _store = storeRepository.findById(store.getId())
			.orElseThrow(() -> new OrderException(OrderErrorCode.STORE_NOT_FOUND));

		// TODO 1번에 DB 접속으로 데이터를 저장하는 것이 효육적 바른 방법을 생걱하자
		savedOrder.setStore(_store);

		// List<OrderItem> 저장, OrderItem은 OrderId가 없으면 에러 발생
		List<OrderItem> savedOrderItems = orderItemService.saveOrderItems(savedOrder.getId(), orderItems);

		return savedOrder;
	}

	// ====== Private Helper Methods ======
	private Member getMemberOrThrow(Long memberId) {
		return memberRepository.findById(memberId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.MEMBER_NOT_FOUND));
	}

	private StoreSimpleDto getStoreDtoOrThrow(Long storeId) {
		return storeRepository.findSimpleDtoById(storeId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.STORE_NOT_FOUND));
	}

	/**
	 * [사용자용] 주문 상세 정보를 조회합니다.
	 */
	public CustomerOrderDetailResponse getOrderDetail(Long loginMemberId, Long orderId) {
		Order order = getOrderOrThrow(orderId);
		validateOrderOwner(order, loginMemberId);

		List<Long> beverageIds = extractBeverageIds(order);
		List<Long> dessertIds = extractDessertIds(order);
		List<Long> optionIds = extractOptionIds(order);

		Map<Long, BeverageItem> beverageMap = beverageItemService.getBeverageByIds(beverageIds)
			.stream().collect(Collectors.toMap(BeverageItem::getId, item -> item));
		Map<Long, DessertItem> dessertMap = dessertItemService.getDessertsByIds(dessertIds)
			.stream().collect(Collectors.toMap(DessertItem::getId, item -> item));
		Map<Long, ItemOption> optionMap = itemOptionService.getItemOptionsByIds(optionIds)
			.stream().collect(Collectors.toMap(ItemOption::getId, option -> option));

		return CustomerOrderDetailResponse.of(order, beverageMap, dessertMap, optionMap);
	}

	private Order getOrderOrThrow(Long orderId) {
		return orderRepository.findById(orderId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.ORDER_NOT_FOUND));
	}

	private void validateOrderOwner(Order order, Long loginMemberId) {
		if (!order.getMember().getId().equals(loginMemberId)) {
			throw new OrderException(OrderErrorCode.FORBIDDEN_ACCESS_ORDER);
		}
	}

	private List<Long> extractBeverageIds(Order order) {
		return order.getOrderItems().stream()
			.map(OrderItem::getBeverageItemId)
			.filter(beverageItemId -> beverageItemId != null)
			.distinct()
			.toList();
	}

	private List<Long> extractDessertIds(Order order) {
		return order.getOrderItems().stream()
			.map(OrderItem::getDessertItemId)
			.filter(dessertItemId -> dessertItemId != null)
			.distinct()
			.toList();
	}

	private List<Long> extractOptionIds(Order order) {
		return order.getOrderItems().stream()
			.flatMap(oi -> oi.getOrderItemOptions().stream())
			.map(OrderItemOption::getItemOptionId)
			.distinct()
			.toList();
	}

	/**
	 * [사용자용] 현재 진행중인 주문 목록(PLACED, PREPARING, READY_FOR_PICKUP)을 조회합니다.
	 *
	 * @param memberId 조회할 사용자의 ID
	 * @return 현재 주문 목록에 대한 요약 DTO 리스트
	 */
	public List<CustomerCurrentOrderResponse> getCurrentOrders(Long memberId) {
		memberRepository.findById(memberId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.MEMBER_NOT_FOUND));

		List<OrderStatus> currentStatuses = List.of(
			OrderStatus.PLACED,
			OrderStatus.PREPARING,
			OrderStatus.READY_FOR_PICKUP
		);

		List<Order> currentOrders = orderRepository.findByMemberIdAndStatusInOrderByCreatedAtAsc(memberId,
			currentStatuses);

		return currentOrders.stream()
			.map(CustomerCurrentOrderResponse::from)
			.collect(Collectors.toList());
	}

	/**
	 * [사용자용] 특정 회원의 과거 주문 내역(완료, 취소)을 페이지네이션하여 조회합니다.
	 *
	 * @param memberId 조회할 회원의 ID
	 * @param pageable 페이징 및 정렬 정보
	 * @return 페이지네이션된 과거 주문 내역 DTO
	 */
	public CustomerOrderHistoryListResponse getOrderHistory(Long memberId, Pageable pageable) {
		memberRepository.findById(memberId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.MEMBER_NOT_FOUND));

		List<OrderStatus> pastStatuses = List.of(OrderStatus.COMPLETED, OrderStatus.CANCELLED);

		Page<Order> orderPage = orderRepository.findByMemberIdAndStatusIn(memberId, pastStatuses, pageable);

		return CustomerOrderHistoryListResponse.from(orderPage);
	}

	/**
	 * [매장용] 특정 매장의 현재 진행중인 모든 주문 목록(접수, 준비중, 픽업 가능)을 조회합니다. <br/>
	 *
	 * @param storeId 조회할 매장의 ID
	 * @return 현재 진행중인 주문 목록 DTO 리스트
	 */
	public List<StoreCurrentOrderResponse> getStoreCurrentOrders(Long storeId) {
		storeRepository.findById(storeId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.STORE_NOT_FOUND));

		List<OrderStatus> currentStatuses = List.of(
			OrderStatus.PLACED,
			OrderStatus.PREPARING,
			OrderStatus.READY_FOR_PICKUP
		);

		List<Order> currentOrders = orderRepository.findByStoreIdAndStatusInOrderByCreatedAtAsc(storeId,
			currentStatuses);

		return currentOrders.stream()
			.map(StoreCurrentOrderResponse::from)
			.collect(Collectors.toList());
	}

	public Order getStoreOrderDetail(Long loginStoreId, Long orderId) {
		Order order = orderRepository.findOrderWithItemsById(orderId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.ORDER_NOT_FOUND));

		if (!order.getStore().getId().equals(loginStoreId)) {
			throw new OrderException(OrderErrorCode.FORBIDDEN_ACCESS_ORDER);
		}

		// 2단계 조회: orderItems의 id 목록 추출
		List<Long> orderItemIds = order.getOrderItems().stream()
			.map(OrderItem::getId)
			.collect(Collectors.toList());
		if (!orderItemIds.isEmpty()) {
			// orderItemOptions 일괄 조회
			List<OrderItemOption> options = orderItemOptionRepository.findByOrderItemIdIn(orderItemIds);
			Map<Long, List<OrderItemOption>> optionMap = options.stream()
				.collect(Collectors.groupingBy(opt -> opt.getOrderItem().getId()));
			// 각 orderItem에 옵션 매핑
			order.getOrderItems().forEach(item -> {
				List<OrderItemOption> opts = optionMap.getOrDefault(item.getId(), Collections.emptyList());
				item.setOrderItemOptions(opts);
			});
		}

		order.getMember().getNickname();

		return order;
	}

	/**
	 * [매장용] 특정 매장의 과거 주문 내역(완료, 취소)을 페이지네이션하여 조회합니다. <br/>
	 *
	 * @param storeId  조회할 매장의 ID
	 * @param pageable 페이징 및 정렬 정보
	 * @return 페이지네이션된 과거 주문 내역 DTO
	 */
	public StoreOrderHistoryListResponse getStoreOrderHistory(Long storeId, Pageable pageable) {
		storeRepository.findById(storeId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.STORE_NOT_FOUND));

		List<OrderStatus> pastStatuses = List.of(OrderStatus.COMPLETED, OrderStatus.CANCELLED);

		Page<Order> orderPage = orderRepository.findByStoreIdAndStatusIn(storeId, pastStatuses, pageable);

		return StoreOrderHistoryListResponse.from(orderPage);
	}

	/**
	 * [매장용] 특정 주문의 상태를 변경합니다.
	 *
	 * @param storeId   요청한 매장의 ID (권한 검증용)
	 * @param orderId   상태를 변경할 주문의 ID
	 * @param newStatus 변경할 새로운 주문 상태
	 */
	@Transactional
	public void updateOrderStatus(Long storeId, Long orderId, OrderStatus newStatus) {
		Order order = orderRepository.findById(orderId)
			.orElseThrow(() -> new OrderException(OrderErrorCode.ORDER_NOT_FOUND));

		if (!order.getStore().getId().equals(storeId)) {
			throw new OrderException(OrderErrorCode.FORBIDDEN_ACCESS_ORDER);
		}

		if (order.getStatus() == OrderStatus.COMPLETED || order.getStatus() == OrderStatus.CANCELLED) {
			throw new OrderException(OrderErrorCode.CANNOT_UPDATE_COMPLETED_ORDER);
		}

		order.updateStatus(newStatus);
	}
}
