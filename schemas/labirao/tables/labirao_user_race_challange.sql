-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_user_race_challange
-- Type: TABLE

-- Name: labirao_user_race_challange; Type: TABLE; Schema: labirao; Owner: -
--

CREATE TABLE labirao.labirao_user_race_challange (
    user_guid text,
    user_id numeric,
    hash_email_address text,
    distance_class text,
    actual_distance_in_meters numeric,
    actual_elapsed_time_in_seconds numeric,
    average_pace_minutes_per_mile numeric,
    average_pace_minutes_per_km numeric,
    date_of_birth text,
    race_type text,
    qualifying_trip_activity_id text,
    date_completed text,
    approximate_distance_completed text,
    avg_pace text,
    cadence_steps_per_min text,
    time_spent_paused_in_seconds text,
    challanger_guid character varying,
    user_name text,
    is_qualified numeric,
    is_video_generated numeric,
    mail_sent numeric,
    email_type numeric
);


--
