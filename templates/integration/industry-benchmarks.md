# Industry Benchmarks for Integration Maturity

Reference benchmarks by sector and integration complexity. Use for comparison in scorecards.

## By Sector

### Financial Services
| Dimension | Typical Score | Notes |
|-----------|-------------|-------|
| Architecture | 3.5 | API-led common, strong governance |
| Data Quality | 3.2 | Regulatory pressure drives quality |
| Operations | 3.8 | Heavy investment in monitoring |
| Reliability | 3.5 | High availability requirements |
| Security | 4.0 | Regulatory requirements (PCI, SOX) |
| Business Impact | 3.5 | BIA well-established |
| Maintainability | 3.0 | Legacy systems drag down scores |
| Platform | 3.2 | Mix of modern and legacy |
| **Average** | **3.5** | **Typically Level 3-4** |

### Healthcare
| Dimension | Typical Score | Notes |
|-----------|-------------|-------|
| Architecture | 2.8 | Mixed patterns, HL7/FHIR transition |
| Data Quality | 3.0 | Data standards (HL7, FHIR) help |
| Operations | 2.5 | Often understaffed |
| Reliability | 2.8 | Critical but often under-invested |
| Security | 3.5 | HIPAA drives security investment |
| Business Impact | 3.0 | Patient safety awareness |
| Maintainability | 2.5 | Legacy EHR systems |
| Platform | 2.8 | Specialized integration engines |
| **Average** | **2.9** | **Typically Level 2-3** |

### Retail / E-Commerce
| Dimension | Typical Score | Notes |
|-----------|-------------|-------|
| Architecture | 3.2 | Microservices adoption growing |
| Data Quality | 2.8 | Product data complexity |
| Operations | 3.5 | Strong monitoring culture |
| Reliability | 3.2 | Revenue pressure drives investment |
| Security | 3.0 | PCI compliance, but variable |
| Business Impact | 3.0 | Revenue correlation well-understood |
| Maintainability | 3.2 | Modern tech stacks common |
| Platform | 3.0 | Cloud-native trend |
| **Average** | **3.1** | **Typically Level 3** |

### Manufacturing
| Dimension | Typical Score | Notes |
|-----------|-------------|-------|
| Architecture | 2.5 | OT/IT convergence challenges |
| Data Quality | 2.5 | IoT data complexity, legacy protocols |
| Operations | 2.2 | OT monitoring different from IT |
| Reliability | 2.8 | Safety-critical drives reliability |
| Security | 2.5 | Air-gapped systems, evolving |
| Business Impact | 2.8 | Downtime cost well-known |
| Maintainability | 2.0 | Legacy systems, long lifecycle |
| Platform | 2.5 | Specialized SCADA/MES systems |
| **Average** | **2.5** | **Typically Level 2** |

### Technology / SaaS
| Dimension | Typical Score | Notes |
|-----------|-------------|-------|
| Architecture | 3.8 | API-first, event-driven |
| Data Quality | 3.5 | Schema-driven development |
| Operations | 4.0 | SRE culture, observability stack |
| Reliability | 3.8 | SLO-driven, chaos engineering |
| Security | 3.5 | SOC 2, security-aware culture |
| Business Impact | 3.2 | Uptime is the product |
| Maintainability | 4.0 | CI/CD mature, testing culture |
| Platform | 3.5 | Cloud-native, modern stacks |
| **Average** | **3.7** | **Typically Level 3-4** |

## By Integration Complexity

### Simple Integration
Single source, single target, <10 fields, no transformation, batch OK.

| Dimension | Expected Minimum |
|-----------|-----------------|
| Architecture | 2 |
| Data Quality | 2 |
| Operations | 2 |
| Reliability | 2 |
| Security | 3 |
| Business Impact | 1 |
| Maintainability | 2 |
| Platform | 2 |

### Medium Integration
Multiple sources/targets, 10-50 fields, moderate transformation, near-real-time.

| Dimension | Expected Minimum |
|-----------|-----------------|
| Architecture | 3 |
| Data Quality | 3 |
| Operations | 3 |
| Reliability | 3 |
| Security | 3 |
| Business Impact | 2 |
| Maintainability | 3 |
| Platform | 3 |

### Complex Integration
Many systems, 50+ fields, complex transformation, real-time, multi-step orchestration.

| Dimension | Expected Minimum |
|-----------|-----------------|
| Architecture | 4 |
| Data Quality | 4 |
| Operations | 4 |
| Reliability | 4 |
| Security | 4 |
| Business Impact | 3 |
| Maintainability | 3 |
| Platform | 3 |
