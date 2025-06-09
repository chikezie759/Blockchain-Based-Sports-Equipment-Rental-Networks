;; Equipment Owner Verification Contract
;; Validates and manages sports equipment owners

(define-map equipment-owners
  { owner: principal }
  {
    verified: bool,
    registration-date: uint,
    equipment-count: uint
  }
)

(define-map equipment-registry
  { equipment-id: uint }
  {
    owner: principal,
    equipment-type: (string-ascii 50),
    brand: (string-ascii 50),
    model: (string-ascii 50),
    purchase-date: uint,
    verified: bool
  }
)

(define-data-var next-equipment-id uint u1)

;; Register as equipment owner
(define-public (register-owner)
  (let ((caller tx-sender))
    (map-set equipment-owners
      { owner: caller }
      {
        verified: false,
        registration-date: block-height,
        equipment-count: u0
      }
    )
    (ok true)
  )
)

;; Verify equipment owner (admin function)
(define-public (verify-owner (owner principal))
  (begin
    (asserts! (is-eq tx-sender contract-caller) (err u401))
    (match (map-get? equipment-owners { owner: owner })
      owner-data (begin
        (map-set equipment-owners
          { owner: owner }
          (merge owner-data { verified: true })
        )
        (ok true)
      )
      (err u404)
    )
  )
)

;; Register equipment
(define-public (register-equipment (equipment-type (string-ascii 50)) (brand (string-ascii 50)) (model (string-ascii 50)))
  (let
    (
      (equipment-id (var-get next-equipment-id))
      (caller tx-sender)
    )
    (asserts! (is-owner-verified caller) (err u403))
    (map-set equipment-registry
      { equipment-id: equipment-id }
      {
        owner: caller,
        equipment-type: equipment-type,
        brand: brand,
        model: model,
        purchase-date: block-height,
        verified: false
      }
    )
    (var-set next-equipment-id (+ equipment-id u1))
    (update-equipment-count caller)
    (ok equipment-id)
  )
)

;; Helper functions
(define-private (is-owner-verified (owner principal))
  (match (map-get? equipment-owners { owner: owner })
    owner-data (get verified owner-data)
    false
  )
)

(define-private (update-equipment-count (owner principal))
  (match (map-get? equipment-owners { owner: owner })
    owner-data (map-set equipment-owners
      { owner: owner }
      (merge owner-data { equipment-count: (+ (get equipment-count owner-data) u1) })
    )
    false
  )
)

;; Read-only functions
(define-read-only (get-owner-info (owner principal))
  (map-get? equipment-owners { owner: owner })
)

(define-read-only (get-equipment-info (equipment-id uint))
  (map-get? equipment-registry { equipment-id: equipment-id })
)
