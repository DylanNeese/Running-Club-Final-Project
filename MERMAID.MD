### Mermaid ER Diagram

```mermaid
erDiagram
    Members {
        INT member_id PK
        VARCHAR(50) first_name
        VARCHAR(50) last_name
        CHAR(1) gender
        DATE birth_date
        DATE join_date
        VARCHAR(100) email
    }

    Races {
        INT race_id PK
        VARCHAR(100) race_name
        DATE race_date
        VARCHAR(100) location
        DECIMAL(5,2) distance_km
    }

    RaceResults {
        INT result_id PK
        INT member_id FK
        INT race_id FK
        TIME finish_time
        INT overall_place
        INT age_group_place
    }

    Members ||--o{ RaceResults : participates
    Races ||--o{ RaceResults : hosts

    RaceResults }o--|| Members : "references member_id"
    RaceResults }o--|| Races : "references race_id"
