-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_poll labisl_v1_poll_id
-- Type: CONSTRAINT

-- Name: labisl_v1_poll labisl_v1_poll_id; Type: CONSTRAINT; Schema: labisl_v1; Owner: -
--

ALTER TABLE ONLY labisl_v1.labisl_v1_poll
    ADD CONSTRAINT labisl_v1_poll_id PRIMARY KEY (poll_id);


--
