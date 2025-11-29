package git_kkalnane.starbucksbackenv2.domain.order.domain;

import git_kkalnane.starbucksbackenv2.domain.member.domain.Member;
import git_kkalnane.starbucksbackenv2.domain.order.dto.request.OrderCreateRequest;
import git_kkalnane.starbucksbackenv2.domain.store.domain.Store;
import git_kkalnane.starbucksbackenv2.global.entity.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders",
       uniqueConstraints = {
           @UniqueConstraint(columnNames = {"store_id", "order_number", "order_date"})
       })
@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Order extends BaseTimeEntity {
    @PrePersist
    public void prePersist() {
        if (this.orderDate == null) {
            this.orderDate = LocalDate.now();
        }
    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @ManyToOne
    @JoinColumn(name = "store_id", nullable = false)
    private Store store;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<OrderItem> orderItems = new ArrayList<>();

    @Column(name = "order_number", length = 20, nullable = false)
    private String orderNumber;

    @Column(name = "order_date", nullable = false)
    private LocalDate orderDate;

    @Column(name = "total_price", nullable = false)
    private Long totalPrice;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    private OrderStatus status = OrderStatus.PLACED;

    @Enumerated(EnumType.STRING)
    @Column(name = "pickup_type", nullable = false)
    private PickupType pickupType;

    @Column(name = "request_memo", columnDefinition = "text")
    private String requestMemo;

    @Column(name = "expected_pickup_time")
    private LocalDateTime expectedPickupTime;

    @Column(name = "card_number")
    private String cardNumber;

    public void updateStatus(OrderStatus newStatus) {
        this.status = newStatus;
    }

    /**
     * 새로운 주문을 생성할때 사용하는  static 팩토리 메서드
     * OrderService.creatOrder()에서 사용됩니다.
     */
    public static Order createNewOrder(Member member, Store store, String orderNumber, Long totalPrice,  OrderCreateRequest request) {
        return Order.builder()
                .member(member)
                .store(store)
                .orderNumber(orderNumber)
                .totalPrice(totalPrice)
                .status(OrderStatus.PLACED)
                .pickupType(request.pickupType())
                .requestMemo(request.requestMemo())
                .expectedPickupTime(java.time.LocalDateTime.now().plusMinutes(10))
                .cardNumber(request.cardNumber())
                .build();
    }

    public void setStore(Store store) {
        this.store = store;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
}
