-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_poll labdd_v1_poll_id
-- Type: CONSTRAINT

-- Name: labdd_v1_poll labdd_v1_poll_id; Type: CONSTRAINT; Schema: labdd_v1; Owner: -
--

ALTER TABLE ONLY labdd_v1.labdd_v1_poll
    ADD CONSTRAINT labdd_v1_poll_id PRIMARY KEY (poll_id);


--
