# Integration Pattern Library

Reference catalog of integration patterns. Use to select the appropriate pattern for a given scenario.

---

## Pattern 1: API-Led Connectivity

**When to Use**: Multiple consumers need access to same data/functionality. Need reusability and governance.

**Architecture**:
```
[Consumers] --> [Experience APIs] --> [Process APIs] --> [System APIs] --> [Backend Systems]
```

**Layers**:
- **System API**: Direct system access, standardized interface (1 per system)
- **Process API**: Business logic, orchestration, data composition (1 per process)
- **Experience API**: Channel-specific formatting (1 per consumer type)

**Strengths**: Reusability, governance, scalability, clear separation of concerns
**Weaknesses**: Complexity for simple integrations, latency from multiple hops
**Best For**: Enterprise integrations with multiple consumers, API programs
**Avoid When**: Simple point-to-point, low volume, single consumer

---

## Pattern 2: Event-Driven Architecture

**When to Use**: Loose coupling needed, real-time reactions, multiple subscribers to same event.

**Architecture**:
```
[Producer] --> [Event Bus/Broker] --> [Consumer 1]
                                  --> [Consumer 2]
                                  --> [Consumer N]
```

**Variants**:
- **Pub/Sub**: Fan-out to multiple subscribers
- **Event Sourcing**: Store events as source of truth
- **CQRS**: Separate read/write models

**Strengths**: Loose coupling, scalability, real-time processing, extensibility
**Weaknesses**: Eventual consistency, debugging complexity, message ordering challenges
**Best For**: Real-time notifications, microservices, audit trails, high throughput
**Avoid When**: Strong consistency required, simple request-response, low volume

---

## Pattern 3: Hub-and-Spoke (ESB/iPaaS)

**When to Use**: Central management needed, many-to-many system connections, transformation-heavy.

**Architecture**:
```
[System A] <--> [Central Hub (iPaaS/ESB)] <--> [System B]
[System C] <--> [        Routes         ] <--> [System D]
```

**Strengths**: Central management, routing, transformation, monitoring
**Weaknesses**: Single point of failure (if not HA), vendor dependency, complexity
**Best For**: Enterprise integration platform, B2B, heterogeneous systems
**Avoid When**: Low system count, already event-driven, latency-sensitive

---

## Pattern 4: ETL/ELT (Batch)

**When to Use**: Large volume data movement, analytics/reporting, scheduled processing.

**Architecture**:
```
[Source] --> [Extract] --> [Transform] --> [Load] --> [Target/Warehouse]
  OR
[Source] --> [Extract] --> [Load] --> [Transform in Target] --> [Ready]
```

**ETL vs ELT**:
- **ETL**: Transform before loading (when target has limited compute)
- **ELT**: Load then transform (when target is cloud DW with compute power)

**Strengths**: Handle large volumes, complex transformations, historical data
**Weaknesses**: Latency (batch windows), data staleness, resource intensive
**Best For**: Data warehousing, analytics, migration, bulk sync
**Avoid When**: Real-time needed, low volume, simple data

---

## Pattern 5: Request-Reply (Synchronous)

**When to Use**: Immediate response needed, simple interactions, user-facing operations.

**Architecture**:
```
[Client] --request--> [Service] --response--> [Client]
```

**Strengths**: Simple, immediate feedback, easy to debug
**Weaknesses**: Tight coupling, blocking, scalability limits, cascading failures
**Best For**: User-facing API calls, lookups, validations, simple CRUD
**Avoid When**: Long-running operations, high volume, multiple downstream calls

---

## Pattern 6: Saga (Distributed Transactions)

**When to Use**: Multi-step business transactions across services, need consistency without distributed locks.

**Variants**:
- **Choreography**: Services react to events, no central coordinator
- **Orchestration**: Central coordinator directs saga steps

**Architecture (Orchestration)**:
```
[Saga Orchestrator] --> Step 1: Reserve Inventory
                    --> Step 2: Process Payment
                    --> Step 3: Ship Order
                    --> Compensate on failure (reverse steps)
```

**Strengths**: Distributed consistency, clear failure handling, auditable
**Weaknesses**: Complexity, compensation logic, eventual consistency
**Best For**: Order processing, multi-service transactions, booking systems
**Avoid When**: Single service, simple operations, strong consistency available

---

## Pattern 7: Change Data Capture (CDC)

**When to Use**: Sync data changes from database without modifying source application.

**Architecture**:
```
[Source DB] --log--> [CDC Tool] --events--> [Consumers]
                     (Debezium)
```

**Strengths**: No source modification, real-time, low impact on source
**Weaknesses**: Schema coupling to DB, infrastructure complexity, ordering challenges
**Best For**: Database replication, cache invalidation, audit logging, legacy system integration
**Avoid When**: Source provides API, simple data needs, no DB access

---

## Pattern Selection Guide

| Requirement | Recommended Pattern |
|------------|-------------------|
| Multiple consumers, reusability | API-Led Connectivity |
| Real-time, loose coupling | Event-Driven |
| Central management, many systems | Hub-and-Spoke |
| Large volume, batch processing | ETL/ELT |
| Simple, immediate response | Request-Reply |
| Multi-step transactions | Saga |
| Database sync without code change | CDC |
| Combination (common) | API-Led + Event-Driven (hybrid) |

## Anti-Pattern Awareness

| Anti-Pattern | Why It's Bad | Better Alternative |
|-------------|-------------|-------------------|
| Point-to-point spaghetti | Unmaintainable, N*(N-1)/2 connections | Hub-and-spoke or API-led |
| Shared database integration | Tight coupling, schema changes break consumers | API or event-driven |
| Synchronous chaining | Cascading failures, latency multiplication | Async with events or saga |
| Big-bang integration | All-or-nothing, high risk | Phased approach, strangler fig |
| Chatty interfaces | Performance death by 1000 API calls | Batch endpoints, GraphQL, coarse APIs |
