;; Community Building Contract
;; Builds sports equipment sharing communities

(define-map community-members
  { member: principal }
  {
    join-date: uint,
    reputation-score: uint,
    total-rentals: uint,
    total-earnings: uint,
    community-level: (string-ascii 20),
    verified: bool
  }
)

(define-map community-reviews
  { review-id: uint }
  {
    reviewer: principal,
    reviewee: principal,
    rental-id: uint,
    rating: uint,
    comment: (string-ascii 200),
    date: uint
  }
)

(define-map community-events
  { event-id: uint }
  {
    organizer: principal,
    title: (string-ascii 100),
    description: (string-ascii 300),
    date: uint,
    location: (string-ascii 100),
    max-participants: uint,
    current-participants: uint,
    status: (string-ascii 20)
  }
)

(define-data-var next-review-id uint u1)
(define-data-var next-event-id uint u1)

;; Join community
(define-public (join-community)
  (let ((member tx-sender))
    (map-set community-members
      { member: member }
      {
        join-date: block-height,
        reputation-score: u100,
        total-rentals: u0,
        total-earnings: u0,
        community-level: "bronze",
        verified: false
      }
    )
    (ok true)
  )
)

;; Submit review
(define-public (submit-review
  (reviewee principal)
  (rental-id uint)
  (rating uint)
  (comment (string-ascii 200)))
  (let
    (
      (review-id (var-get next-review-id))
      (reviewer tx-sender)
    )
    (asserts! (and (>= rating u1) (<= rating u5)) (err u400))
    (asserts! (is-community-member reviewer) (err u403))
    (map-set community-reviews
      { review-id: review-id }
      {
        reviewer: reviewer,
        reviewee: reviewee,
        rental-id: rental-id,
        rating: rating,
        comment: comment,
        date: block-height
      }
    )
    (update-reputation reviewee rating)
    (var-set next-review-id (+ review-id u1))
    (ok review-id)
  )
)

;; Create community event
(define-public (create-event
  (title (string-ascii 100))
  (description (string-ascii 300))
  (event-date uint)
  (location (string-ascii 100))
  (max-participants uint))
  (let
    (
      (event-id (var-get next-event-id))
      (organizer tx-sender)
    )
    (asserts! (is-community-member organizer) (err u403))
    (map-set community-events
      { event-id: event-id }
      {
        organizer: organizer,
        title: title,
        description: description,
        date: event-date,
        location: location,
        max-participants: max-participants,
        current-participants: u0,
        status: "open"
      }
    )
    (var-set next-event-id (+ event-id u1))
    (ok event-id)
  )
)

;; Join event
(define-public (join-event (event-id uint))
  (let ((participant tx-sender))
    (asserts! (is-community-member participant) (err u403))
    (match (map-get? community-events { event-id: event-id })
      event-data (begin
        (asserts! (is-eq (get status event-data) "open") (err u400))
        (asserts! (< (get current-participants event-data) (get max-participants event-data)) (err u401))
        (map-set community-events
          { event-id: event-id }
          (merge event-data { current-participants: (+ (get current-participants event-data) u1) })
        )
        (ok true)
      )
      (err u404)
    )
  )
)

;; Helper functions
(define-private (is-community-member (member principal))
  (is-some (map-get? community-members { member: member }))
)

(define-private (update-reputation (member principal) (rating uint))
  (match (map-get? community-members { member: member })
    member-data (let
      (
        (current-score (get reputation-score member-data))
        (new-score (calculate-new-reputation current-score rating))
      )
      (map-set community-members
        { member: member }
        (merge member-data
          {
            reputation-score: new-score,
            community-level: (get-community-level new-score)
          }
        )
      )
    )
    false
  )
)

(define-private (calculate-new-reputation (current-score uint) (rating uint))
  (let ((adjustment (if (> rating u3) u5 (if (< rating u3) (- u0 u5) u0))))
    (if (> current-score u5)
      (+ current-score adjustment)
      (if (< adjustment u0) u0 (+ current-score adjustment))
    )
  )
)

(define-private (get-community-level (score uint))
  (if (>= score u500)
    "platinum"
    (if (>= score u300)
      "gold"
      (if (>= score u150)
        "silver"
        "bronze"
      )
    )
  )
)

;; Read-only functions
(define-read-only (get-member-info (member principal))
  (map-get? community-members { member: member })
)

(define-read-only (get-review-info (review-id uint))
  (map-get? community-reviews { review-id: review-id })
)

(define-read-only (get-event-info (event-id uint))
  (map-get? community-events { event-id: event-id })
)

(define-read-only (get-member-reputation (member principal))
  (match (map-get? community-members { member: member })
    member-data (get reputation-score member-data)
    u0
  )
)
