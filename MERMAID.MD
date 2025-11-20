```mermaid
erDiagram
    Members {
        int member_id PK
        varchar first_name
        varchar last_name
        char gender
        date birth_date
        date join_date
        varchar email
    }
    Races {
        int race_id PK
        varchar race_name
        date race_date
        varchar location
        decimal distance_km
    }
    RaceResults {
        int result_id PK
        int member_id FK
        int race_id FK
        time finish_time
        int overall_place
        int age_group_place
    }

    Members ||--o{ RaceResults : "participates in"
    Races ||--o{ RaceResults : "hosts"

    RaceResults }o--|| Members : "member_id"
    RaceResults }o--|| Races : "race_id"
