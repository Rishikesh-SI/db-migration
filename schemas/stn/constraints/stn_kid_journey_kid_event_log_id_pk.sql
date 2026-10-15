-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_kid_journey kid_event_log_id_pk
-- Type: CONSTRAINT

-- Name: stn_kid_journey kid_event_log_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_kid_journey
    ADD CONSTRAINT kid_event_log_id_pk PRIMARY KEY (kid_journey_id);


--
